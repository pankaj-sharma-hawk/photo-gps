import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class PhotoGpsDemoFirebaseUser {
  PhotoGpsDemoFirebaseUser(this.user);
  User? user;
  bool get loggedIn => user != null;
}

PhotoGpsDemoFirebaseUser? currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<PhotoGpsDemoFirebaseUser> photoGpsDemoFirebaseUserStream() =>
    FirebaseAuth.instance
        .authStateChanges()
        .debounce((user) => user == null && !loggedIn
            ? TimerStream(true, const Duration(seconds: 1))
            : Stream.value(user))
        .map<PhotoGpsDemoFirebaseUser>(
      (user) {
        currentUser = PhotoGpsDemoFirebaseUser(user);
        return currentUser!;
      },
    );
