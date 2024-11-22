import 'package:catbreeds/models/catbreed.dart';
import 'package:catbreeds/services/catbreed_service.dart';
import 'package:catbreeds/widgets/breed_tile.dart';
import 'package:catbreeds/widgets/loading.dart';
import 'package:flutter/material.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {

  final TextEditingController searchInput = TextEditingController();
  late Future<List<CatBreed>> fCatBreedData;
  List<CatBreed> catBreedData = [];
  List<CatBreed> catBreedDataFilter = [];
  late String searchText;
  bool isFiltering = false;

  @override
  void initState() {
    searchText = "";
    fCatBreedData = CatBreedService().getCatBreedInfoList();
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
                      onPressed: () {
                        isFiltering = true;
                        setState(() {});
                        Future.delayed(const Duration(milliseconds: 100), (){
                          setState(() {
                            catBreedDataFilter =
                                catBreedData.where((e) =>
                                    e.name!.toLowerCase()
                                        .contains(searchInput.text.toLowerCase())).toList();
                            isFiltering = false;
                            FocusScope.of(context).unfocus();
                          });
                        });
                      },
                      icon: const Icon(Icons.search)
                  ),
                  border: const OutlineInputBorder()
              ),
            ),
          ),
          isFiltering ? Expanded(child: Loading()) : Expanded(
            child: FutureBuilder(
                future: fCatBreedData,
                builder: (context, snapshot){
                  if (snapshot.hasData){
                    if (catBreedData.isEmpty){
                      catBreedData = snapshot.data!;
                      catBreedDataFilter = catBreedData;
                    }

                    return ListView.builder(
                        itemCount: catBreedDataFilter.length,
                        itemBuilder: (context, idx){
                          return BreedTile(
                              catBreed: catBreedDataFilter[idx]
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
