import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';

class DetailNews extends StatelessWidget {
  const DetailNews({super.key, this.newsImage, this.title, this.content, this.date, this.viewer});
  final String? newsImage;
  final String? title;
  final String? date;
  final String? content;
  final String? viewer;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: size.width,
                height: size.width / 1.2,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(bottomRight: Radius.elliptical(30, 10), bottomLeft: Radius.elliptical(30, 10)),
                  image: newsImage != null ? DecorationImage(image: NetworkImage(newsImage!), fit: BoxFit.cover, onError: (exception, stackTrace) => Image.asset('assets/images/news_error.jpg', fit: BoxFit.cover)) : const DecorationImage(image: AssetImage('assets/images/news_error.jpg'), fit: BoxFit.cover)
                ),
                child: Stack(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CupertinoButton(child: const Icon(Iconsax.arrow_left_1_outline, color: Colors.white), onPressed: (){
                              Get.back();
                            }),
                            Row(
                              children: [
                                CupertinoButton(child: const Icon(Clarity.share_line, color: Colors.white), onPressed: (){}),
                                CupertinoButton(child: const Icon(Iconsax.archive_1_outline, color: Colors.white), onPressed: (){}),
                                ],
                              )
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(date ?? "0 min ago", style: const TextStyle(color: Colors.white60)),
                                Row(
                                  children: [
                                    const Icon(Clarity.eye_line, color: Colors.white60),
                                    const SizedBox(width: 5),
                                    Text(viewer ?? "0", style: const TextStyle(color: Colors.white60))
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      )
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // title
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        width: 4,
                        color: Colors.orange,
                      ),
                
                      const SizedBox(width: 8),
                
                      // Teks utama
                      Expanded(
                        child: Text(
                          title ?? 'Tidak ada judul',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            height: 1.4, // Line height jika ingin spacing
                            color: Colors.white70
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: Text(content != null ? content!.replaceAll('\\r\\n', ' ') : 'adalah perusahaan yang bergerak di bidang layanan pengembangan teknologi digital, khususnya jasa pembuatan website dan aplikasi mobile (Android & iOS). Kami berkomitmen untuk membantu pelaku usaha, organisasi, dan individu dalam menciptakan solusi digital yang modern, fungsional, dan sesuai kebutuhan bisnis. Dengan tim profesional yang berpengalaman di bidang UI/UX design, software engineering, dan mobile development, kami menyediakan layanan end-to-end mulai dari analisa kebutuhan, perancangan desain, pengembangan, hingga pemeliharaan sistem.', style: const TextStyle(color: Colors.white60)),
              )
            ],
          ),
        ),
      ),
    );
  }
}