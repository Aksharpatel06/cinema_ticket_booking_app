import 'dart:developer';

import 'package:cinema_booking_app/utils/color.dart';
import 'package:cinema_booking_app/view/helper/firestore_services.dart';
import 'package:cinema_booking_app/view/modal/cinema_user_modal.dart';
import 'package:cinema_booking_app/view/screen/profile/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';

import '../../controller/payment_cubic/payment_cubit.dart';
import '../../helper/authentication_services.dart';
import '../../modal/cinema_modal.dart';
import '../../modal/movie_modal.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen(
      {super.key,
      required this.cinema,
      required this.dataList,
      required this.movieModal,
      required this.index,
      required this.dateTime,
      required this.total,
      required this.cinemaTiming});

  final Cinema cinema;
  final String cinemaTiming;
  final MovieModal movieModal;
  final int index;
  final DateTime dateTime;
  final int total;
  final List<CinemaUserModal> dataList;

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  @override
  Widget build(BuildContext context) {
    List<String> goldIndices = [];
    List<String> regularIndices = [];
    List<String> platinumIndices = [];

    for (CinemaUserModal data in widget.dataList) {
      if (data.category == 'Gold') {
        goldIndices.add(data.index.toString());
      } else if (data.category == 'Regular') {
        regularIndices.add(data.index.toString());
      } else if (data.category == 'Platinum') {
        platinumIndices.add(data.index.toString());
      }
    }
    String code =
        '${widget.movieModal.movieName}${widget.cinema.cinema}${widget.dateTime.day}${widget.dateTime.month}${widget.cinemaTiming}';

    TextEditingController txtPhone = TextEditingController();
    TextEditingController txtOtp = TextEditingController();
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: appBarColor,
        leading: const BackButton(
          color: secondaryColor,
        ),
        title: const Text(
          "Pay for Tickets",
          style: TextStyle(
              color: primaryColor, fontWeight: FontWeight.w500, fontSize: 20),
        ),
        centerTitle: true,
      ),
      body: Column(children: [
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.movieModal.movieName,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 16),
                _buildInfoRow('Cinema', widget.cinema.cinema),
                const SizedBox(height: 4),
                _buildInfoRow('Address', widget.cinema.area),
                const SizedBox(height: 8),
                _buildInfoRow('Date',
                    '${widget.dateTime.day} ${intToMonthString(widget.dateTime.month)} ${widget.dateTime.year}, ${widget.cinema.data[widget.index].time}'),
                const SizedBox(height: 8),
                _buildInfoRow('Hall', '6th'),
                const SizedBox(height: 8),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      width: 74,
                      child: Text(
                        'Seats',
                        style: TextStyle(
                          color: Color(0xFF637393),
                          fontSize: 14,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (regularIndices.isNotEmpty)
                          Row(children: [
                            const Text(
                              'Regular ',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            ...List.generate(
                              regularIndices.length,
                              (index) => Text(
                                '${regularIndices[index]},',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ]),
                        if (goldIndices.isNotEmpty)
                          Row(children: [
                            const Text(
                              'Gold ',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            ...List.generate(
                              goldIndices.length,
                              (index) => Text(
                                '${goldIndices[index]},',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ]),
                        if (platinumIndices.isNotEmpty)
                          Row(children: [
                            const Text(
                              'Platinum ',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            ...List.generate(
                              platinumIndices.length,
                              (index) => Text(
                                '${platinumIndices[index]},',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ]),
                      ],
                    )
                  ],
                ),
                const SizedBox(height: 8),
                _buildInfoRow('Total', widget.total.toString()),
                const SizedBox(height: 16),
                const Divider(thickness: 1, color: appBarColor),
              ],
            ),
          ),
          const SizedBox(height: 16),
          _buildDotRow(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: BlocConsumer<PaymentCubit, PaymentState>(
              listener: (context, state) {
                if (state is PaymentError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.message)),
                  );
                }
              },
              builder: (context, state) {
                if (state is PaymentInitial) {
                  return _buildPhoneNumberInput(context, txtPhone);
                } else if (state is PaymentOtpSent) {
                  return _buildOtpInput(context, txtOtp);
                } else if (state is PaymentProcessing) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is PaymentCompleted) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () async {
                          log(code);
                          if (widget.dataList.isNotEmpty) {
                            for (CinemaUserModal cinema in widget.dataList) {
                              cinema.user = AuthenticationServices
                                  .authenticationServices
                                  .currentUser()!
                                  .phoneNumber;
                              FireStoreServices.fireStoreServices.ticketBooking(
                                  code,
                                  '${cinema.category}${cinema.index}',
                                  cinema);
                              cinema.time = widget.cinemaTiming;
                              cinema.area = widget.cinema.area;
                              cinema.cinema = widget.cinema.cinema;
                              cinema.movie = widget.movieModal.movieName;
                              cinema.date =
                                  "${widget.dateTime.day}/${widget.dateTime.month}/${widget.dateTime.year}";
                              cinema.imgPath = widget.movieModal.image;
                              FireStoreServices.fireStoreServices
                                  .userTicketBooking(cinema);
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => ProfilePage(),
                              ));
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Select a seat first in booking"),
                                duration: Duration(seconds: 2),
                              ),
                            );
                          }
                        },
                        child: Container(
                          height: 56.h,
                          width: 160.w,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: appBarColor,
                            border: Border.all(color: appBarColor),
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Text(
                            'Refund',
                            style: TextStyle(
                              color: primaryColor,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {},
                        child: Container(
                          height: 56.h,
                          width: 160,
                          alignment: Alignment.center,
                          decoration: ShapeDecoration(
                            gradient: buttonColor,
                            shape: buttonRadius,
                            shadows: buttonShadow,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.send,
                                color: Colors.white,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                'Send',
                                style: TextStyle(
                                  color: primaryColor,
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                } else {
                  return const Center(child: Text("Something went wrong"));
                }
              },
            ),
          ),
        ]),
      ]),
    );
  }

  Widget _buildPhoneNumberInput(
      BuildContext context, TextEditingController txtPhone) {
    return Column(
      children: [
        TextField(
          controller: txtPhone,
          style: const TextStyle(
            color: primaryColor,
          ),
          keyboardType: TextInputType.phone,
          textInputAction: TextInputAction.done,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderSide: const BorderSide(color: secondaryColor, width: 0.8),
              borderRadius: BorderRadius.circular(8.r),
            ),
            hintText: 'Phone Number',
            hintStyle: const TextStyle(
              color: secondaryColor,
            ),
          ),
        ),
        SizedBox(
          height: 10.h,
        ),
        GestureDetector(
          onTap: () {
            context.read<PaymentCubit>().sendOtp(txtPhone.text);
          },
          child: Container(
            height: 56.h,
            width: double.infinity,
            alignment: Alignment.center,
            decoration: ShapeDecoration(
              gradient: buttonColor,
              shape: buttonRadius,
              shadows: buttonShadow,
            ),
            child: Text(
              'Continue',
              style: TextStyle(
                color: primaryColor,
                fontSize: 18.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget _buildOtpInput(BuildContext context, TextEditingController txtOtp) {
    return Column(
      children: [
        Pinput(
          length: 6,
          controller: txtOtp,
          showCursor: true,
        ),
        SizedBox(
          height: 10.h,
        ),
        GestureDetector(
          onTap: () {
            context.read<PaymentCubit>().verifyOtp(txtOtp.text);
          },
          child: Container(
            height: 56.h,
            width: double.infinity,
            alignment: Alignment.center,
            decoration: ShapeDecoration(
              gradient: buttonColor,
              shape: buttonRadius,
              shadows: buttonShadow,
            ),
            child: Text(
              'Verify',
              style: TextStyle(
                color: primaryColor,
                fontSize: 18.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            context.read<PaymentCubit>().changeNumber();
          },
          child: Text(
            'Change number',
            style: TextStyle(
              color: secondaryColor,
              fontSize: 14.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }

  String intToMonthString(int month) {
    const monthNames = [
      "Jan",
      "Feb",
      "March",
      "April",
      "May",
      "June",
      "July",
      "Aug",
      "Sept",
      "Oct",
      "Nov",
      "Dec"
    ];

    // Adjust for zero-based index
    if (month < 1 || month > 12) {
      return "Invalid month";
    }
    return monthNames[month - 1];
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      children: [
        SizedBox(
          width: 74,
          child: Text(
            label,
            style: const TextStyle(
              color: Color(0xFF637393),
              fontSize: 14,
            ),
          ),
        ),
        const SizedBox(width: 16),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildDotRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(
          16,
          (index) => const Padding(
                padding: EdgeInsets.symmetric(horizontal: 5),
                child: CircleAvatar(
                  radius: 6,
                  backgroundColor: Color(0xFF101A2A),
                ),
              )),
    );
  }
}
