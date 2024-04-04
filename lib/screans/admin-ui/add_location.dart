import 'package:flutter/material.dart';

class AddLocation extends StatelessWidget {
  AddLocation({super.key});
  GlobalKey<FormState> formState = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("ManageLocation")),
      //     body: Column(children: [
      //   Row(
      //     children: [
      //       Form(
      //           key: formState,
      //           child: Row(
      //             children: [
      //               TextFormField(
      //                 validator: (value) {
      //                   if (value!.isEmpty) {
      //                     return "the filed is empty";
      //                   }
      //                 },
      //               ),
      //               MaterialButton(
      //                 textColor: Colors.white,
      //                 color: Colors.red,
      //                 onPressed: () {
      //                   if (formState.currentState!.validate()) {
      //                     print("valid");
      //                   } else {
      //                     print("not valid");
      //                   }
      //                 },
      //                 child: Text("valid"),
      //               ),
      //             ],
      //           ))
      //     ],
      //   ),
      // ])
    );
  }
}
