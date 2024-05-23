import 'package:flutter/material.dart';

class ShowCharacterDetailsDialog extends StatelessWidget {
  const ShowCharacterDetailsDialog({super.key, this.character});
  // ignore: prefer_typing_uninitialized_variables
  final character;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${character.character?.name ?? 'N/A'}',
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back_ios_new_rounded)),
      ),
      body: SingleChildScrollView(
        //height: double.infinity,
        child: Column(
          children: [
            SizedBox(
                height: MediaQuery.of(context).size.height / 2.5,
                width: MediaQuery.of(context).size.width / 1.5,
                // clipBehavior: Clip.hardEdge,
                child: Card(
                  clipBehavior: Clip.hardEdge,
                  child: Image.network(
                    character.character?.images?.jpg?.imageUrl ?? '',
                    fit: BoxFit.cover,
                  ),
                )),

            //   Text('Character: ${character.character?.name ?? 'N/A'}'),
            // Center(
            //   child: Text('${character.character?.name ?? 'N/A'}',
            //       style: const TextStyle(fontSize: 24)),
            // ),
            Card(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.favorite,
                    color: Colors.pink,
                    size: 32,
                  ),
                  Text(
                      '${character.favorites.toString()} \t ${character.role ?? 'N/A'}',
                      style: const TextStyle(fontSize: 24)),
                ],
              ),
            ),

            if (character.voiceActors != null)
              for (var voiceActor in character.voiceActors!)
                SizedBox(
                  height: 100,
                  child: Card(
                    clipBehavior: Clip.hardEdge,
                    child: Row(children: [
                      Image.network(
                        voiceActor.person?.images?.jpg?.imageUrl ?? '',
                        fit: BoxFit.cover,
                        width: MediaQuery.of(context).size.width / 4,
                      ),
                      const SizedBox(width: 20),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            voiceActor.person?.name ?? 'N/A',
                          ),
                          Text(
                            'Language: ${voiceActor.language ?? 'N/A'}',
                          ),
                        ],
                      )
                    ]),
                  ),
                ),

            // Display voice actors information in the AlertDialog
          ],
        ),
      ),
    );
  }
}
