/// This code does not pretend to be a full-fledged music library,
/// but it quite accurately implements its main functions in Swift:
/// storing track data in a collection, unloading "playlists" by a certain genre,
/// adding and removing tracks from the "Media library".
/// N. Bogdanov (c)


// Track structure containing properties-information about the music track
struct Track {
    var name: String
    var artist: String
    var duration: Double
    var country: String
    var genre: String
}

// class "Media Library" (music library)
public class MediaLibrary {
    // playlists-arrays
    var listOfPlaylists: [String] = []
    
    // method for aggregating all playlists
    func addPlaylist(name: String) {
        listOfPlaylists.append(name)
    }
}

// abstraction-class "Playlist (track category)"
public class FirstPlaylist {
    var name: String
    // list of songs
    var songList: [Track]
    var numberOfTracks: Int {
        return songList.count
    }
    
    func add(song: Track) {
        // check for adding a repeated track
        if checkForRepeatingTrack(testedSong: song) {
            print("You are trying to add a track that is already in the playlist!\n")
        } else {
        self.songList.append(song)
        }
    }
    
    func delete(title: String) {
        var index = 0
        for song in self.songList {
            if song.name == title {
                self.songList.remove(at: index)
            }
            index += 1
        }
    }
    
    init(name: String, songList: [Track]) {
        self.name = name
        self.songList = songList
    }
    
    // method that checks for the presence of a newly added track in the playlist
    func checkForRepeatingTrack(testedSong: Track) -> Bool {
        for item in self.songList {
            if (item.artist == testedSong.artist) && 
            (item.country == testedSong.country) && 
            (item.duration == testedSong.duration) && 
            (item.genre == testedSong.genre) && 
            (item.name == testedSong.name) {
                return true
            }
        }
        return false
    }
}

// create a collection of tracks
var medialibrary:[Track] = [Track(name: "Austronaut in the ocean", artist: "Masked Wolf", duration: 2.13, country: "USA", genre: "Rap"),
                            Track(name: "Godzilla", artist: "Eminem", duration: 3.31, country: "USA", genre: "Rap"),
                            Track(name: "Back in Black", artist: "AC/DC", duration: 4.16, country: "USA", genre: "Rock"),
                            Track(name: "Rockstar", artist: "Nickelback", duration: 4.12, country: "USA", genre: "Rock"),
                            Track(name: "Photograph", artist: "Nickelback", duration: 4.19, country: "USA", genre: "Rock"),
                            Track(name: "Кто убил Марка?", artist: "Oxxxymiron", duration: 9.28, country: "Russia", genre: "Rap")]

// get only "Rap" songs from the shared library
let rapSongs = medialibrary.filter {$0.genre == "Rap"}

// create an instance of the "First Playlist" class - rap music
var rapMusic: FirstPlaylist = FirstPlaylist(name: "Music genre Rap / Hip-hop", songList: rapSongs)

// add a new item to the category, check, test
rapMusic.add(song: Track(name: "Monster", artist: "Eminem", duration: 4.10, country: "USA", genre: "Rap"))
rapMusic.add(song: Track(name: "Monster", artist: "Eminem", duration: 4.10, country: "USA", genre: "Rap"))

// remove a track from the playlist (by song name)
rapMusic.delete(title: "Monster")
rapMusic.delete(title: "Godzilla")

print("Number of songs in the playlist \"\(rapMusic.name)\": \(rapMusic.numberOfTracks)")

// second playlist
public class SecondPlaylist: FirstPlaylist {}

// get only songs of the "Rock" genre from the shared library
let rockSongs = medialibrary.filter {$0.genre == "Rock"}

// a new instance of the "Second playlist" class - Rock music
var rockMusic: SecondPlaylist = SecondPlaylist(name: "Rock music", songList: rockSongs)

// add new songs in the "Rock" genre to check
rockMusic.add(song: Track(name: "Unforgiven", artist: "Metallica", duration: 4.00, country: "USA", genre: "Rock"))
rockMusic.add(song: Track(name: "Unforgiven II", artist: "Metallica", duration: 4.30, country: "USA", genre: "Rock"))
rockMusic.add(song: Track(name: "Unforgiven III", artist: "Metallica", duration: 5.10, country: "USA", genre: "Rock"))

print("Number of songs in the playlist \"\(rockMusic.name)\": \(rockMusic.numberOfTracks)")

// create an object of the "Media Library" class
let homeMediaLibrary = MediaLibrary()
homeMediaLibrary.addPlaylist(name: rapMusic.name)
homeMediaLibrary.addPlaylist(name: rockMusic.name)

// display a list of our playlists
print("My home playlists: \(homeMediaLibrary.listOfPlaylists)")

// let's expand our abstractions a little - create a new class "Artist" - it will be a superclass
class Artist {
    var name: String = ""
    var country: String = ""
    var genre: String = ""
    
    // general method "write track"
    public func writeTrack(artist: Artist, track: Track) {
        print("Я \(artist.name) wrote a track \(track.name)")
    }
    
    // general method "play track"
    public func performTrack(artist: Artist, track: Track) {
        print("Я \(artist.name) performed the track \(track.name)")
    }
    
    init(artistName: String, artistCountry: String, artistGenre: String) {
        self.name = artistName
        self.country = artistCountry
        self.genre = artistGenre
    }
}

// create the "Single Executor" subclass
final class Singer: Artist {
    
    // override the "country" superclass property
    override var country: String {
        willSet {
            print("Singer \(self.name) moved out of the country: \(self.country) to country: \(newValue)")
        }
    }
    
    // override the "genre" superclass property
    override var genre: String {
        willSet {
            print("Singer \(self.name) changes genre to \(newValue)")
        }
    }
    
    // properties "Number of albums" and "Number of single compositions"
    var numberOfAlbums: Int = 0
    var numberOfSingles: Int = 0
    // свойство "Does the performer perform with concerts"
    var performConcerts: Bool
    
    init(artistName: String,
         artistCountry: String,
         artistGenre: String,
         performConcerts: Bool) {
        self.performConcerts = performConcerts
        super.init(artistName: artistName, artistCountry: artistCountry, artistGenre: artistGenre)
    }
}

// create a subclass "Music group"
final class Group: Artist {
    override var name: String {
        willSet {
            print("The group \(self.name) changed the name! Now it is called \(newValue)")
        }
    }
    
    override var country: String {
        willSet {
            print("The group \(self.name) moved from the country: \(self.country) to country: \(newValue)")
        }
    }
    
    override var genre: String {
        willSet {
            print("The group \(self.name) changes genre to \(newValue)")
        }
    }
    // create a property "Number of people in the group"
    var numberOfPeople: Int
    // create a property "Does the group perform in concerts"
    var performConcerts: Bool
    
    init(artistName: String, artistCountry: String, artistGenre: String, numberOfPeople: Int, performConcerts: Bool) {
        self.numberOfPeople = numberOfPeople
        self.performConcerts = performConcerts
        super.init(artistName: artistName, artistCountry: artistCountry, artistGenre: artistGenre)
    }
    
    // method "Search by group name"
    func searchAndPrintGroupSongs() {
        let nameOftheGroup = self.name
        let selectedSongs = rockMusic.songList.filter {$0.artist == nameOftheGroup}
        print("Find \(selectedSongs.count) songs of group \(self.name) in the playlist")
    }
}

var metallica: Group = Group(artistName: "Metallica", artistCountry: "USA", artistGenre: "Rock", numberOfPeople: 4, performConcerts: true)

var offspring: Group = Group(artistName: "The Offspring", artistCountry: "USA", artistGenre: "Rock", numberOfPeople: 4, performConcerts: true)
var sting: Singer = Singer(artistName: "Sting", artistCountry: "USA", artistGenre: "Pop", performConcerts: false)

// check the method "Search for songs of the selected group in the playlist"
metallica.searchAndPrintGroupSongs()

// check how many artists are in the library
var arstistsArray = [Artist]()
arstistsArray.append(metallica)
arstistsArray.append(offspring)
arstistsArray.append(sting)
print("Find \(arstistsArray.count) artists in the media library. Here they are:")
for item in arstistsArray {
    print(item.name)
}
