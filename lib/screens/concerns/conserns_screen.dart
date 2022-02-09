import 'package:elomia_test/models/concern.dart';
import 'package:elomia_test/screens/bottom_bar/bottom_bar.dart';
import 'package:elomia_test/screens/concerns/widgets/concern_card.dart';
import 'package:elomia_test/theme/theme.dart';
import 'package:elomia_test/utils/constants.dart';
import 'package:flutter/material.dart';

class ConcernsScreen extends StatefulWidget {
  const ConcernsScreen({Key? key}) : super(key: key);

  @override
  State<ConcernsScreen> createState() => _ConcernsScreenState();
}

class _ConcernsScreenState extends State<ConcernsScreen> {
  Set<Concern> addedConcerns = {};
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 24.0, left: 32, right: 32),
              child: Text(
                'What are your concerns?',
                style: ElomiaTheme.header,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 12.0, bottom: 24, left: 32, right: 32),
              child: Text(
                'Choose three things you want to work on first',
                style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w400,
                    color: Colors.white.withOpacity(0.8)),
              ),
            ),
            Expanded(
              child: Stack(
                children: [
                  ListView.builder(
                      shrinkWrap: true,
                      itemCount: concernsList.length,
                      itemBuilder: (_, index) {
                        return Column(
                          children: [
                            ConcernCard(
                              selected: addedConcerns.contains(concernsList[index]),
                                title: concernsList[index].title,
                                subtitle: concernsList[index].description,
                                onSelect: (selected) {
                                
                                  setState(() {
                                    addedConcerns.contains(concernsList[index])
                                        ? addedConcerns.remove(concernsList[index])
                                        : addedConcerns.add(concernsList[index]);
                                  });
                                  print(addedConcerns);
                                }),
                                if(index == concernsList.length -1)
                                const SizedBox(height: 35,)
                          ],
                        );
                      }),
                  if (addedConcerns.length >= 3)
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          Container(
                            height: 160,
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Color.fromRGBO(18, 33, 74, 0),
                                  Color(0xFF060E25),
                                ],
                              ),
                            ),
                          ),
                          // child:
                          Padding(
                            padding: const EdgeInsets.only(
                                bottom: 84.0, left: 32, right: 32),
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  textStyle: ElomiaTheme.title,
                                  elevation: 25,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                  shadowColor:
                                      ElomiaTheme.darkIndigo.withOpacity(0.2),
                                  minimumSize: const Size.fromHeight(54),
                                ),
                                onPressed: () {
                                  Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const ElomiaBottomBar(),
                                    ),
                                  );
                                },
                                child: const Text('Get started')),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
