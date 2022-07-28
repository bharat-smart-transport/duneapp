import 'package:flutter/material.dart';

class Essentials {
  static Color colorPrimary = Colors.teal;
  static bool loaded = false;
  static InputBorder border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(4),
      borderSide: const BorderSide(color: Colors.black12, width: 1),
      gapPadding: 8);
  static void showProgressDialog(context) {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.amber,
            ),
          );
        },
        barrierDismissible: false);
  }

  static showSnack(ScaffoldState state, String message,
      {SnackBarAction? action}) {
    // ignore: deprecated_member_use
    state.showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: Colors.blue.shade700,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      action: action,
    ));
  }

  

  static String formatTime(DateTime dateTime) {
    return "${_getMonthName(dateTime.month)}, ${get2Press(dateTime.day)} ${dateTime.year}, ${dateTime.hour > 12 ? get2Press(dateTime.hour - 12) : get2Press(dateTime.hour)}:${get2Press(dateTime.minute)} ${dateTime.hour > 12 ? "PM" : "AM"}";
  }

  static String get2Press(int num) {
    return num < 10 ? "0$num" : num.toString();
  }

  static String _getMonthName(int month) {
    switch (month) {
      case 1:
        return "JAN";
      case 2:
        return "FEB";
      case 3:
        return "MAR";
      case 4:
        return "APR";
      case 5:
        return "MAY";
      case 6:
        return "JUN";
      case 7:
        return "JUL";
      case 8:
        return "AUG";
      case 9:
        return "SEP";
      case 10:
        return "OCT";
      case 11:
        return "NOV";
      case 12:
        return "DEC";
      default:
        return "NULL";
    }
  }

  static String getStatus(int status) {
    String stat = "";
    switch (status) {
      case 0:
        stat = "Order Placed";
        break;
      case 1:
        stat = "Out for Delivery";
        break;
      case 2:
        stat = "Completed";
        break;
      case -1:
        stat = "Order Cancelled";
        break;
      case -2:
        stat = "Order Return Requested";
        break;
      case -3:
        stat = "Order Returned Cancel";
        break;
      case -4:
        stat = "Order Return Complete";
        break;
      default:
        stat = "Order Placed";
    }
    return stat;
  }

  static Color getStatusColor(int status) {
    Color stat = Colors.blueGrey.shade700;
    switch (status) {
      case 0:
        stat = Colors.blueGrey.shade700;
        break;
      case 1:
        stat = Colors.teal;
        break;
      case 2:
        stat = Colors.green.shade700;
        break;
      case -1:
        stat = Colors.red.shade700;
        break;
      case -2:
        stat = Colors.red.shade700;
        break;
      case -3:
        stat = Colors.red.shade700;
        break;
      case -4:
        stat = Colors.green.shade700;
        break;
      default:
        stat = Colors.grey.shade700;
    }
    return stat;
  }

  static Color hexToColor(String code) {
    return Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
  }
}
