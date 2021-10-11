import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:function_app/Module/Package.dart';
import 'package:function_app/Module/RegisteredPost.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

class EmailSender {
  static Future<void> sendMail(
      {required String receiver,
      required String subject,
      required String body}) async {
    String username = 'slpostofficemanagement@gmail.com';
    String password = '0710000000';

    final smtpServer = gmail(username, password);
    // options.'This is the plain text.\nThis is line 2 of the text part.'

    // Create our message.
    final message = Message()
      ..from = Address(username, 'Post Office Management System')
      ..recipients.add(receiver)
      ..subject = subject
      ..text = body;
    // ..html = "<h1>Test</h1>\n<p>Hey! Here's some HTML content</p>";

    try {
      final sendReport = await send(message, smtpServer);
      print('Message sent: ' + sendReport.toString());
    } on MailerException catch (e) {
      print('Message not sent. $e');
      for (var p in e.problems) {
        print('Problem: ${p.code}: ${p.msg}');
      }
    }
    /*
    var connection = PersistentConnection(smtpServer);

    // Send the first message
    await connection.send(message);

    // send the equivalent message
    await connection.send(equivalentMessage);

    // close the connection
    await connection.close();

    */
  }

  static Future<void> deliveredEmailOperator(postRef) async {
    try {
      var type;
      if (postRef is RegisteredPost) {
        type = 'Registered';
      } else if (postRef is PackagePost) {
        type = 'package';
        String packageSub = '$type Post : PID ${postRef.pid}';
        String packageBody = 'Dear ${postRef.recipientName}, \n\n'
            'You have successfully collect the $type post.\n'
            'PID : ${postRef.pid}\n'
            'Sender name : ${postRef.senderName}\n'
            'Sender address : No.${postRef.senderAddressNUmber}, ${postRef.senderStreet1} road, ${postRef.senderStreet2} ${postRef.senderCity}\n'
            'Timestamp : ${DateTime.now()}\n\n'
            'Thank you for using Our Postal service\n'
            'Post Management System';
        await sendMail(
            receiver: postRef.receiverEmail,
            subject: packageSub,
            body: packageBody);
      }
      String subject = '$type Post : PID ${postRef.pid}';
      String body = 'Dear ${postRef.senderName}, \n\n'
          'Your $type post has been successfully delivered. \n'
          'PID : ${postRef.pid}\n'
          'Receiver name : ${postRef.recipientName}\n'
          'Receiver address : No.${postRef.recipientAddressNUmber}, ${postRef.recipientStreet1} road, ${postRef.recipientStreet2} ${postRef.recipientCity}\n'
          'Timestamp : ${DateTime.now()}\n\n'
          'Thank you for using Our Postal service\n'
          'Post Management System';
      await sendMail(
          receiver: postRef.senderEmail, subject: subject, body: body);
    } catch (e) {
      return;
    }
  }

  static Future<void> failedEmailOperator(postRef) async {
    try {
      var type;
      if (postRef is RegisteredPost) {
        type = 'Registered';
      } else if (postRef is PackagePost) {
        type = 'package';
        String packageSub = '$type Post : PID ${postRef.pid}';
        String packageBody = 'Dear ${postRef.recipientName}, \n\n'
            'Please come to post office in your area to collect the package post.\n'
            'PID : ${postRef.pid}\n'
            'Sender name : ${postRef.senderName}\n'
            'Sender address : No.${postRef.senderAddressNUmber}, ${postRef.senderStreet1} road, ${postRef.senderStreet2} ${postRef.senderCity}\n'
            'Timestamp : ${DateTime.now()}\n\n'
            'Thank you for using Our Postal service\n'
            'Post Management System';
        await sendMail(
            receiver: postRef.receiverEmail,
            subject: packageSub,
            body: packageBody);
      }
      String subject = '$type Post : PID ${postRef.pid}';
      String body = 'Dear ${postRef.senderName}, \n\n'
          'Your $type post cannot be delivered. \n'
          'PID : ${postRef.pid}\n'
          'Receiver name : ${postRef.recipientName}\n'
          'Receiver address : No.${postRef.recipientAddressNUmber}, ${postRef.recipientStreet1} road, ${postRef.recipientStreet2} ${postRef.recipientCity}\n'
          'Timestamp : ${DateTime.now()}\n\n'
          'Thank you for using Our Postal service\n'
          'Post Management System';
      await sendMail(
          receiver: postRef.senderEmail, subject: subject, body: body);
    } catch (e) {
      return;
    }
  }
}
