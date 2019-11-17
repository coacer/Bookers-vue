import firebase from 'firebase'

const config = {
    apiKey: 'AIzaSyD3vmjbvnlT2hucbLPvfR7MGveH_4w4H-s', // .envを使うとなぜかエラー
    authDomain: process.env.AUTHDOMAIN,
    databaseURL: process.env.DATABASEURL,
    projectId: process.env.PROJECTID,
    storageBucket: process.env.STORAGEBUCKET,
    messagingSenderId: process.env.MESSAGINGSENDERID,
    appId: process.env.APPID,
    measurementId: process.env.MEASUREMENTID
  };

if (!firebase.apps.length) {
  firebase.initializeApp(config);
}

export default firebase
