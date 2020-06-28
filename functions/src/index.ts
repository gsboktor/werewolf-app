const admin = require('firebase-admin');
const functions = require('firebase-functions');
const db = admin.firestore();

admin.initializeApp();

function readRolesData(gameID: String){
  const docRef = db.collection(gameID).doc('playerRoles');
  docRef.get()
    .then(doc => {
      if (!doc.exists) {
        console.log('No such document!');
      } 
      console.log(doc.data());
    });
}

export const helloWorld = functions.https.onRequest((request: any, response: any) => {
    console.log("Hello World Here");
 response.send("Hello from Firebase!");
});

exports.setRoles = functions.firestore.document('{gameID}/{userID}').onUpdate((change: any, context: any) => {
  console.log(context.params.gameID, context.params.userID);
})

exports.seeChanges = functions.firestore.document('{gameID}/gameRules').onUpdate((change: any, context: any) => {
  const body = change.after.data()
  if (body['setRoles'] == true){
      readRolesData(context.params.gameID)
      console.log("here set roles changed");
  }
})