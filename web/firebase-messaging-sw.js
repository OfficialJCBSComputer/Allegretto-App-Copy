importScripts("https://www.gstatic.com/firebasejs/10.7.0/firebase-app-compat.js");
importScripts("https://www.gstatic.com/firebasejs/10.7.0/firebase-messaging-compat.js");

firebase.initializeApp({
  apiKey: "AIzaSyBYKeGYvpWGkB1My108inVbwgH_KCdTExg",
  authDomain: "allegretto-dff3d.firebaseapp.com",
  projectId: "allegretto-dff3d",
  storageBucket: "allegretto-dff3d.firebasestorage.app",
  messagingSenderId: "175303218730",
  appId: "1:175303218730:web:807142bd6b885340dd5553"
});

const messaging = firebase.messaging();

// Handles background notifications
messaging.onBackgroundMessage((payload) => {
  console.log("[firebase-messaging-sw.js] Received background message ", payload);

  const notificationTitle = payload.notification?.title || payload.data?.title || "Allegretto Update";
  const notificationOptions = {
    body: payload.notification?.body || payload.data?.body || "Check the app for details.",
    icon: "/favicon.png",
    badge: "/favicon.png",
    data: payload.data
  };

  return self.registration.showNotification(notificationTitle, notificationOptions);
});

// Handle notification click in background
self.addEventListener('notificationclick', (event) => {
  event.notification.close();
  event.waitUntil(
    clients.matchAll({ type: 'window', includeUncontrolled: true }).then((clientList) => {
      if (clientList.length > 0) {
        let client = clientList[0];
        for (let i = 0; i < clientList.length; i++) {
          if (clientList[i].focused) {
            client = clientList[i];
          }
        }
        return client.focus();
      }
      return clients.openWindow('/');
    })
  );
});
