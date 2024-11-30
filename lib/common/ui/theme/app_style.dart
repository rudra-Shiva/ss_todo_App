
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app/common/ui/res/dimen.dart';

import 'package:todo_app/common/ui/theme/app_color.dart';

class AppStyle {
  const AppStyle._();

  static TextStyle get _csTextTheme =>
      GoogleFonts.poppins(color: AppColor.greenColor4);

  static const String fontFamilyName = 'Poppins';

  static TextTheme get _poppinsTextTheme =>
      ThemeData(fontFamily: fontFamilyName, useMaterial3: false).textTheme;

  static TextStyle? get csNormalText => _poppinsTextTheme.bodySmall?.copyWith(
        fontSize: Dimen.dimen_16.sp,
        color: AppColor.black,
      );
  // static TextStyle? get csNormalText {
  //   final baseStyle = _poppinsTextTheme.bodyText1 ?? _poppinsTextTheme.bodyLarge;
  //   return baseStyle?.copyWith(
  //     fontSize: Dimen.dimen_16.sp,
  //     color: AppColor.black,
  //   );
  // }

  static TextStyle? get normalText => _csTextTheme.copyWith(
        fontSize: Dimen.dimen_16.sp,
        color: AppColor.black,
        fontWeight: FontWeight.normal,
      );

  static TextStyle? get boldText => _csTextTheme.copyWith(
        fontSize: Dimen.dimen_16.sp,
        color: AppColor.black,
        fontWeight: FontWeight.bold,
      );

  static TextStyle? get lightText => _csTextTheme.copyWith(
        fontSize: Dimen.dimen_16.sp,
        color: AppColor.black,
        fontWeight: FontWeight.w200,
      );

  static TextStyle textStyle9(
      {Color color = AppColor.greyColor4,
        FontWeight fontWeight = FontWeight.w400}) {
    return GoogleFonts.poppins(
      fontSize: 9.sp,
      fontWeight: fontWeight,
      color: color,
    );
  }

  static TextStyle textStyle10(
      {Color color = AppColor.greyColor4,
      FontWeight fontWeight = FontWeight.w400}) {
    return GoogleFonts.poppins(
      fontSize: 10.sp,
      fontWeight: fontWeight,
      color: color,
    );
  }
  static TextStyle textStyle14(
      {Color color = AppColor.greyColor4,
        FontWeight fontWeight = FontWeight.w400}) {
    return GoogleFonts.poppins(
      fontSize: 14.sp,
      fontWeight: fontWeight,
      color: color,
    );
  }

  static TextStyle textStyle8(
      {Color color = AppColor.greyColor4,
        FontWeight fontWeight = FontWeight.w400}) {
    return GoogleFonts.poppins(
      fontSize: 8.sp,
      fontWeight: fontWeight,
      color: color,
    );
  }


    static TextStyle textStyleMedium10(
      {Color color = AppColor.greyColor4,
      FontWeight fontWeight = FontWeight.w600}) {
    return GoogleFonts.poppins(
      fontSize: 10.sp,
      fontWeight: fontWeight,
      color: color,
    );
  }

  static TextStyle textStyle12(
      {Color color = AppColor.greyColor6,
      FontWeight fontWeight = FontWeight.w400}) {
    return GoogleFonts.poppins(
      fontSize: 12.sp,
      fontWeight: fontWeight,
      color: color,
    );
  }
  static TextStyle textStyle20(
      {Color color = AppColor.greyColor6,
        FontWeight fontWeight = FontWeight.w400}) {
    return GoogleFonts.poppins(
      fontSize: 20.sp,
      fontWeight: fontWeight,
      color: color,
    );
  }

  static TextStyle textStyleUnderLine(
      {Color color = AppColor.greyColor6,
      FontWeight fontWeight = FontWeight.w600}) {
    return TextStyle(
      fontSize: 10,
      fontWeight: fontWeight,
      color: color,
      decoration: TextDecoration.underline,
    );
  }

  static TextStyle textStyle11(
      {Color color = AppColor.greyColor4,
      FontWeight fontWeight = FontWeight.w400}) {
    return GoogleFonts.poppins(
      fontSize: 11.sp,
      fontWeight: fontWeight,
      color: color,
    );
  }

  static TextStyle textStyleMedium14(
      {Color color = AppColor.greyColor6,
      FontWeight fontWeight = FontWeight.w500}) {
    return GoogleFonts.poppins(
      fontSize: 14.sp,
      fontWeight: fontWeight,
      color: color,
    );
  }
  static TextStyle textStyleMedium_14(
      {Color color = AppColor.csBlueThemeColor,
        FontWeight fontWeight = FontWeight.w500}) {
    return GoogleFonts.poppins(
      fontSize: 14.sp,
      fontWeight: fontWeight,
      color: color,
    );
  }

  static TextStyle textStyle16(
      {Color color = AppColor.white, FontWeight fontWeight = FontWeight.w400}) {
    return GoogleFonts.poppins(
      fontSize: 16.sp,
      fontWeight: fontWeight,
      color: color,
    );
  }

  static TextStyle textStyleMedium16(
      {Color color = AppColor.white, FontWeight fontWeight = FontWeight.w600}) {
    return GoogleFonts.poppins(
        fontWeight: fontWeight, color: color, fontSize: 16.sp);
  }

  static TextStyle textStyle26(
      {Color color = AppColor.greyColor7,
        FontWeight fontWeight = FontWeight.bold}) {
    return GoogleFonts.poppins(
      fontSize: 28.sp,
      fontWeight: fontWeight,
      color: color,
    );
  }

  static TextStyle textStyle28(
      {Color color = AppColor.greyColor7,
      FontWeight fontWeight = FontWeight.bold}) {
    return GoogleFonts.poppins(
      fontSize: 28.sp,
      fontWeight: fontWeight,
      color: color,
    );
  }

  static TextStyle textStyleBold14(){
    return GoogleFonts.poppins(
      fontSize: Dimen.dimen_14.sp,
      fontWeight: FontWeight.bold,
      color: AppColor.greyColor9
    );
  }
  static TextStyle textStyleBoldBTC14(){
    return GoogleFonts.poppins(
        fontSize: Dimen.dimen_14.sp,
        fontWeight: FontWeight.bold,
        color: AppColor.csBlueThemeColor
    );
  }
  //CG4 greyColor4
  static TextStyle textStyleMedium4GC4(){
    return GoogleFonts.poppins(
        fontSize: Dimen.dimen_14.sp,
        fontWeight: FontWeight.w500,
        color: AppColor.greyColor4
    );
  }



}

extension HomeScreenTextTheme on TextTheme {
  TextStyle? get newLabel => AppStyle.csNormalText?.copyWith(
        color: AppColor.black,
        fontSize: Dimen.dimen_14.sp,
        fontWeight: FontWeight.w100,
      );

  TextStyle? get msmeLoan => AppStyle.csNormalText?.copyWith(
        color: AppColor.black,
        fontWeight: FontWeight.w700,
        fontSize: Dimen.dimen_14.sp,
      );

  TextStyle? get newApplicationInitiation => AppStyle.csNormalText?.copyWith(
        fontSize: Dimen.dimen_12.sp,
        fontWeight: FontWeight.normal,
        color: AppColor.greyColor13,
      );

  TextStyle? get getStarted => AppStyle.csNormalText?.copyWith(
    fontSize: Dimen.dimen_12.sp,
    fontWeight: FontWeight.normal,
    color: AppColor.white,
  );

  TextStyle? get quickItemLabel => AppStyle.csNormalText?.copyWith(
    fontSize: Dimen.dimen_14.sp,
    fontWeight: FontWeight.w500,
    color: AppColor.greyColor7,
  );

  TextStyle? get quickItemTitle => AppStyle.csNormalText?.copyWith(
    fontSize: Dimen.dimen_10.sp,
    fontWeight: FontWeight.w500,
    color: AppColor.greyColor9,
  );

  TextStyle? get tabTitle => AppStyle.csNormalText?.copyWith(
    fontSize: Dimen.dimen_10.sp,
    fontWeight: FontWeight.normal,
    color: AppColor.greyColor14,
  );

  TextStyle? get tabTitleActive => AppStyle.csNormalText?.copyWith(
    fontSize: Dimen.dimen_10.sp,
    fontWeight: FontWeight.w600,
    color: AppColor.black,
  );

  TextStyle? get breViewCollapseHeading => AppStyle.csNormalText?.copyWith(
    fontSize: Dimen.dimen_12.sp,
    fontWeight: FontWeight.normal,
    color: AppColor.blackBlueColor1
  );
  TextStyle? get breViewCollapseParameter => AppStyle.csNormalText?.copyWith(
      fontSize: Dimen.dimen_14.sp,
      fontWeight: FontWeight.normal,
      color: AppColor.greyColor6
  );



}

extension BreScreenModule on TextTheme{
    TextStyle? get achievedScore => AppStyle.csNormalText?.copyWith(
        fontSize: Dimen.dimen_12.sp,
        fontWeight: FontWeight.w500,
        color: AppColor.greyColor6
    );

    TextStyle? get loanEligibilityBlacklist => AppStyle.csNormalText?.copyWith(
      fontWeight: FontWeight.normal,
      fontSize: Dimen.dimen_10.sp,
      color: AppColor.greyColor6
    );

    TextStyle? get sortByCreationDate => AppStyle.csNormalText?.copyWith(
        fontWeight: FontWeight.w500,
        fontSize: Dimen.dimen_14.sp,
        color: AppColor.greyColor6
    );

    TextStyle? get sortByRadioButton => AppStyle.csNormalText?.copyWith(
        fontWeight: FontWeight.w500,
        fontSize: Dimen.dimen_14.sp,
        color: AppColor.greyColor9
    );

    TextStyle? get sortByText => AppStyle.csNormalText?.copyWith(
        fontWeight: FontWeight.w500,
        fontSize: Dimen.dimen_10.sp,
        color: AppColor.blackBlueColor14
    );


    ///Loan Offer Acceptance
  TextStyle? get detailsText12 => AppStyle.csNormalText?.copyWith(
        fontSize: Dimen.dimen_12.sp,
        fontWeight: FontWeight.w400,
        color: AppColor.greyColor6,
      );
  TextStyle? get detailsText12Medium => AppStyle.csNormalText?.copyWith(
        fontSize: Dimen.dimen_12.sp,
        fontWeight: FontWeight.w500,
        color: AppColor.blueBlack4,
      );
  TextStyle? get downloadText => AppStyle.csNormalText?.copyWith(
        fontSize: Dimen.dimen_14.sp,
        fontWeight: FontWeight.w500,
        color: AppColor.csBlueThemeColor,
      );
  TextStyle? get text12BlueBlack4 => AppStyle.csNormalText?.copyWith(
        fontSize: Dimen.dimen_12.sp,
        fontWeight: FontWeight.w400,
        color: AppColor.blueBlack4,
      );
  TextStyle? get text16HeaderText => AppStyle.csNormalText?.copyWith(
        fontSize: Dimen.dimen_16.sp,
        fontWeight: FontWeight.w400,
        color: AppColor.greyColor7,
      );
  TextStyle? get text12GreyColor4Text => AppStyle.csNormalText?.copyWith(
        fontSize: Dimen.dimen_12.sp,
        fontWeight: FontWeight.w400,
        color: AppColor.greyColor4,
      );
  TextStyle? get text12GreyColor4MediumText => AppStyle.csNormalText?.copyWith(
        fontSize: Dimen.dimen_12.sp,
        fontWeight: FontWeight.w500,
        color: AppColor.greyColor4,
      );
  TextStyle? get otpVerifiedText => AppStyle.csNormalText?.copyWith(
        fontSize: Dimen.dimen_14.sp,
        fontWeight: FontWeight.w500,
        color: AppColor.csGreenThemeColor,
      );
  TextStyle? get dialogHeaderText => AppStyle.csNormalText?.copyWith(
        fontSize: Dimen.dimen_12.sp,
        fontWeight: FontWeight.w500,
        color: AppColor.greyColor8,
      );
  TextStyle? get dialogBodyText => AppStyle.csNormalText?.copyWith(
        fontSize: Dimen.dimen_12.sp,
        fontWeight: FontWeight.w400,
        color: AppColor.blueBlack4,
      );

  ///Loan Application Initiation - Existing Business - Customer Details
  ///
  TextStyle? get customerLabelText => AppStyle.csNormalText?.copyWith(
        fontSize: Dimen.dimen_14.sp,
        fontWeight: FontWeight.w400,
        color: AppColor.greyColor7,
      );
  TextStyle? get customerDetailsHeaderText => AppStyle.csNormalText?.copyWith(
        fontSize: Dimen.dimen_14.sp,
        fontWeight: FontWeight.w500,
        color: AppColor.greyColor6,
      );

  TextStyle? get customerDetailsLabelText10 => AppStyle.csNormalText?.copyWith(
        fontSize: Dimen.dimen_10.sp,
        fontWeight: FontWeight.w400,
        color: AppColor.greyColor8,
      );
  TextStyle? get customerDetailsNormalText => AppStyle.csNormalText?.copyWith(
        fontSize: Dimen.dimen_10.sp,
        fontWeight: FontWeight.w400,
        color: AppColor.csGreenThemeColor,
      );
}

extension NewBusiness on TextTheme{

  TextStyle? get businessDetails => AppStyle.csNormalText?.copyWith(
    fontSize: Dimen.dimen_12.sp,
    fontWeight: FontWeight.w500,
    color: AppColor.greyColor7
  );
  TextStyle? get companyDetails => AppStyle.csNormalText?.copyWith(
      fontSize: Dimen.dimen_12.sp,
      fontWeight: FontWeight.w500,
      color: AppColor.greyColor7
  );

}




//
// extension LoginTextThemeExtension on TextTheme {
//   TextStyle? get rememberMeText => AppStyle.headLine1?.copyWith(
//         fontWeight: FontWeight.w400,
//         fontSize: Dimen.dimen_16.sp,
//       );
//
//   TextStyle? get forgetPasswordText => AppStyle.headLine1?.copyWith(
//         fontWeight: FontWeight.w400,
//         fontSize: Dimen.dimen_16.sp,
//       );
//
//   TextStyle? get rectButtonText => AppStyle.headLine1?.copyWith(
//         color: AppColor.primaryButtonTextColor,
//         fontWeight: FontWeight.w600,
//       );
// }
