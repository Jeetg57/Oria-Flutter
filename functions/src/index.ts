import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';

// // Start writing Firebase Functions
// // https://firebase.google.com/docs/functions/typescript
//
// export const helloWorld = functions.https.onRequest((request, response) => {
//   functions.logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });

admin.initializeApp();
const db = admin.firestore();
const fcm = admin.messaging();


export const sendAppointmentChangedNotification = functions.firestore
.document('appointments/{appointmentId}')
.onUpdate(async snapshot => {
    const appointment = snapshot.after.data();
    const querySnapshot = await db
    .collection('users')
    .doc(appointment.userId)
    .collection("tokens")
    .get();
    const tokens = querySnapshot.docs.map(snap=> snap.id);
    const payload: admin.messaging.MessagingPayload = {
        notification: {
            title: `One of your appointments has been ${appointment.approval}`,
            body: "There has been a change in your appointment, Click to view more",
            clickAction: 'FLUTTER_NOTIFICATION_CLICK'
        }
    }
    return fcm.sendToDevice(tokens, payload);
});
