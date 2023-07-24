import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Model/lawyer_model.dart';
import '../controller/provider_controller.dart';

class ViewCase extends StatelessWidget {
  const ViewCase({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lawyers'),
      ),
      body: ChangeNotifierProvider(
        create: (context) => MainScreenController(),
        builder: (context, _) {
          return const LawyerList();
        },
      ),
    );
  }
}

class LawyerList extends StatefulWidget {
  const LawyerList({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LawyerListState createState() => _LawyerListState();
}

class _LawyerListState extends State<LawyerList> {
  int _selectedLawyerIndex = -1;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    Provider.of<MainScreenController>(context, listen: false)
        .fetchLawyers()
        .then((_) {
      setState(() {
        _isLoading = false; // Hide the loading indicator
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final lawyers = Provider.of<MainScreenController>(context).lawyers;

    return Stack(
      children: [
        Opacity(
          opacity: _isLoading ? 0.0 : 1.0,
          child: ListView.builder(
            itemCount: lawyers.length,
            itemBuilder: (context, index) {
              final lawyer = lawyers[index];
              final isExpanded = index == _selectedLawyerIndex;

              return ListTile(
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedLawyerIndex = isExpanded ? -1 : index;
                        });
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: 350,
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color.fromARGB(255, 241, 225, 169),
                        ),
                        child: Text(
                          lawyer.lawyerName,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    ),
                    if (isExpanded)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Lawyer Number: ${lawyer.lawyernumber}'),
                            Text('Client Name: ${lawyer.clintname}'),
                            const SizedBox(height: 10),
                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  _showUpdateDialog(context, lawyer);
                                });
                              },
                              child: Text('Update Data'),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              );
            },
          ),
        ),
        if (_isLoading)
          const Center(
            child: CircularProgressIndicator(),
          ),
      ],
    );
  }

  void _showUpdateDialog(BuildContext context, Lawyer lawyer) {
    TextEditingController lawyerNumberController =
        TextEditingController(text: lawyer.lawyernumber);
    TextEditingController clintnameController =
        TextEditingController(text: lawyer.clintname);
    TextEditingController lawyerNameController =
        TextEditingController(text: lawyer.lawyerName);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return WillPopScope(
              onWillPop: () async {
                // Prevent popping the dialog when loading
                return !_isLoading;
              },
              child: AlertDialog(
                title: const Text('Update Lawyer Data'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: lawyerNameController,
                      decoration:
                          const InputDecoration(labelText: 'Lawyer Name'),
                      onChanged: (value) {
                        lawyerNameController.text = value;
                        setState(() {});
                      },
                    ),
                    TextField(
                      controller: lawyerNumberController,
                      decoration:
                          const InputDecoration(labelText: 'Lawyer Number'),
                      onChanged: (value) {
                        lawyerNumberController.text = value;
                        setState(() {});
                      },
                    ),
                    TextField(
                      controller: clintnameController,
                      decoration:
                          const InputDecoration(labelText: 'Client Name'),
                      onChanged: (value) {
                        clintnameController.text = value;
                        setState(() {});
                      },
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Cancel'),
                  ),
                  ElevatedButton(
                    onPressed: _isLoading
                        ? null
                        : () async {
                            setState(() {
                              _isLoading = true;
                              // Show the loading indicator
                            });

                            final updatedLawyer = Lawyer(
                              lawyerName: lawyerNameController.text,
                              lawyernumber: lawyerNumberController.text,
                              clintname: lawyer.clintname,
                              clintnumber: lawyer.clintnumber,
                              datainfo: lawyer.datainfo,
                              startdate: lawyer.startdate,
                            );

                            await Provider.of<MainScreenController>(context,
                                    listen: false)
                                .updateLawyer(updatedLawyer);

                            setState(() {
                              _isLoading = false; // Hide the loading indicator
                            });

                            Navigator.of(context).pop();
                          },
                    child: Text('Update'),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
