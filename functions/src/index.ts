// // Start writing Firebase Functions
// // https://firebase.google.com/docs/functions/typescript
//

const admin = require('firebase-admin');
const functions = require('firebase-functions');

admin.initializeApp();

const firestore = admin.firestore();

export const helloWorld = functions.https.onRequest((request: any, response: any) => {
    console.log("Hello World Here");
 response.send("Hello from Firebase!");
});

exports.setRoles = functions.firestore.document('Games/{gameID}').onUpdate((change: any, context: any) => {
    console.log('Set Roles Here');
})

exports.getWatsonTokenFS = functions.firestore
  .document('users/{userId}/{messageCollectionId}/{messageId}')
  .onWrite((snap: any, context: any) => {
    console.log("here from get watson");
    return firestore.doc(`IBM_Watson_Token/Token_Value`).update('token');
});