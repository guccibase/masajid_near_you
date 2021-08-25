import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:masajid_near_you/common/common_widgets.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("About UMRA Tech"),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Center(
        child: Container(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  basmalah(context),
                  SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Assalaamu Alaikum Ummah of Muhammad Rasool Allah sallallaahu alaihi wa sallam!\n\n'
                        'My name is Tahir, the founder of UMRA Tech which is a company I started with the intention of building free, '
                        'privacy focused Islamic apps with no ads whatsoever.\n'
                        '\n'
                        'What motivated me to start this endeavour was the scandal regarding the most popular '
                        'Islamic app out there and what they did with the data they were collecting from '
                        'Muslims as well as showing inappropriate ads in their app for non-premium users. InshaAllah I want to give '
                        'Muslims an alternative to that which is why I started this company single-handedly without any backers '
                        'and finance. So UMRA Tech and Halal Places app is owned by me, Tahir, not a corporation. '
                        'I believe success is with Allah alone and with your support we can get these apps to '
                        'reach many muslims around the word.'
                        '\n'
                        '\n'
                        'UMRA Tech stands for Ummat Muhammad Rasool Allah Technologies.\n\n'
                        'Please support this project by following our social media accounts, downloading our apps and sharing with other muslims you know and '
                        'get your own portion of the reward inshaAllah.\n'
                        '\n'
                        'Follow @umratech on Twitter and @umratechnologies on IG.\n'
                        '\n'
                        'Link to all our current apps https://linktr.ee/Umratech\n'
                        '\n'
                        'JazakAllahu khairan.',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
