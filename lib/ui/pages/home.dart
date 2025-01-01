import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:userdetails/service/auth_service.dart';
import 'package:userdetails/service/database.dart';
import 'package:userdetails/ui/pages/users.dart';
import 'package:userdetails/utils/toasts.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileController = TextEditingController();

  Stream? userStream;
  dynamic getInfoInit() async {
    userStream = await DatabaseHelper().getAllUserDetails();
    setState(() {});
  }

  @override
  void initState() {
    getInfoInit();
    super.initState();
  }

  Widget allUserInfo() {
    return StreamBuilder(
      builder: (context, AsyncSnapshot snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot documentsnapshot = snapshot.data.docs[index];
                  return Container(
                    margin: EdgeInsets.only(bottom: 21),
                    child: Material(
                      elevation: 5.0,
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                          padding: EdgeInsets.all(20),
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 112, 21, 198),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Name: ${documentsnapshot["Name"]}",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      "Email: ${documentsnapshot["Email"]}",
                                      style: TextStyle(
                                        color: Colors.white70,
                                        fontSize: 14,
                                      ),
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      "Mobile: ${documentsnapshot["Mobile"]}",
                                      style: TextStyle(
                                        color: Colors.white70,
                                        fontSize: 14,
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        ElevatedButton.icon(
                                          onPressed: () {
                                            nameController.text =
                                                documentsnapshot["Name"];

                                            emailController.text =
                                                documentsnapshot["Email"];

                                            mobileController.text =
                                                documentsnapshot["Mobile"];

                                            edituser(documentsnapshot['id']);
                                          },
                                          style: ElevatedButton.styleFrom(
                                            foregroundColor: Colors.white,
                                            backgroundColor: Colors.green,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                          ),
                                          icon: Icon(Icons.edit, size: 16),
                                          label: Text(
                                            "Edit",
                                            style: TextStyle(fontSize: 14),
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        ElevatedButton.icon(
                                          onPressed: () {
                                            showDeleteDialogBox(context,
                                                documentsnapshot["id"]);
                                          },
                                          style: ElevatedButton.styleFrom(
                                            foregroundColor: Colors.white,
                                            backgroundColor: Colors.red,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                          ),
                                          icon: Icon(Icons.delete, size: 16),
                                          label: Text(
                                            "Delete",
                                            style: TextStyle(fontSize: 14),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )),
                    ),
                  );
                },
              )
            : Container();
      },
      stream: userStream,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Users Data"),
        actions: [
          IconButton(
              onPressed: () async {
                await AuthServiceHelper.logout();
                Navigator.pushReplacementNamed(context, '/login');
              },
              icon: Icon(Icons.logout_outlined))
        ],
      ),
      body: Container(
        margin: EdgeInsets.only(left: 10, right: 10, top: 10),
        child: Column(
          children: [Expanded(child: allUserInfo())],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Users()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Future edituser(String id) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Edit a User",
                    style: TextStyle(
                        color: Colors.deepPurple,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.cancel_outlined,
                      size: 35,
                      color: Colors.purple,
                    ),
                  )
                ],
              ),
              Divider(
                height: 10,
                color: Colors.deepPurple,
                thickness: 5,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Name",
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.only(left: 12),
                decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(20)),
                child: TextField(
                  decoration: InputDecoration(border: InputBorder.none),
                  controller: nameController,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Email",
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.only(left: 12),
                decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(20)),
                child: TextField(
                  decoration: InputDecoration(border: InputBorder.none),
                  controller: emailController,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Mobile",
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.only(left: 12),
                decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(20)),
                child: TextField(
                  decoration: InputDecoration(border: InputBorder.none),
                  controller: mobileController,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton.icon(
                    onPressed: () async {
                      Map<String, dynamic> updateDetails = {
                        "Name": nameController.text,
                        "Email": emailController.text,
                        "Mobile": mobileController.text,
                        "id": id
                      };

                      await DatabaseHelper()
                          .updateUser(id, updateDetails)
                          .then((value) {
                        Message.show(message: "Updated Successfully");
                        Navigator.pop(context);
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    icon: Icon(Icons.edit, size: 16),
                    label: Text(
                      "Update",
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    icon: Icon(Icons.delete, size: 16),
                    label: Text(
                      "Cancel",
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showDeleteDialogBox(BuildContext context, String id) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Confirmation for Delete"),
            content: Text("Are You sure you want to delete the User!"),
            actions: [
              TextButton(
                  onPressed: () async {
                    await DatabaseHelper().deleteUser(id);
                    Navigator.pop(context);
                  },
                  child: Text("Yes")),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  child: Text("No")),
            ],
          );
        });
  }
}
