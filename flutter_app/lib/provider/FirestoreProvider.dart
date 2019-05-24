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
      User u = new User(
          email: documentSnapshot.data['email'],
          name: documentSnapshot.data['name'],
          treeNumber: documentSnapshot.data['treeNumber'],
          nbPomme: documentSnapshot.data['nbPomme'],
          date: documentSnapshot.data['date'],
          friendList: documentSnapshot.data['frendList'],
          reference: null);
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
          User user = new User(
            date: documentSnapshot.documents[i].data['date'],
            treeNumber: documentSnapshot.documents[i].data['treeNumber'],
            nbPomme: documentSnapshot.documents[i].data['nbPomme'],
            name: documentSnapshot.documents[i].data['name'],
            email: documentSnapshot.documents[i].data['email'],
            friendList:
                documentSnapshot.documents[i].data['friendList'].cast<String>(),
          );
          return user;
        }
      }
    });
  }

  List<String> copyList(List<String> list,int length) {
    List<String> listFinal = new List();
    for (int i = 0; i < length; i++) {
      listFinal[i] = list[i];
    }
    return listFinal;
  }

  Future<User> addUserInFriendList(String email) {
    return auth.currentUser().then((userID) {
      // Récupére l'utilisateur recherché
      return getUserByEmail(email).then((user) {
        // Recupére l'utilisateur courrant en fonction de l'ID
        return getUserById(userID).then((user2) {
          List<String> friendListSearch = copyList(user.friendList,user.friendList.length);
          friendListSearch.add(userID);
          User search = new User(
            friendList: friendListSearch,
            email: user.email,
            name: user.name,
            nbPomme: user.nbPomme,
            treeNumber: user.treeNumber,
            date: user.date,
          );
          return _firestore
              .collection('user')
              .getDocuments()
              .then((documentSnapshot) {
            User add;
            List<String> friendList;
            for (int i = 0; i < documentSnapshot.documents.length; i++) {
              if (documentSnapshot.documents[i]['email'] == email) {
                friendList = copyList(user2.friendList,user2.friendList.length);
                friendList.add(documentSnapshot.documents[i].documentID);
                add = new User(
                  friendList: friendList,
                  email: user2.email,
                  name: user2.name,
                  nbPomme: user2.nbPomme,
                  treeNumber: user2.treeNumber,
                  date: user2.date,
                );
                _firestore
                    .collection('user')
                    .document(documentSnapshot.documents[i].documentID)
                    .updateData(search.toJson());
                _firestore
                    .collection('user')
                    .document(userID)
                    .updateData(add.toJson());
              }
            }
            return add;
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
        /*User u = new User(
              nbPomme: documentSnapshot.data['nbPomme'] + nbPomme,
              date: DateTime.now().toIso8601String(),
            );*/
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
