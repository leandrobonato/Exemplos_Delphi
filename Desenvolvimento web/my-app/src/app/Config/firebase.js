import firebase from 'firebase/app';
//import firebase from 'firebase';

const firebaseConfig = {
    apiKey: "AIzaSyBAasehEppfORce7VR-UX_fcsAwQy8jtDo",
    authDomain: "crm-7b1fa.firebaseapp.com",
    projectId: "crm-7b1fa",
    storageBucket: "crm-7b1fa.appspot.com",
    messagingSenderId: "709155864686",
    appId: "1:709155864686:web:7564db6026791727c0667f"
  };
  
  // Initialize Firebase
export default firebase.initializeApp(firebaseConfig);
