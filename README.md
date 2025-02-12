# Firebase Tutorial

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

## screenshots
<div>
<img src="./screenshot/signup.png" height="300">.
<img src="./screenshot/login.png" height="300">.
<img src="./screenshot/home.png" height="300">.
<img src="./screenshot/add.png" height="300">.
<img src="./screenshot/edit.png" height="300">.
</div>


## Steps:
1. pub get 
     ```
      firebase_auth: ^5.4.2
      firebase_core: ^3.11.0
     ```
2. initialise the app in main
     ```
     await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
     ```
3. Controller... setup and form validators
4. StreamBuilder... the asynchronous checking for sign in or home page.... can also user iDTokenChanges..
    ``` 
   StreamBuilder(
           stream: FirebaseAuth.instance.authStateChanges(),
           builder: (context, snapshot) {
             if (snapshot.connectionState == ConnectionState.waiting) {
               return Center(
                 child: CircularProgressIndicator(),
               );
             }
             if (snapshot.data != null) {
               return HomeScreen();
             }
             return SignUpScreen();
           },
         ),
   ```
5. - create database...
   - select fire store database
   - select location, it will not be modifiable in later...
   - create collection...

6.   add dependencies
      
      ```
      cloud_firestore: ^5.6.3
      ```
7.   create method to upload data....
8.   note.. firebase automatically creates the collection
9.   The method
   ```
   FirebaseFirestore.instance.collection('person').get();
   ``` 
   gives the ```Future<QuerySnapshot<Map<String, dynamic>>>``` value, need to restart the app for latest edit or new data
   but ```FirebaseFirestore.instance.collection('person').snapshots();``` this return the  ```Stream<QuerySnapshot<Map<String, dynamic>>>``` value which is sync to view, means it get auto updated
   also can filter the query or we can say conditional query with ``` final data = FirebaseFirestore.instance.collection('person').where('uid',isEqualTo: FirebaseAuth.instance.currentUser!.uid).snapshots();```

10. use ```firebase_storage: ^12.4.2``` for storing the images or files/ audios...

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
