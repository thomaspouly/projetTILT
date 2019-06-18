import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_app/models/Association.dart';
import 'package:flutter_app/models/NoteForm.dart';
import 'package:flutter_app/models/User.dart';
import 'package:flutter_app/provider/AuthProvider.dart';
import 'package:flutter_app/provider/StorageProvider.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:http/http.dart' as http;

class FirestoreProvider {
  Firestore _firestore = Firestore.instance;
  AuthProvider auth = AuthProvider();
  StorageProvider storage = StorageProvider();

  Future<User> getUserById(String userID) {
    return _firestore
        .collection('user')
        .document(userID)
        .get()
        .then((documentSnapshot) {
      User u = new User.fromSnapshot(documentSnapshot);
      return u;
    });
  }

  Future<User> getUserByEmail(String email) {
    return _firestore
        .collection('user')
        .getDocuments()
        .then((documentSnapshot) {
      for (int i = 0; i < documentSnapshot.documents.length; i++) {
        if (documentSnapshot.documents[i]['email'] == email) {
          User user = User.fromSnapshot(documentSnapshot.documents[i]);
          return user;
        }
      }
    });
  }

  Future<List<String>> getAllFriend() {
    return auth.currentUser().then((userID) {
      List<String> allUser = new List<String>();
      return getUserById(userID).then((userCourrant) {
        for (int i = 0; i < userCourrant.friendList.length; i++) {
          allUser.add(userCourrant.friendList[i]);
        }
        return allUser;
      });
    });
  }

  Future<User> addUserInFriendList(String email) {
    return auth.currentUser().then((userID) {
      // Récupére l'utilisateur recherché
      return getUserByEmail(email).then((userRecherche) {
        // Recupére l'utilisateur courrant en fonction de l'ID
        return getUserById(userID).then((userCourrant) {
          if (!userRecherche.friendList.contains(userID)) {
            userRecherche.friendList.add(userID);
          }
          return _firestore
              .collection('user')
              .getDocuments()
              .then((documentSnapshot) {
            for (int i = 0; i < documentSnapshot.documents.length; i++) {
              if (documentSnapshot.documents[i]['email'] == email) {
                if (!userCourrant.friendList
                    .contains(documentSnapshot.documents[i].documentID)) {
                  userCourrant.friendList
                      .add(documentSnapshot.documents[i].documentID);
                }
                //Add a new friend to the current user
                _firestore
                    .collection('user')
                    .document(documentSnapshot.documents[i].documentID)
                    .setData(userRecherche.toJson(), merge: true);
                _firestore
                    .collection('user')
                    .document(userID)
                    .setData(userCourrant.toJson(), merge: true);
              }
            }
            return userRecherche;
          });
        });
      });
    });
  }

  Future<String> authenticateUserWithFb() async {
    FacebookLogin facebookLogin = new FacebookLogin();
    FacebookLoginResult result =
        await facebookLogin.logInWithReadPermissions(['email']);
    try {
      switch (result.status) {
        case FacebookLoginStatus.loggedIn:
          AuthCredential credential = FacebookAuthProvider.getCredential(
              accessToken: result.accessToken.token);
          var graphResponse = await http.get(
              'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email&access_token=${result.accessToken.token}');
          var profile = json.decode(graphResponse.body);
          print("PROFILE ===> " + profile.toString());
          return auth.signInWithCredential(credential).then((firebaseUser) {
            User user = new User(
              name: firebaseUser.displayName,
              email: firebaseUser.email,
              nbPomme: 0,
              treeNumber: 1,
              date: DateTime.now().toIso8601String(),
              friendList: new List<String>(),
            );
            NoteForm note = new NoteForm(note: "5");
            storage.setImage(firebaseUser.uid, File(firebaseUser.photoUrl));
            _firestore
                .collection('user')
                .document(firebaseUser.uid)
                .setData(user.toJson());
            _firestore
                .collection('data')
                .document(firebaseUser.uid)
                .setData(note.toJson());
            return firebaseUser.uid;
          });
          break;
        case FacebookLoginStatus.cancelledByUser:
          print("Cancelled by User");
          break;
        case FacebookLoginStatus.error:
          print("Error : " + FacebookLoginStatus.error.index.toString());
          break;
      }
    } on Exception catch (e) {
      print(e);
    }
  }

  Future<User> modifyUser(String id, String email, String name, int treeNumber,
      int nbPomme, String date, List<String> friendList) {
    return auth.currentUser().then((userID) {
      User user = new User(
          email: email,
          name: name,
          treeNumber: treeNumber,
          nbPomme: nbPomme,
          date: date,
          friendList: friendList);
      _firestore.collection('user').document(userID).updateData(user.toJson());
      return user;
    });
  }

  Future<String> modifyImageUser(File image) {
    return auth.currentUser().then((userID) {
      return storage.setImage(userID, image);
    });
  }

  Future<String> registerUser(
      String email, String password, String name, int treeNumber, File image) {
    return auth.registerUser(email, password).then((userId) {
      storage.setImage(userId, image);
      User user = new User(
          reference: null,
          treeNumber: 1,
          email: email,
          name: name,
          date: DateTime.now().toIso8601String(),
          nbPomme: 0,
          friendList: new List<String>());
      NoteForm note = new NoteForm(note: "5");
      _firestore.collection('user').document(userId).setData(user.toJson());
      _firestore.collection('data').document(userId).setData(note.toJson());
      return userId;
    });
  }

  Future<String> enterNote(String note) {
    auth.currentUser().then((userID) {
      _firestore.collection('data').document(userID).get().then((noteInDb) {
        if (noteInDb.data != null) {
          String noteFinal =
              (double.parse(noteInDb.data['note']) / 2 + double.parse(note) / 2)
                  .toString();
          _firestore
              .collection('data')
              .document(userID)
              .updateData({"note": noteFinal});
        } else {
          _firestore
              .collection('data')
              .document(userID)
              .setData({"note": note});
        }
      });
      return userID;
    });
  }

  Future<void> enterNbPomme(int nbPomme) {
    return auth.currentUser().then((userID) {
      return _firestore
          .collection('user')
          .document(userID)
          .get()
          .then((documentSnapshot) {
        return _firestore.collection('user').document(userID).updateData({
          "nbPomme": documentSnapshot.data['nbPomme'] + nbPomme,
          "date": DateTime.now().toIso8601String(),
        });
        //return userID;
      });
    });
  }

  Future<NoteForm> getNote() {
    return auth.currentUser().then((userID) {
      return _firestore
          .collection('data')
          .document(userID)
          .get()
          .then((noteInDb) {
        NoteForm note = NoteForm(note: noteInDb.data['note']);
        return note;
      });
    });
  }

  Future<List<Association>> getAssociations() {
    return _firestore
        .collection('association')
        .getDocuments()
        .then((associations) {
      List<Association> associationsList = new List();
      for (int i = 0; i < associations.documents.length; i++) {
        Association association = new Association(
            presentation: associations.documents.elementAt(i)['presentation'],
            association: associations.documents.elementAt(i)['association'],
            link: associations.documents.elementAt(i)['link']);
        associationsList.add(association);
      }
      return associationsList;
    });
  }
}
