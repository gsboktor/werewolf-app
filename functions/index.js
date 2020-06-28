// Set up admin
const admin = require('firebase-admin');
admin.initializeApp();

// Init functions and database
const functions = require('firebase-functions');
const db = admin.firestore();

// Sets the roles for each player for each game ID
function setRoles(gameID){

    // Set reference to doc with game ID
    const docRef = db.collection(gameID).doc('playerRoles');

    // Get all the information nessesary and then set the roles
    docRef.get().then(doc => {

        // Get the current doc data
        var data = doc.data();

        // Dict for roles for each user
        var userRoles = {}

        // Get all the roles, the users, and the host
        var roles = data['roles'];
        var host = data['host'];
        usersArr = Object.keys(data['users']);
        usersArr = usersArr.filter(function(e) { return e !== host });

        // Assign each role to a user
        for (var key in roles) {
            for (i = 0; i < roles[key]; i++) {
                u = usersArr[Math.floor(Math.random() * usersArr.length)];
                usersArr = usersArr.filter(function(e) { return e !== u });
                userRoles[u] = [key];
            }
        }

        // Update the roles map
        db.collection(gameID).doc('playerRoles').update({
            userRoles: userRoles
        });
    });
}

// Cloud function to set the roles of each game ID
exports.seeChanges = functions.firestore.document('{gameID}/gameRules').onUpdate((change, context) => {

    // Make sure it's time to set the roles and set them
    const body = change.after.data()
    if (body['setRoles'] == true){
        setRoles(context.params.gameID)
    }
})