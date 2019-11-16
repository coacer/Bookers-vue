import firebase from 'firebase'

if (!firebase.apps.length) {
  firebase.initializeApp({
    apiKey: "AIzaSyD3vmjbvnlT2hucbLPvfR7MGveH_4w4H-s",
    authDomain: "bookers-vue.firebaseapp.com",
    databaseURL: "https://bookers-vue.firebaseio.com",
    projectId: "bookers-vue",
    storageBucket: "bookers-vue.appspot.com",
    messagingSenderId: "606256090842",
    appId: "1:606256090842:web:65d36035d0a3d005c05fe3",
    measurementId: "G-KE5LYFFRSR"
  })
}

export default firebase
