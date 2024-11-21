import 'package:catbreeds/models/catbreed.dart';
import 'package:catbreeds/services/catbreed_service.dart';
import 'package:catbreeds/widgets/loading.dart';
import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({required this.catBreed, super.key});

  final CatBreed? catBreed;

  @override
  Widget build(BuildContext context) {
    double mHeight = MediaQuery.of(context).size.height / 2;

    return Scaffold(
      appBar: AppBar(
        title: Text(catBreed?.name ?? ''),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(
              width: double.maxFinite,
              height: mHeight,
              child: FutureBuilder(
                  future: CatBreedService().getCatBreedImagePath(catBreed?.id ?? ''),
                  builder: (context, snapshot){
                    if (snapshot.hasData){
                      String path = snapshot.data!;
                      return Image.network(
                          path,
                          width: double.maxFinite,
                          height: mHeight,
                          fit: BoxFit.cover
                      );
                    }else{
                      return const Loading();
                    }
                  }
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(catBreed?.description ?? '', style: TextStyle(fontSize: 18)),
                    Text('País: ${catBreed?.origin ?? ''}', style: TextStyle(fontSize: 18)),
                    Text('Inteligencia: ${catBreed?.intelligence.toString() ?? ''}',style: TextStyle(fontSize: 18)),
                    Text('Adaptabilidad: ${catBreed?.adaptability.toString() ?? ''}',style: TextStyle(fontSize: 18)),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
