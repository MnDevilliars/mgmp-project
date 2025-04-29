import 'package:flutter/material.dart';
import '../../appcolors/app_colors.dart';
import '../../components/artist_card.dart';
import '../../handler/request_handler.dart';
import '../../util/dropdown.dart';

class ArtistsPage extends StatefulWidget {
  const ArtistsPage({Key? key}) : super(key: key);

  @override
  State<ArtistsPage> createState() => _ArtistsPageState();
}

class _ArtistsPageState extends State<ArtistsPage> {
  final RequestHandler requestHandler = RequestHandler();
  List<dynamic> artistData = [];
  String selectedStatus = 'All';
  String selectedArtistType = 'All';
  bool isLoading = false;

  void fetchArtistData(String status, String artistType) async {
    setState(() {
      isLoading = true;
      selectedStatus = status;
      selectedArtistType = artistType;
    });

    final data = await requestHandler.artistsPageData(artistStatus: status, artistType: artistType);

    setState(() {
      artistData = data ?? [];
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchArtistData(selectedStatus, selectedArtistType);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Dropdown(
                    options: [
                      {'status': 'All'},
                      {'status': 'Pending'},
                      {'status': 'Approved'},
                      {'status': 'Rejected'},
                    ],
                    keyInfo: 'status',
                    label: "Select Status",
                    onChanged: (value) {
                      setState(() {
                        selectedStatus = value;
                      });
                      fetchArtistData(value, selectedArtistType);
                    },
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Dropdown(
                    options: [
                      {'artistType': 'All'},
                      {'artistType': 'Individual artist'},
                      {'artistType': 'Group artist'},
                    ],
                    keyInfo: 'artistType',
                    label: "Artist Type",
                    onChanged: (value) {
                      setState(() {
                        selectedArtistType = value;
                      });
                      fetchArtistData(selectedStatus, value);
                    },
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : artistData.isNotEmpty
                ? ListView.builder(
              itemCount: artistData.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: ArtistCard(artists: artistData[index]),
                );
              },
            )
                : const Center(child: Text("No Artists available")),
          ),
        ],
      ),
    );
  }
}
