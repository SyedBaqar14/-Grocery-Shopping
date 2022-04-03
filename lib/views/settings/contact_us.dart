import 'package:flutter/material.dart';
import 'package:grocery_shopping/views/paint/contact_us_clip_path.dart';
import 'package:grocery_shopping/views/settings/components/contact_us_column.dart';
import 'package:grocery_shopping/views/settings/components/contact_us_header.dart';
import 'package:line_icons/line_icons.dart';

class ContactUs extends StatefulWidget {
  const ContactUs({Key? key}) : super(key: key);
  @override
  _ContactUsState createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            ClipPath(
                clipper: ContactClipPath(), child: const ContactUsHeader()),

            // const Align(
            //   alignment: Alignment(-0.6, -0.2),
            //   child: CircleAvatar(
            //     radius: 30,
            //     backgroundColor: Colors.white,
            //     backgroundImage: NetworkImage(
            //         "https://thumbs.dreamstime.com/b/attractive-woman-listening-to-music-her-mobile-set-trendy-pink-headphones-smiling-happily-as-checks-screen-78201488.jpg"),
            //   ),
            // ),
            // const Align(
            //   alignment: Alignment(0.6, -0.2),
            //   child: CircleAvatar(
            //     radius: 50,
            //     backgroundColor: Colors.white,
            //     backgroundImage: NetworkImage(
            //         "https://media-exp1.licdn.com/dms/image/C4D03AQG5iBGZghDNQQ/profile-displayphoto-shrink_200_200/0/1638208870650?e=1646265600&v=beta&t=Af75jPuP1lKLTbbWKp2hwZoIeQ0mwJCMg_e9f36-ASE"),
            //   ),
            // ),
            const Padding(
              padding: EdgeInsets.all(22.0),
              child: ContactUsColumn(),
            )
          ],
        ),
      ),
    );
  }
}
