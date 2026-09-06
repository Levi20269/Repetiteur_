"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.api = void 0;
const app_1 = require("firebase-admin/app");
const auth_1 = require("firebase-admin/auth");
const firestore_1 = require("firebase-admin/firestore");
const https_1 = require("firebase-functions/v2/https");
if (!(0, app_1.getApps)().length)
    (0, app_1.initializeApp)();
const db = (0, firestore_1.getFirestore)();
async function requireUser(authorization) {
    const match = authorization?.match(/^Bearer (.+)$/);
    if (!match)
        throw new Error('UNAUTHENTICATED');
    return (0, auth_1.getAuth)().verifyIdToken(match[1]);
}
function documentJson(id, value) {
    return {
        id,
        ...value,
        completedAt: value.completedAt instanceof firestore_1.Timestamp ? value.completedAt.toDate().toISOString() : value.completedAt,
    };
}
/** API REST protégée. URL finale : https://REGION-PROJECT.cloudfunctions.net/api/subjects */
exports.api = (0, https_1.onRequest)({ region: 'europe-west1', cors: true }, async (request, response) => {
    try {
        const user = await requireUser(request.header('authorization'));
        const path = request.path.replace(/\/+$/, '') || '/';
        if (request.method === 'GET' && path === '/subjects') {
            const snapshot = await db.collection('subjects').orderBy('name').get();
            response.json(snapshot.docs.map((doc) => documentJson(doc.id, doc.data())));
            return;
        }
        const subjectMatch = path.match(/^\/subjects\/([^/]+)$/);
        if (request.method === 'GET' && subjectMatch) {
            const doc = await db.collection('subjects').doc(subjectMatch[1]).get();
            if (!doc.exists) {
                response.status(404).json({ message: 'Matière introuvable.' });
                return;
            }
            response.json(documentJson(doc.id, doc.data()));
            return;
        }
        if (request.method === 'GET' && path === '/exercises') {
            const subjectId = typeof request.query.subjectId === 'string' ? request.query.subjectId : undefined;
            let query = db.collection('exercises');
            if (subjectId)
                query = query.where('subjectId', '==', subjectId);
            const snapshot = await query.get();
            // correctAnswer reste sur le serveur : l'application ne calcule jamais son propre score.
            response.json(snapshot.docs.map((doc) => {
                const { correctAnswer, ...safe } = doc.data();
                return documentJson(doc.id, safe);
            }));
            return;
        }
        const exerciseMatch = path.match(/^\/exercises\/([^/]+)$/);
        if (request.method === 'GET' && exerciseMatch) {
            const doc = await db.collection('exercises').doc(exerciseMatch[1]).get();
            if (!doc.exists) {
                response.status(404).json({ message: 'Exercice introuvable.' });
                return;
            }
            const { correctAnswer, ...safe } = doc.data();
            response.json(documentJson(doc.id, safe));
            return;
        }
        if (request.method === 'GET' && path === '/progress') {
            const snapshot = await db.collection('progress').where('userId', '==', user.uid).orderBy('completedAt', 'desc').get();
            response.json(snapshot.docs.map((doc) => documentJson(doc.id, doc.data())));
            return;
        }
        if (request.method === 'POST' && path === '/progress') {
            const { exerciseId, answer } = request.body;
            if (typeof exerciseId !== 'string' || typeof answer !== 'string') {
                response.status(400).json({ message: 'exerciseId et answer sont requis.' });
                return;
            }
            const exercise = await db.collection('exercises').doc(exerciseId).get();
            if (!exercise.exists) {
                response.status(404).json({ message: 'Exercice introuvable.' });
                return;
            }
            const exerciseData = exercise.data();
            const isCorrect = exerciseData.correctAnswer === answer;
            const score = isCorrect ? 100 : 0;
            const progress = await db.collection('progress').add({
                userId: user.uid,
                exerciseId,
                score,
                completedAt: firestore_1.FieldValue.serverTimestamp(),
            });
            response.status(201).json({
                id: progress.id,
                score,
                isCorrect,
                explanation: exerciseData.explanation ?? '',
            });
            return;
        }
        response.status(404).json({ message: 'Endpoint introuvable.' });
        return;
    }
    catch (error) {
        if (error instanceof Error && error.message === 'UNAUTHENTICATED') {
            response.status(401).json({ message: 'Authentification requise.' });
            return;
        }
        console.error(error);
        response.status(500).json({ message: 'Erreur interne du serveur.' });
    }
});
