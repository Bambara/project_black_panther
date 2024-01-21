import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../controllers/organizer/tournament/ptpms_controller.dart';
import '../../../core/app_export.dart';
import '../../../generated/assets.dart';
import '../../../widgets/dropdown_button_widget.dart';
import '../../../widgets/flat_button_widget.dart';
import '../../../widgets/icon_button_widget.dart';
import '../../../widgets/loading_dialog.dart';
import '../../../widgets/ltw_attach_image.dart';
import '../../../widgets/search_text_field_widget.dart';
import '../../../widgets/svg_image_widget.dart';
import '../../../widgets/switch_widget.dart';
import '../../../widgets/text_field_widget.dart';

//PTPMScreen - PlayerTeamPaymentManagementScreen
class PTPMScreen extends GetView<PTPMSController> {
  ///Player teams payment management screen
  ///
  /// Manage and Add Coordinator team to tournaments
  const PTPMScreen({Key? key}) : super(key: key);

  Widget createCard(double screenWidth, double screenHeight, ThemeData themeData) {
    return Container(
      height: screenHeight * 0.3,
      width: screenWidth * 0.9,
      decoration: BoxDecoration(
        color: themeData.highlightColor,
        borderRadius: BorderRadius.all(Radius.circular((screenHeight / screenWidth) * Constants.boarderRadius)),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: SVGImageWidget(path: Assets.iconsVisaLogo, heightFactor: screenHeight * 0.00015, widthFactor: screenWidth * 0.0002, boarderRadius: 0, boarderStatus: false),
            ),
            Align(
              alignment: Alignment.center,
              child: TextFieldWidget(
                labelText: "",
                hintText: "Card Number",
                enableValidate: true,
                txtCtrl: controller.cardNumberCtrl,
                fontSize: 0.03,
                secret: false,
                heightFactor: 0.055,
                widthFactor: 0.9,
                inputType: TextInputType.number,
                validate: () {},
              ),
            ),
            SizedBox(height: screenHeight * 0.005),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    TextFieldWidget(
                      labelText: "",
                      hintText: "YY",
                      enableValidate: true,
                      txtCtrl: controller.yyCtrl,
                      fontSize: 0.03,
                      secret: false,
                      heightFactor: 0.055,
                      widthFactor: 0.18,
                      inputType: TextInputType.number,
                      validate: () {},
                    ),
                    const Text(' / '),
                    TextFieldWidget(
                      labelText: "",
                      hintText: "MM",
                      enableValidate: true,
                      txtCtrl: controller.mmCtrl,
                      fontSize: 0.03,
                      secret: false,
                      heightFactor: 0.055,
                      widthFactor: 0.16,
                      inputType: TextInputType.number,
                      validate: () {},
                    ),
                  ],
                ),
                TextFieldWidget(
                  labelText: "",
                  hintText: "CSV",
                  enableValidate: true,
                  txtCtrl: controller.csvCtrl,
                  fontSize: 0.03,
                  secret: false,
                  heightFactor: 0.055,
                  widthFactor: 0.18,
                  inputType: TextInputType.number,
                  validate: () {},
                ),
              ],
            ),
            SizedBox(height: screenHeight * 0.028),
            Align(
              alignment: Alignment.centerLeft,
              child: TextFieldWidget(
                labelText: "",
                hintText: "Name on card",
                enableValidate: true,
                txtCtrl: controller.cardNameCtrl,
                fontSize: 0.03,
                secret: false,
                heightFactor: 0.055,
                widthFactor: 0.7,
                inputType: TextInputType.text,
                validate: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget createBankTransfer(double screenWidth, double screenHeight, ThemeData themeData) {
    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: screenHeight * 0.001, vertical: screenHeight * 0.001),
          child: GetBuilder<PTPMSController>(
            builder: (controller) =>
                // ListViewWidget(heightFactor: 0.15, widthFactor: 0.8, itemList: controller.teamSideNames, removeItem: (index) => controller.removeTeamSide = index),
                Container(
              height: screenHeight * 0.2,
              width: screenWidth * 0.9,
              // color: themeData.highlightColor,
              decoration: BoxDecoration(
                color: themeData.colorScheme.secondary.withAlpha(25),
                borderRadius: BorderRadius.all(Radius.circular((screenHeight / screenWidth) * Constants.boarderRadius)),
              ),
              child: GridView.builder(
                addAutomaticKeepAlives: false,
                cacheExtent: 10,
                // itemCount: itemList.length,
                itemCount: controller.attachments.length,
                scrollDirection: Axis.vertical,
                padding: EdgeInsets.symmetric(vertical: screenHeight * 0.002),
                itemBuilder: (context, index) => LTWAttacheImage(
                  artWorks: controller.attachments,
                  index: index,
                  function: () {},
                  removeItem: (index) {
                    controller.removeArtWork(index);
                  },
                  navigate: () {},
                ),
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(maxCrossAxisExtent: 250, childAspectRatio: 3 / 2, crossAxisSpacing: 0, mainAxisSpacing: 0),
              ),
            ),
            // assignId: true,
            // id: 'attachments',
          ),
        ),
        Positioned(
          top: screenHeight * 0.15,
          left: screenHeight * 0.455,
          child: IconButtonWidget(
            imagePath: Assets.iconsAddCircle,
            function: () {
              controller.pickAttachment().then((value) => controller.setAttachment = value);
            },
            iconData: FontAwesomeIcons.paperclip,
            isIcon: true,
            iconSize: screenWidth * 0.06,
            color: themeData.colorScheme.secondary,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final themeData = Theme.of(context);

    return Scaffold(
      backgroundColor: themeData.scaffoldBackgroundColor,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Payment Management',
          style: TextStyle(fontSize: themeData.textTheme.titleLarge!.fontSize),
        ),
      ),
      body: SingleChildScrollView(
        child: GetBuilder<PTPMSController>(
          builder: (controller) => controller.loading
              ? Padding(
                  padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: Center(
                    child: Column(
                      children: [
                        SizedBox(height: screenHeight * 0.02),
                        SizedBox(
                          width: screenWidth * 0.9,
                          // height: screenHeight * 0.15,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Payment Details'),
                              const Divider(),
                              Row(
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text('     Pay Reason'),
                                      SizedBox(height: screenHeight * 0.01),
                                      const Text('     Pay Reason Id'),
                                      SizedBox(height: screenHeight * 0.01),
                                      const Text('     Target Id'),
                                      SizedBox(height: screenHeight * 0.01),
                                      // const Text('     Payer Type'),
                                      // SizedBox(height: screenHeight * 0.01),
                                      const Text('     Trace'),
                                      SizedBox(height: screenHeight * 0.01),
                                    ],
                                  ),
                                  GetBuilder<PTPMSController>(
                                    builder: (controller) => Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('  :  ${controller.paymentReasonType}'),
                                        SizedBox(height: screenHeight * 0.01),
                                        Text('  :  ${controller.payReasonId}'),
                                        SizedBox(height: screenHeight * 0.01),
                                        Text('  :  ${controller.targetId}'),
                                        SizedBox(height: screenHeight * 0.01),
                                        // Text('  :  ${controller.payerType}'),
                                        // SizedBox(height: screenHeight * 0.01),
                                        Text('  :  ${controller.trace}'),
                                        SizedBox(height: screenHeight * 0.01),
                                      ],
                                    ),
                                    id: 'paymentReasonType',
                                    assignId: true,
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.02),
                        GetBuilder<PTPMSController>(
                          builder: (controller) => DropDownButtonWidget(
                            selectData: controller.selectPayReasonType,
                            isRequired: true,
                            label: "Payment Reason Type",
                            items: controller.paymentReasonTypes,
                            heightFactor: 0.057,
                            widthFactor: 0.9,
                            valveChoose: controller.paymentReasonType,
                          ),
                          id: 'paymentReasonType',
                          assignId: true,
                        ),
                        SizedBox(height: screenHeight * 0.02),
                        GetBuilder<PTPMSController>(
                          builder: (controller) => SearchTextFieldWidget(
                            hintText: 'Payment Reason',
                            labelText: 'Payment Reason',
                            enableValidate: true,
                            txtCtrl: controller.payReasonCtrl,
                            fontSize: 0.03,
                            heightFactor: 0.057,
                            widthFactor: 0.9,
                            inputType: TextInputType.text,
                            items: controller.payReasons,
                            onItemTap: (p0) {
                              controller.getReasonId(p0);
                            },
                          ),
                          assignId: true,
                          id: 'payReason',
                        ),
                        SizedBox(height: screenHeight * 0.02),
                        GetBuilder<PTPMSController>(
                          builder: (controller) => SearchTextFieldWidget(
                            hintText: 'Target Team',
                            labelText: 'Target Team',
                            enableValidate: true,
                            txtCtrl: controller.teamNameCtrl,
                            fontSize: 0.03,
                            heightFactor: 0.057,
                            widthFactor: 0.9,
                            inputType: TextInputType.text,
                            items: controller.teamNames,
                            onItemTap: (p0) {
                              controller.getTargetId(p0);
                            },
                          ),
                          assignId: true,
                          id: 'targetTeam',
                        ),
                        SizedBox(height: screenHeight * 0.02),
                        GetBuilder<PTPMSController>(
                          builder: (controller) => DropDownButtonWidget(
                            selectData: controller.selectTeamType,
                            isRequired: true,
                            label: "Payment Method",
                            items: controller.paymentMethods,
                            heightFactor: 0.057,
                            widthFactor: 0.9,
                            valveChoose: controller.paymentMethode,
                          ),
                          id: 'payMethod',
                          assignId: true,
                        ),
                        GetBuilder<PTPMSController>(
                          builder: (controller) => controller.paymentMethode == 'Card' || controller.paymentMethode == 'Bank Transfer' ? SizedBox(height: screenHeight * 0.02) : const SizedBox(),
                          id: 'payMethod',
                          assignId: true,
                        ),
                        GetBuilder<PTPMSController>(
                          builder: (controller) => controller.paymentMethode == 'Card'
                              ? createCard(screenWidth, screenHeight, themeData)
                              : controller.paymentMethode == 'Bank Transfer'
                                  ? createBankTransfer(screenWidth, screenHeight, themeData)
                                  : const SizedBox(),
                          id: 'payMethod',
                          assignId: true,
                        ),
                        SizedBox(height: screenHeight * 0.02),
                        TextFieldWidget(
                          labelText: "Pay Amount",
                          hintText: "Pay Amount",
                          enableValidate: true,
                          txtCtrl: controller.payAmountCtrl,
                          fontSize: 0.03,
                          secret: false,
                          heightFactor: 0.055,
                          widthFactor: 0.9,
                          inputType: TextInputType.number,
                          validate: () {},
                        ),
                        SizedBox(height: screenHeight * 0.02),
                        TextFieldWidget(
                          labelText: "Reference Number",
                          hintText: "Reference Number",
                          enableValidate: true,
                          txtCtrl: controller.refNumberCtrl,
                          fontSize: 0.03,
                          secret: false,
                          heightFactor: 0.055,
                          widthFactor: 0.9,
                          inputType: TextInputType.text,
                          validate: () {},
                        ),
                        SizedBox(height: screenHeight * 0.02),
                        TextFieldWidget(
                          labelText: "Remark",
                          hintText: "Remark",
                          enableValidate: false,
                          txtCtrl: controller.remarkCtrl,
                          fontSize: 0.03,
                          secret: false,
                          heightFactor: 0.055,
                          widthFactor: 0.9,
                          inputType: TextInputType.text,
                          validate: () {},
                        ),
                        SizedBox(height: screenHeight * 0.02),
                        GetBuilder<PTPMSController>(
                          builder: (controller) => SwitchWidget(
                              label: 'Approve Status',
                              changeStatus: controller.onChangeStatus,
                              heightFactor: 0.057,
                              widthFactor: 0.5,
                              textSize: themeData.textTheme.bodyMedium?.fontSize,
                              valveChoose: controller.approveStatus),
                          id: 'approveStatus',
                          assignId: true,
                        ),
                        SizedBox(height: screenHeight * 0.02),
                        FlatButtonWidget(
                            title: "Pay",
                            function: () {
                              controller.makePayment(context);
                            },
                            heightFactor: 0.07,
                            widthFactor: 0.5,
                            color: themeData.colorScheme.secondary),
                        SizedBox(height: screenHeight * 0.02),
                      ],
                    ),
                  ),
                )
              : loadingDialog(context),
          assignId: true,
          id: 'tab',
        ),
      ),
    );
  }
}
