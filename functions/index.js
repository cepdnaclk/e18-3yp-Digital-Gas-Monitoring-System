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
        doc.ref.update({isReadYesterday: false}),
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

  // Map the number to the name of the day
  const daysOfWeek = ["sun", "mon", "tue", "wed", "thu", "fri", "sat"];
  const today = daysOfWeek[dayOfWeek];


  console.log(today);
  console.log(data);
  console.log(documentId);
  documentId = "0C:B8:15:EC:A8:94";
  const snapshot = await firebase
      .firestore()
      .collection("gases")
      .doc(documentId)
      .get();


  console.log("Current Gas Level is " + snapshot.get("gasLevel"));

  const updatedData = {};
  // eslint-disable-next-line max-len
  updatedData[`thisWeek.${today}`] =parseFloat((snapshot.get("gasLevel") - parseFloat(data)).toFixed(3));
  updatedData["gasLevel"] = parseFloat(data);


  return firebase.firestore().collection("gases").doc(documentId).update(updatedData).then(()=>{
    res.send("Data successfully updated");
  })
      .catch((error)=>{
        res.status(500).send(error);
      });
});

