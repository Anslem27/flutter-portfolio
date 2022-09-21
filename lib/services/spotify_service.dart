import 'package:spotify/spotify.dart';

class SpotifyService {
  static var credentials = SpotifyApiCredentials(
      '6ac6511f2ed1432e9917624fc7a67bef', 'd6331f83644e4d93b27f63bd97da3f3c');
  final spotify = SpotifyApi(credentials);
  //playlist from which you want to fetch fav songs
  final desiredPlaylist = "0GZxAonasF2U7QGyVBdZqM";

  getUserPlaylists() async {
    var usersPlaylists = await spotify.playlists
        .getUsersPlaylists('316mcic43djzxxpavdtc5ckm7eiu')
        .all();
    return usersPlaylists;
  }

  getUserSpotifyUri() async {
    var userAccount = await spotify.users.get('316mcic43djzxxpavdtc5ckm7eiu');
    var spotifyUri = userAccount.uri;
    return spotifyUri;
  }

  getUsername() async {
    var userAccount = await spotify.users.get('316mcic43djzxxpavdtc5ckm7eiu');
    var displayName = userAccount.displayName;
    return displayName;
  }
}
