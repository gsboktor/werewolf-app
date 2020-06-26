const admin = require('firebase-admin');
const functions = require('firebase-functions');

admin.initializeApp();

export const helloWorld = functions.https.onRequest((request: any, response: any) => {
    console.log("Hello World Here");
 response.send("Hello from Firebase!");
});

exports.setRoles = functions.firestore.document('{gameID}/{userID}').onUpdate((change: any, context: any) => {
  console.log(context.params.gameID, context.params.userID);
})