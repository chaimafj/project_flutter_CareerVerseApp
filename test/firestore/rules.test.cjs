const { before, after, beforeEach, test } = require('node:test');
const { readFileSync } = require('node:fs');
const { join } = require('node:path');
const {
  initializeTestEnvironment, assertSucceeds, assertFails,
} = require('@firebase/rules-unit-testing');
const {
  doc, getDoc, setDoc, updateDoc, deleteDoc, getDocs, collection,
  collectionGroup,
} = require('firebase/firestore');

let env;
before(async () => {
  const [host, port] = (process.env.FIRESTORE_EMULATOR_HOST || '127.0.0.1:8097').split(':');
  env = await initializeTestEnvironment({
    projectId: 'demo-careerverse',
    firestore: {
      host, port: Number(port),
      rules: readFileSync(join(__dirname, '..', '..', 'firestore.rules'), 'utf8'),
    },
  });
});
after(async () => { if (env) await env.cleanup(); });

const profile = {
  name: 'Student', email: 'student@example.test', updatedAt: null,
};
const career = {
  id: 'test-career', archived: false,
  variants: { en: {}, fr: {}, ar: {} },
};
const db = (uid) => env.authenticatedContext(uid).firestore();

beforeEach(async () => {
  await env.clearFirestore();
  await env.withSecurityRulesDisabled(async (context) => {
    const store = context.firestore();
    await setDoc(doc(store, 'admins/admin'), { active: true });
    await setDoc(doc(store, 'admins/revoked'), { active: false });
    await setDoc(doc(store, 'users/student'), { profile });
    await setDoc(doc(store, 'users/another'), {
      profile: { ...profile, email: 'another@example.test' },
    });
    await setDoc(doc(store, 'users/student/results/result'), { score: 80 });
    await setDoc(doc(store, 'catalog/test-career'), career);
  });
});

test('ordinary users cannot grant or modify admin roles', async () => {
  await assertFails(setDoc(doc(db('student'), 'admins/student'), { active: true }));
  await assertFails(updateDoc(doc(db('admin'), 'admins/admin'), { active: true }));
  await assertFails(deleteDoc(doc(db('admin'), 'admins/admin')));
  await assertSucceeds(getDoc(doc(db('student'), 'admins/student')));
  await assertFails(getDoc(doc(db('student'), 'admins/admin')));
});

test('student profile and result privacy is preserved', async () => {
  await assertSucceeds(getDoc(doc(db('student'), 'users/student')));
  await assertSucceeds(updateDoc(doc(db('student'), 'users/student'), {
    profile: { ...profile, name: 'Edited by owner' },
  }));
  await assertFails(getDoc(doc(db('student'), 'users/another')));
  await assertFails(getDocs(collection(db('student'), 'users')));
  await assertFails(getDocs(collectionGroup(db('student'), 'results')));
  await assertFails(updateDoc(doc(db('student'), 'users/another'), { profile }));
});

test('admin can edit profiles but cannot change email or other user data', async () => {
  await assertSucceeds(getDocs(collection(db('admin'), 'users')));
  await assertSucceeds(updateDoc(doc(db('admin'), 'users/student'), {
    profile: { ...profile, name: 'Edited by admin' },
    updatedAt: 'now',
  }));
  await assertFails(updateDoc(doc(db('admin'), 'users/student'), {
    profile: { ...profile, email: 'replacement@example.test' },
  }));
  await assertFails(updateDoc(doc(db('admin'), 'users/student'), { premium: true }));
  await assertFails(deleteDoc(doc(db('admin'), 'users/student')));
  await assertFails(setDoc(doc(db('admin'), 'users/new-student'), { profile }));
});

test('only active admins may publish or archive catalogue content', async () => {
  await assertSucceeds(getDocs(collection(db('student'), 'catalog')));
  await assertFails(updateDoc(doc(db('student'), 'catalog/test-career'), { archived: true }));
  await assertFails(updateDoc(doc(db('revoked'), 'catalog/test-career'), { archived: true }));
  await assertSucceeds(updateDoc(doc(db('admin'), 'catalog/test-career'), { archived: true }));
  await assertFails(deleteDoc(doc(db('admin'), 'catalog/test-career')));
  await assertFails(setDoc(doc(db('admin'), 'catalog/invalid'), career));
  await assertSucceeds(setDoc(doc(db('admin'), 'catalog/english-only'), {
    id: 'english-only', archived: false, variants: { en: {} },
  }));
  await assertFails(setDoc(doc(db('admin'), 'catalog/no-english'), {
    id: 'no-english', archived: false, variants: { fr: {}, ar: {} },
  }));
});

test('admin statistics are read-only; unauthenticated users have no access', async () => {
  await assertSucceeds(getDocs(collectionGroup(db('admin'), 'results')));
  await assertFails(updateDoc(doc(db('admin'), 'users/student/results/result'), { score: 100 }));
  await assertFails(getDoc(doc(env.unauthenticatedContext().firestore(), 'catalog/test-career')));
  await assertFails(getDoc(doc(env.unauthenticatedContext().firestore(), 'users/student')));
});

test('admin can remove student data while preventing resurrection and protecting admins', async () => {
  const tombstone = { deleted: true, cleanupPending: true };
  await assertFails(setDoc(doc(db('student'), 'users/student'), tombstone));
  await assertFails(setDoc(doc(db('revoked'), 'users/student'), tombstone));
  await assertFails(setDoc(doc(db('admin'), 'users/admin'), tombstone));
  await env.withSecurityRulesDisabled(async (context) => {
    await setDoc(doc(context.firestore(), 'users/admin'), { profile });
    await setDoc(doc(context.firestore(), 'users/student/transactions/payment'), {
      id: 'payment', amountCents: 499, status: 'succeeded',
    });
  });
  await assertFails(setDoc(doc(db('admin'), 'users/admin'), tombstone));
  await assertFails(deleteDoc(doc(db('admin'), 'users/student/transactions/payment')));
  await assertSucceeds(setDoc(doc(db('admin'), 'users/student'), tombstone));
  await assertSucceeds(deleteDoc(doc(db('admin'), 'users/student/results/result')));
  await assertSucceeds(deleteDoc(doc(db('admin'), 'users/student/transactions/payment')));
  await assertSucceeds(getDoc(doc(db('student'), 'users/student')));
  await assertFails(setDoc(doc(db('student'), 'users/student'), { profile }));
  await assertFails(deleteDoc(doc(db('student'), 'users/student')));
  await assertFails(setDoc(doc(db('student'), 'users/student/results/reupload'), { score: 80 }));
  await assertSucceeds(setDoc(doc(db('admin'), 'users/student'), {
    deleted: true, cleanupPending: false,
  }));
});

test('career deletion markers block reuploads and cannot be restored by clients', async () => {
  const marker = { id: 'test-career', deleted: true, labIds: ['test-career-1'], cleanupPending: true };
  await assertFails(setDoc(doc(db('student'), 'catalog/test-career'), marker));
  await assertSucceeds(setDoc(doc(db('admin'), 'catalog/test-career'), marker));
  await assertSucceeds(setDoc(doc(db('admin'), 'deletedLabs/test-career-1'), { deleted: true }));
  await assertFails(setDoc(doc(db('admin'), 'catalog/test-career'), career));
  await assertFails(deleteDoc(doc(db('student'), 'deletedLabs/test-career-1')));
  await assertFails(setDoc(doc(db('student'), 'users/student/results/new'), {
    careerId: 'test-career', labId: 'test-career-1', score: 80,
  }));
  await assertFails(setDoc(doc(db('student'), 'users/student/courses/test-career-1'), {
    labId: 'test-career-1',
  }));
  await assertFails(setDoc(doc(db('student'), 'users/student/recommendations/new'), {
    careerId: 'test-career',
  }));
  await assertFails(setDoc(doc(db('student'), 'users/student/notifications/new'), {
    data: { labId: 'test-career-1' },
  }));
  await assertSucceeds(setDoc(doc(db('student'), 'users/student/results/unrelated'), {
    careerId: 'java', labId: 'java-1', score: 80,
  }));
  await assertSucceeds(deleteDoc(doc(db('admin'), 'users/student/results/result')));
});
