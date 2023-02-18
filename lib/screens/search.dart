import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mentoo/models/specialty.dart';
import 'package:mentoo/models/user.dart';
import 'package:mentoo/screens/home_page.dart';
import 'package:mentoo/screens/mentor_detail.dart';
import 'package:mentoo/services/mentor_service.dart';
import 'package:mentoo/services/specialty_service.dart';
import 'package:mentoo/services/user_service.dart';
import 'package:mentoo/theme/colors.dart';
import 'package:mentoo/theme/fonts.dart';
import 'package:mentoo/models/mentor.dart' as Mentor;
import 'package:mentoo/widgets/loading.dart';

class Search extends StatefulWidget {
  String pageName;

  Search({super.key, this.pageName = "Search"});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  List<Specialty>? _specialties;
  List<Mentor.Mentor>? _mentors;
  List<String> _specialtiesName = [];
  late String _selectedSpecialty;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchSpecialties();
  }

  void _fetchSpecialties() async {
    _specialties = await SpecialtyService().getSpecialties();
    if (widget.pageName == "Search") {
      _mentors = await MentorService().getMentors();
    } else {
      //(await UserService().getUserById(9));
      User? user = (await UserService().getUser());
      _mentors = await MentorService().getFollowedMentors(user!.userId);
    }

    _specialtiesName =
        _specialties != null ? _specialties!.map((s) => s.name).toList() : [];
    //_specialtiesName.add("Others");
    _selectedSpecialty = _specialtiesName[0];
    if (_specialties != null && _mentors != null) {
      setState(() {
        _isLoading = true;
      });
    }
  }

  void _showSpecialtiesMenu(context) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          alignment: Alignment.topRight,
          child: Container(
            height: _specialties!.length * 50,
            width: 1000,
            decoration: BoxDecoration(
                color: AppColors.mBackground,
                borderRadius: BorderRadius.circular(10)),
            child: ListView.builder(
              itemCount: _specialties!.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    if (kDebugMode) {
                      print(
                          "${_specialties![index].specialtyId} : ${_specialties![index].name}");
                    }
                    setState(() {
                      _selectedSpecialty = _specialtiesName[index];
                      //_mentors = _mentors.where((element) => element.specialty.)
                    });
                    Navigator.pop(context);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    color: _selectedSpecialty == _specialtiesName[index]
                        ? AppColors.mLightPurple
                        : AppColors.mBackground,
                    child: Text(
                      _specialtiesName[index],
                      style: const TextStyle(color: Colors.black, fontSize: 16),
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return !_isLoading
        ? const Loading()
        : Scaffold(
            appBar: AppBar(
                leading: BackButton(
                  color: Colors.black,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                actions: [
                  InkWell(
                      onTap: () {
                        _showSpecialtiesMenu(context);
                      },
                      child: const Icon(Icons.filter_alt_outlined,
                          color: Colors.black, size: 30)),
                  const SizedBox(
                    width: 10,
                  )
                ],
                backgroundColor: Colors.white,
                elevation: 0,
                titleTextStyle: AppFonts.medium(20, Colors.black),
                title: Container(
                    //width: 300,
                    height: 40,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5)),
                    child: Center(
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintText: "Search",
                          prefixIcon: const Icon(
                            Icons.search,
                            color: AppColors.mDarkPurple,
                          ),
                          contentPadding: const EdgeInsets.only(left: 20),
                          filled: true,
                          fillColor: Colors.white,
                          // focusColor: AppColors.grayColor,
                          // hoverColor: AppColors.grayColor,
                          //labelText: "Search for mentor ",
                          labelStyle: AppFonts.medium(16, AppColors.mText),
                          //errorText: 'Error message',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            borderSide:
                                const BorderSide(color: AppColors.mDarkPurple),
                          ),
                        ),
                      ),
                    ))),
            body: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(20),
              child: GridView.count(
                  //physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.zero,
                  primary: false,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  crossAxisCount: 2,
                  childAspectRatio: 0.75,
                  children: List.generate(
                    _mentors!.length,
                    (index) => InkWell(
                      onTap: () => Get.to(
                          MentorDetail(mentorId: _mentors![index].mentorId)),
                      child: ProfileCard(
                        company: _mentors![index].user.jobs![0].company,
                        job: _mentors![index].user.jobs![0].role,
                        name: _mentors![index].user.name,
                        image: _mentors![index].user.photo,
                      ),
                    ),
                  )),
            ),
          );
  }
}
