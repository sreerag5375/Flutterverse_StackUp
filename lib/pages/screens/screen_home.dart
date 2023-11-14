import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/auth/screens/screen_create_account.dart';
import 'package:todo_app/pages/screens/add.dart';
import 'package:todo_app/pages/screens/edit.dart';
import 'package:todo_app/utils/colors.dart';
import 'package:todo_app/utils/styles.dart';
import 'package:todo_app/widgets/spacing.dart';

class HomeScreen extends StatefulWidget {
  //String uSer;
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> imageList = [
    "assets/images/avatar_cat.png",
    "assets/images/avatar_freak_man.png",
    "assets/images/avatar_freak_women.png",
    "assets/images/avatar_men.png",
    "assets/images/avatar_panda.png",
    "assets/images/avatar_woman.png"
  ];
  final CollectionReference task =
      FirebaseFirestore.instance.collection('task');

  String? usernameId;
  String url="assets/images/avatar_cat.png";
  // final profileUrl =
  //     "https://cdn.dribbble.com/users/1037219/screenshots/2609746/media/88611d2dc5d6bd3048ee535e73b69bfb.jpg";

  getDatashared() async {
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    usernameId = sharedPref.getString("username");
    //  subCollection = await getNode();
  }

  @override
  Widget build(BuildContext context) {
    getDatashared();

    return Scaffold(
      backgroundColor: AppColors.ASCENT_COLOR,
      appBar: AppBar(
        actions: [
          Align(
            alignment: const Alignment(0, -1),
            child: Padding(
              padding: const EdgeInsets.only(top: 39.0),
              child: PopupMenuButton<int>(
                itemBuilder: (context) => [
                  const PopupMenuItem(
                    value: 1,
                    child: Row(
                      children: [
                        Icon(Icons.settings),
                        Text("Settings"),
                      ],
                    ),
                  )
                ],
                onSelected: (value) {
                  Navigator.pushNamed(context, '/settings');
                },
              ),
            ),
          )
        ],
        elevation: 0,
        toolbarHeight: 180,
        centerTitle: false,
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.ASCENT_COLOR,
        title: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    showMyModalBottomSheet(context);
                  },
                  child: CircleAvatar(
                    radius: 34,
                    backgroundImage: AssetImage(url),
                  ),
                ),

                /* IconButton(
										onPressed: () {
											
									//    Navigator.pushNamed(context, '/home');
										},
										
										icon: Icon(
											Icons.more_vert,
											color: AppColors.SECONDARY_HEADING,
										))*/
              ],
            ),
            const Spacing(height: 14),
            const Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hiii...',
                      style: textStyle,
                    ),
                    Spacing(height: 10),
                    Text(
                      'Welcome to UpTodo',
                      style:
                          TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ],
            ),
            const Spacing(height: 22),
          ],
        ),
      ),
      body: FutureBuilder(
          future: SharedPreferences.getInstance(),
          builder: (context, sharedSnapshot) {
            return StreamBuilder(
              stream:
                  task.doc(usernameId).collection("nodeCollection").snapshots(),
              builder: (context, snapshot) {
                getDatashared();
                if (snapshot.hasData) {
                  return Container(
                    padding: const EdgeInsets.only(top: 66),
                    decoration: const BoxDecoration(
                        color: AppColors.PRIMARY_COLOR,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30))),
                    child: ListView.separated(
                        itemBuilder: (context, index) {
                          final DocumentSnapshot taskSnap =
                              snapshot.data!.docs[index];
                          return Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            margin: const EdgeInsets.symmetric(horizontal: 12),
                            elevation: 5,
                            color: AppColors.ASCENT_COLOR,
                            child: ListTile(
                              title: Padding(
                                padding: const EdgeInsets.only(bottom: 6),
                                child: Text(
                                  taskSnap['title'],
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                              subtitle: Text(
                                taskSnap['description'],
                                style: const TextStyle(
                                    color: Color.fromARGB(255, 222, 212, 212)),
                              ),
                              trailing: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  /*  IconButton(
																			onPressed: () {
																				Navigator.of(context).push(
																						MaterialPageRoute(
																								builder: (context) {
																					return EditScreen(
																						id: taskSnap.id,
																						description:
																								taskSnap['description'],
																						title: taskSnap['title'],
																						update: "update",
																					);
																				}));
																				/*  pushNamed(context, '/addTask',
																					arguments: AddScreen(
																						taskSnap.id,
																						taskSnap['title'],
																						taskSnap['description'],
																						"update"
																			));*/
																			},
																			icon: const Icon(Icons.edit,color: Colors.white,)),*/
                                  InkWell(
                                    borderRadius: BorderRadius.circular(50.0),
                                    child: const Padding(
                                      padding: EdgeInsets.all(10.0),
                                      child: Icon(
                                        Icons.edit,
                                        color: Colors.white,
                                      ),
                                    ),
                                    onTap: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(builder: (context) {
                                        return EditScreen(
                                          id: taskSnap.id,
                                          description: taskSnap['description'],
                                          title: taskSnap['title'],
                                          update: "update",
                                        );
                                      }));
                                    },
                                  ),
                                  InkWell(
                                    borderRadius: BorderRadius.circular(50.0),
                                    child: const Padding(
                                      padding: EdgeInsets.all(10.0),
                                      child: Icon(
                                        Icons.delete,
                                        color: Colors.redAccent,
                                      ),
                                    ),
                                    onTap: () {
                                      deleteItem(taskSnap);
                                    },
                                  )
                                  /*  IconButton(
																			onPressed: () {
																				deleteItem(taskSnap);
																			},
																			
																			icon: const Icon(Icons.delete,color: Colors.black,)),*/
                                ],
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) => const Divider(),
                        itemCount: snapshot.data!.docs.length),
                  );
                }

                return const Center(
                  child: Text('no data'),
                );
              },
            );
          }),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FloatingActionButton(
          onPressed: () {
            // Add your onPressed code here!
            Navigator.pushNamed(context, '/addTask');
          },
          backgroundColor: AppColors.ASCENT_COLOR,
          child: Icon(
            Icons.add,
            size: 34,
            color: AppColors.SECONDARY_HEADING,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Future<void> deleteItem(DocumentSnapshot<Object?> taskSnap) async {
    DocumentReference userDocument = task.doc(usernameId);
    CollectionReference userTasks = userDocument.collection("nodeCollection");
    await userTasks.doc(taskSnap.id).delete();
  }

  /* methods(AsyncSnapshot<QuerySnapshot<Object?>> snapshot)  {
		return;
	}*/
  // void methods(AsyncSnapshot<QuerySnapshot<Object?>> snapshot) {
  //   final usernameId = getString(stringKey: "username");
  //   final dateTime = DateTime.now().microsecondsSinceEpoch;
  //   final userID = "$usernameId$dateTime}";
  //   FirebaseFirestore.instance
  //       .collection('task')
  //       .doc(userID)
  //       .collection("$userID$userID")
  //       .snapshots()
  //       .listen((snapshot) {
  //     snapshot.docs.forEach((doc) {
  //       print('Task Title: ${doc.data()['title']}');
  //       print('Task Description: ${doc.data()['description']}');
  //       // print other fields...
  //     });
  //   });
  // }
  void showMyModalBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.5,
          color: const Color.fromARGB(255, 124, 136, 142),
          child: Column(
            children: <Widget>[
              const Spacing(height: 30),
              const Text(
                'Select Avatar',
                style: TextStyle(
                    fontSize: 22,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
              Container(
                height: 260,
                child: ListView.builder(
								  itemCount: imageList.length,
									scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return InkWell(
											child: ClipRRect(
												child: SizedBox.fromSize(
														size: const Size.fromRadius(80.0),
														child: Image.asset(
															imageList[index],
															height: 100,
															width: 100,
														)),
											),
											onTap: (){
												url=imageList[index];
												setState(() {
												  
												});
								//				ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(imageList[index])));
											},
										);
                  },
		            /*      children:	 [
                  CircleAvatar(
                    radius: 60,
                    backgroundImage: AssetImage('assets/images/avatar_cat.png',),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  CircleAvatar(
                    radius: 60,
                    backgroundImage: AssetImage('assets/images/avatar_freak_man.png'),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  CircleAvatar(
                    radius: 60,
                    backgroundImage: AssetImage('assets/images/avatar_freak_women.png'),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  CircleAvatar(
                    radius: 60,
                    backgroundImage: AssetImage('assets/images/avatar_men.png'),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  CircleAvatar(
                    radius: 60,
                    backgroundImage: AssetImage('assets/images/avatar_panda.png'),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  CircleAvatar(
                    radius: 60,
                    backgroundImage: AssetImage('assets/images/avatar_woman.png'),
                  ),
                ],
            */
                ),
              ),
              ElevatedButton(onPressed: () {
								Navigator.of(context).pop();
							}, child: const Text('OK'))
            ],
          ),
        );
      },
    );
  }
}

// Future<String> getString({required String stringKey}) async {
//   SharedPreferences sharedPref = await SharedPreferences.getInstance();
//   return sharedPref.getString(stringKey)!;
// }

// Column(
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 IconButton(
//                     onPressed: () {},
//                     icon: Icon(
//                       Icons.menu,
//                       size: 32,
//                       color: AppColors.SECONDARY_HEADING,
//                     )),
//                 IconButton(
//                     onPressed: () {},
//                     icon: Icon(
//                       Icons.more_vert,
//                       color: AppColors.SECONDARY_HEADING,
//                     ))
//               ],
//             ),
//            Text('Hi...'),
//            Text('Welcome to UpTodo')
//           ],

