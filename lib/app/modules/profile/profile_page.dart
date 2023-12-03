import 'package:fashion_app/app/common/stateless/custom_text_field.dart';
import 'package:fashion_app/app/modules/login/login_controller.dart';
import 'package:fashion_app/app/modules/profile/profile_controller.dart';
import 'package:fashion_app/core/utils/flutx/lib/flutx.dart';
import 'package:fashion_app/routes/app_routes.dart';
import 'package:fashion_app/theme/app_theme.dart';
import 'package:fashion_app/theme/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class ProfilePage extends GetView<ProfileController> {

  ProfilePage({super.key});

  ThemeData theme = AppTheme.theme;
  CustomTheme customTheme = AppTheme.customTheme;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            elevation: 2,
            shadowColor: Colors.white54,
            centerTitle: true,
            backgroundColor: const Color(0xffffffff),
            title: FxText.titleMedium(
              "THÔNG TIN CÁ NHÂN",
              color: theme.primaryColor,
            ),

            leading: IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: Icon(
                  Icons.arrow_back_ios_new_outlined,
                  color: theme.primaryColor,
                )),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Divider(
                  height: 1, thickness: 2, color: Color(0xFFD0D0D0)),
              Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Column(
                          children: [
                            Expanded(
                              child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      const SizedBox(height: 18),

                                      ///Avatar
                                      // Stack(children: <Widget>[
                                      //   Get.find<SignInController>().avatar.value != ""
                                      //       ? FxContainer(
                                      //     width: 140,
                                      //     height: 140,
                                      //     child: CircleAvatar(
                                      //         backgroundColor: theme.scaffoldBackgroundColor,
                                      //         child: ClipRRect(
                                      //           borderRadius:BorderRadius.circular(50),
                                      //           child:
                                      //           Obx(()=>CachedNetworkImage(
                                      //             imageUrl:'https://${Get.find<SignInController>().avatar.value}',
                                      //             imageBuilder: (context, imageProvider) => Container(
                                      //               decoration: BoxDecoration(
                                      //                 shape: BoxShape.circle,
                                      //                 image: DecorationImage(
                                      //                   image: imageProvider,
                                      //                   fit: BoxFit.cover,
                                      //                 ),
                                      //               ),
                                      //             ),
                                      //             placeholder: (context, url) =>
                                      //             const CircularProgressIndicator(),
                                      //             errorWidget: (context, url, error) => const Icon(Icons.error),
                                      //           )),
                                      //         )
                                      //     ),
                                      //   )
                                      //       : Container(
                                      //     width: MediaQuery.of(context)
                                      //         .size
                                      //         .width /
                                      //         3,
                                      //     height: MediaQuery.of(context)
                                      //         .size
                                      //         .width /
                                      //         3,
                                      //     decoration: const BoxDecoration(
                                      //       color: Colors.grey,
                                      //       shape: BoxShape.circle,
                                      //     ),
                                      //     child: Center(
                                      //         child: Text(
                                      //             Get.find<
                                      //                 SignInController>()
                                      //                 .storedName
                                      //                 .value
                                      //                 .substring(0, 1),
                                      //             style: const TextStyle(
                                      //               color: Colors.white,
                                      //               fontSize: 50.0,
                                      //               fontWeight:
                                      //               FontWeight.w600,
                                      //             ))),
                                      //   ),
                                      //   Padding(
                                      //     padding: const EdgeInsets.only(
                                      //         top: 80.0, left: 90.0),
                                      //     child: InkWell(
                                      //       onTap: () async {
                                      //         ImagePicker picker =
                                      //         ImagePicker();
                                      //
                                      //         XFile? image =
                                      //         await picker.pickImage(source: ImageSource.gallery);
                                      //
                                      //         //FilePickerResult? image = await FilePicker.platform.pickFiles();
                                      //
                                      //         if (image != null) {
                                      //           File file = File(image.path);
                                      //           String result = await controller.uploadAvatar(file);
                                      //           if(result != ServerResponse.success){
                                      //             if (context.mounted) {
                                      //               showDialog(
                                      //                   context: context,
                                      //                   builder: (context) {
                                      //                     return CustomErrorDialog(
                                      //                         title: "Lỗi",
                                      //                         message: "Đã xảy ra lỗi! \n Vui lòng thử lại sau!",
                                      //                         onPressed: (){
                                      //                           Get.back();
                                      //                         });
                                      //                   });
                                      //             }
                                      //           }
                                      //
                                      //           Get.toNamed(
                                      //               AppRoutes.updateMember);
                                      //         }
                                      //       },
                                      //       child: Container(
                                      //         height: 45.0,
                                      //         width: 45.0,
                                      //         decoration: const BoxDecoration(
                                      //           borderRadius: BorderRadius.all(
                                      //               Radius.circular(50.0)),
                                      //           color: Colors.black,
                                      //         ),
                                      //         child: const Center(
                                      //           child: Icon(
                                      //             Icons.camera_alt,
                                      //             color: Colors.white,
                                      //             size: 18.0,
                                      //           ),
                                      //         ),
                                      //       ),
                                      //     ),
                                      //   ),
                                      // ]),

                                      const SizedBox(height: 30),

                                      CustomTextField(
                                          prefixIcon: const Icon(Icons.person),
                                          labelText: "Tên tài khoản",
                                          hintText: "Tên tài khoản",
                                          obscureText: false,
                                          controller:
                                          controller.usernameTextControl,
                                          readOnly: true),
                                      const SizedBox(height: 14),

                                      CustomTextField(
                                          prefixIcon: const Icon(Icons.email),
                                          labelText: "Thư điện tử (Email)",
                                          hintText: "Thư điện tử (Email)",
                                          obscureText: false,
                                          controller:
                                          controller.emailTextControl,
                                          readOnly: true),
                                      const SizedBox(height: 14),

                                      // const Text("Thông tin cá nhân"),
                                      // const SizedBox(height: 7),

                                      ///TextField điền tên
                                      CustomTextField(
                                          prefixIcon: const Icon(
                                              FontAwesomeIcons.circleInfo),
                                          labelText: "Tên *",
                                          hintText: "Tên",
                                          obscureText: false,
                                          controller:
                                          controller.fullNameTextControl,
                                          readOnly: false),
                                      const SizedBox(height: 14),

                                      ///TextField điền ngày sinh
                                      CustomTextField(
                                          prefixIcon: const Icon(Icons.cake),
                                          labelText: "Ngày sinh",
                                          hintText: "Ngày sinh",
                                          obscureText: false,
                                          controller:
                                          controller.birthdayTextControl,
                                          suffixIcon: IconButton(
                                              icon: const Icon(
                                                  Icons.calendar_month),
                                              onPressed: () async {
                                                DateTime? newDate =
                                                await showDatePicker(
                                                    context: context,
                                                    initialDate:
                                                    DateTime.now(),
                                                    firstDate:
                                                    DateTime(1930),
                                                    lastDate:
                                                    DateTime(2024));
                                                controller.birthdayTextControl
                                                    .text =
                                                    "$newDate".substring(0, 10);
                                                controller.birthday.value =
                                                "${newDate?.toIso8601String()}Z";
                                              }),
                                          readOnly: false),
                                      const SizedBox(height: 14),

                                      Obx(
                                            () => DropdownButtonHideUnderline(
                                          child: DropdownButtonFormField(
                                            decoration: const InputDecoration(
                                              prefixIcon: Icon(FontAwesomeIcons
                                                  .marsAndVenus),
                                              labelText: "Giới tính",
                                              border: OutlineInputBorder(
                                                //borderSide: BorderSide(color: Color(0xFFD0D0D0)),
                                                borderSide: BorderSide(
                                                    color: Colors.green),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10)),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                //<-- SEE HERE
                                                borderSide: BorderSide(
                                                    color: Color(0xFFD0D0D0)),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10)),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                //<-- SEE HERE
                                                borderSide: BorderSide(
                                                    color: Color(0xFFD0D0D0)),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10)),
                                              ),
                                            ),
                                            isExpanded: true,
                                            value:
                                            controller.gender.value.isEmpty
                                                ? null
                                                : controller.gender.value,
                                            isDense: true,
                                            items: controller.genderList
                                                .map((value) {
                                              return DropdownMenuItem(
                                                value: value,
                                                child: Text(value),
                                              );
                                            }).toList(),
                                            onChanged: (newValue) {
                                              controller.gender.value =
                                              newValue!;
                                            },
                                          ),
                                        ),
                                      ),

                                      const SizedBox(height: 14),

                                      ///TextField điền số điện thoại
                                      CustomTextField(
                                          prefixIcon: const Icon(Icons.phone),
                                          labelText: "Số điện thoại",
                                          hintText: "Số điện thoại",
                                          obscureText: false,
                                          keyboardType: const TextInputType
                                              .numberWithOptions(),
                                          inputFormatters: [
                                            FilteringTextInputFormatter
                                                .digitsOnly
                                          ],
                                          controller:
                                          controller.phoneNumberTextControl,
                                          readOnly: false),
                                      const SizedBox(height: 14),
                                    ],
                                  )),
                            ),
                          ],
                        )
                      ],
                    ),
                  ))
            ],
          ),
        ));
  }
}