import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';
admin.initializeApp();

const fcm = admin.messaging();

export const sendToTopic = functions.firestore
  .document('blogs/blogsId}')
  .onCreate(async snapshot => {
    const data = snapshot.data();

    const payload: admin.messaging.MessagingPayload = {
      notification: {
        title: 'New Blog 📢!',
        body: `${data.name} as got you  something new to read`,
        icon: 'https://play-lh.googleusercontent.com/0n4PMbZagiGATWCS2IKsib2gXYyyjcvWeNVJrXQQxFb5oXTyFmJgSiiavrOmb3mnoA=s90-rw-no-tmp_covicheck_apk.WebP',
        click_action: 'FLUTTER_NOTIFICATION_CLICK' // required only for onResume or onLaunch callbacks
      }
    };

    return fcm.sendToTopic('new_blog', payload);
  });
