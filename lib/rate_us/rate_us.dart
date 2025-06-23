import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:in_app_review/in_app_review.dart';
import 'package:lottie/lottie.dart';

class RateUsView extends StatefulWidget {
  @override
  _RateUsViewState createState() => _RateUsViewState();
}

class _RateUsViewState extends State<RateUsView> {
  int _rating = 0;

  void _submitRating() async {
    if (_rating > 0) {
      final InAppReview inAppReview = InAppReview.instance;
      if (_rating >= 3) {
        log('RateUs: _rating >= 3, trying inAppReview.isAvailable()');
        if (await inAppReview.isAvailable()) {
          log('RateUs: inAppReview.requestReview() called');
          await inAppReview.requestReview();
        } else {
          log('RateUs: inAppReview.openStoreListing() called');
          await inAppReview.openStoreListing();
        }
      } else {
        log('RateUs: Feedback < 3 stars, showing snackbar');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Thanks for your feedback!'.tr())),
        );
      }
      Navigator.of(context).pop();
    } else {
      log('RateUs: No star selected, showing snackbar');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please select star.'.tr())),
      );
    }
  }

  Widget _buildStar(int index) {
    final height = MediaQuery.of(context).size.height;
    return IconButton(
      icon: Icon(
        index <= _rating ? Icons.star : Icons.star_border,
        color: Colors.amber,
        size: height * 0.04,
      ),
      onPressed: () {
        setState(() {
          _rating = index;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset('assets/icons/rate_us.json', height: height * 0.2),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: height * 0.02),
              child: Center(
                child: Text(
                  'Your feedback is important to us!'.tr(),
                  style: TextStyle(fontSize: height * 0.025),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) => _buildStar(index + 1)),
            ),
            SizedBox(height: height * 0.02),
            GestureDetector(
              onTap: _submitRating,
              child: Container(
                width: height * 0.25,
                height: height * 0.05,
                decoration: BoxDecoration(
                  color: Colors.amber[700],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text('Submit'.tr(),
                      style: TextStyle(fontSize: height * 0.025)),
                ),
              ),
            ),

            // ElevatedButton(
            //   onPressed: _submitRating,
            //   child: Text('Gönder', style: TextStyle(fontSize: height * 0.025)),
            // ),
          ],
        ),
      ),
    );
  }
}
