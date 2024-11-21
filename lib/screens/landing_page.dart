import 'package:catbreeds/models/catbreed.dart';
import 'package:catbreeds/services/catbreed_service.dart';
import 'package:catbreeds/widgets/breed_tile.dart';
import 'package:flutter/material.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {

  final TextEditingController searchInput = TextEditingController();
  late Future<List<CatBreed>> fCatBreedData;
  late String searchText;

  @override
  void initState() {
    searchText = "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Catbreeds"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchInput,
              decoration: InputDecoration(
                  suffixIcon: IconButton(
                      onPressed: (){
                        searchText = searchInput.text.toLowerCase();
                        setState(() {});
                      },
                      icon: const Icon(Icons.search)
                  ),
                  border: OutlineInputBorder()
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder(
                future: CatBreedService().getCatBreedInfoList(filter: searchText),
                builder: (context, snapshot){
                  if (snapshot.hasData){
                    List<CatBreed> catBreedData = snapshot.data!;
                    return ListView.builder(
                        itemCount: catBreedData.length,
                        itemBuilder: (context, idx){
                          return BreedTile(
                              catBreed: catBreedData[idx]
                          );
                        }
                    );
                  }else{
                    // return Container(child: const CircularProgressIndicator());
                    return Container(child: Text("Cargando..."),);
                  }
                }
            ),
          ),
        ],
      ),
    );
  }
}
