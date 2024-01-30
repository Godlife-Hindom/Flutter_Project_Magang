// ----- STRINGS ------
import 'package:flutter/material.dart';

const baseURL = 'http://127.0.0.1:8000/api';
const loginURL = 'http://127.0.0.1:8000/api/login';
const registerURL = 'http://127.0.0.1:8000/api/register';
const logoutURL = 'http://127.0.0.1:8000/api/logout';
const userURL = 'http://127.0.0.1:8000/api/user';
const postsURL = 'http://127.0.0.1:8000/api/posts';
const commentsURL = 'http://127.0.0.1:8000/api/comments';

// ----- Errors -----
const serverError = 'Server error';
const unauthorized = 'Unauthorized';
const somethingWentWrong = 'Something went wrong, try again!';


// --- input decoration
InputDecoration kInputDecoration(String label) {
  return InputDecoration(
      labelText: label,
      contentPadding: const EdgeInsets.all(10),
      border: const OutlineInputBorder(borderSide: BorderSide(width: 1, color: Colors.black))
    );
}


// button

TextButton kTextButton(String label, Function onPressed){
  return TextButton(
    // ignore: sort_child_properties_last
    child: Text(label, style: const TextStyle(color: Colors.white),),
    style: ButtonStyle(
      backgroundColor: MaterialStateColor.resolveWith((states) => Colors.blue),
      padding: MaterialStateProperty.resolveWith((states) => const EdgeInsets.symmetric(vertical: 10))
    ),
    onPressed: () => onPressed(),
  );
}

// loginRegisterHint
Row kLoginRegisterHint(String text, String label, Function onTap) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(text),
      GestureDetector(
        child: Text(label, style:const TextStyle(color: Colors.blue)),
        onTap: () => onTap()
      )
    ],
  );
}


// likes and comment btn

Expanded kLikeAndComment (int value, IconData icon, Color color, Function onTap) {
  return Expanded(
      child: Material(
        child: InkWell(
          onTap: () => onTap(),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical:10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, size: 16, color: color,),
                const SizedBox(width:4),
                Text('$value')
              ],
            ),
          ),
        ),
      ),
    );
}