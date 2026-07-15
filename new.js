rules_version = '2';
service firebase.storage {
  match /b/{bucket}/o {
    // Allow managing all files and folders
    match /{allPaths=**} {
      allow read, write, list: if request.auth != null &&(firestore.get(/databases/(default)/documents/users/$(request.auth.uid)).data.is_developer == true ||
         firestore.get(/databases/(default)/documents/users/$(request.auth.uid)).data.is_developer == "true");
    }
  }
}