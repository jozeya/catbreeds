import 'package:catbreeds/models/catbreed.dart';
import 'package:catbreeds/screens/detail_page.dart';
import 'package:catbreeds/services/catbreed_service.dart';
import 'package:catbreeds/widgets/loading.dart';
import 'package:flutter/material.dart';

class BreedTile extends StatelessWidget {
  const BreedTile({
    required this.catBreed,
    super.key
  });

  final CatBreed? catBreed;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(catBreed?.name ?? ''),
                GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (_) => DetailPage(catBreed: catBreed)));
                    },
                    child: const Text("Más...")
                )
              ],
            ),
            Container(
              margin: const EdgeInsets.only(top: 8.0, bottom: 8.0),
              color: Colors.white,
              width: double.maxFinite,
              height: 250,
              child: FutureBuilder(
                  future: CatBreedService().getCatBreedImagePath(catBreed?.id ?? ''),
                  builder: (context, snapshot){
                    if (snapshot.hasData){
                      String path = snapshot.data!;
                      return Image.network(
                        path,
                        width: double.maxFinite,
                        height: 250,
                        fit: BoxFit.cover,
                      );
                    }else{
                      return const Loading();
                    }
                  }
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(catBreed?.origin ?? ''),
                Text(catBreed!.intelligence.toString()),
              ],
            ),
          ],
        ),
      ),
    );
  }
}