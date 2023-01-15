const functions = require("firebase-functions");
const firebase = require("firebase-admin");
const moment = require("moment-timezone");

firebase.initializeApp();

exports.makeReadingFalse = functions.pubsub
    .schedule("00 22 * * *")
    .timeZone("Asia/Colombo")
    .onRun(async (context) => {
      console.log("updateField function is called");
      const snapshot = await firebase
          .firestore()
          .collection("gases")
          .where("isAvailable", "==", true)
          .get();
      const promises = snapshot.docs.map((doc) =>
        doc.ref.update({"isReadYesterday": false}),
      );
      return Promise.all(promises);
    });

exports.readGasLevel = functions.https.onRequest(async (req, res) => {
  // retrieve the data and document id from the request
  const data = req.body.data;
  let documentId = req.body.gasId;

  const time = moment().tz("Asia/Colombo");

  // Get the day of the week as a number (0-6)
  const dayOfWeek = time.day();
  const month = time.month();


  // Map the number to the name of the day
  const daysOfWeek = ["sun", "mon", "tue", "wed", "thu", "fri", "sat"];
  // eslint-disable-next-line max-len
  const months = ["jan", "feb", "mar", "apr", "may", "jun", "jul", "aug", "sep", "oct", "nov", "dec"];
  const today = daysOfWeek[dayOfWeek];
  const thisMonth = months[month];

  console.log(today);
  console.log(data);
  console.log(documentId);
  documentId = "0C:B8:15:EC:A8:94";
  const snapshot = await firebase
      .firestore()
      .collection("gases")
      .doc(documentId)
      .get();

  if (!snapshot.get("isReadYesterday")) {
    console.log("Current Gas Level is " + snapshot.get("gasLevel"));

    const updatedData = {};

    const consumedLevel = parseFloat((snapshot.get("gasLevel") - parseFloat(data)).toFixed(3));
    // eslint-disable-next-line max-len
    updatedData[`thisWeek.${today}`] =consumedLevel;
    updatedData["gasLevel"] = parseFloat(data);
    updatedData[`weekStats.${today}`] = snapshot.get(`weekStats.${today}`)+consumedLevel;
    updatedData[`monthStats.${thisMonth}`] = snapshot.get(`monthStats.${thisMonth}`) + consumedLevel;
    updatedData["isReadYesterday"] = true;


    return firebase.firestore().collection("gases").doc(documentId).update(updatedData).then(()=>{
      res.send("Data successfully updated");
    })
        .catch((error)=>{
          res.status(500).send(error);
        });
  } else {
    return res.status(204).send("Data already added");
  }
});


exports.copyData = functions.https.onRequest((request, response) => {
  const gasId = request.body.gasId;
  const sourceDocRef = firebase.firestore().collection("gases").doc("0C:B8:15:EC:A8:94");
  const targetDocRef = firebase.firestore().collection("gases").doc(gasId);
  sourceDocRef.get()
      .then((doc) => {
        if (!doc.exists) {
          response.status(404).send("Source document does not exist.");
        } else {
          targetDocRef.set(doc.data())
              .then(() => {
                response.status(200).send("Data copied successfully.");
              })
              .catch((error) => {
                response.status(500).send(`Error copying data: ${error}`);
              });
        }
      })
      .catch((error) => {
        response.status(500).send(`Error getting source document: ${error}`);
      });
});


exports.fakeUserData = functions.https.onRequest((request, response)=>{
  firebase.firestore().collection("users").doc("f8wjSZ5t2GTZtulKrboOzYx1hEh2").update(
      {
        "gases": ["0C:B8:15:EC:A8:94", "3A:82:D0:DA:90:8A"],
      },
  );
});


exports.getDataFromFirestore = functions.https.onRequest((request, response) => {
  const path = "gases/0C:B8:15:EC:A8:94";

  firebase.firestore().doc(path).get()
      .then((doc) => {
        if (!doc.exists) {
          response.status(404).send("Document not found");
          return;
        }
        const data = doc.data();
        response.status(200).json(data);
      })
      .catch((err) => {
        response.status(500).send(err);
      });
});
