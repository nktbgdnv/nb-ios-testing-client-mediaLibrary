
// структура Трек
struct Track {
    var name: String
    var artist: String
    var duration: Double
    var country: String
    var genre: String
}

// класс "Медиатека" (музыкальная библиотека)
public class MediaLibrary {
    // массив с названиями плейлистов
    var listOfPlaylists: [String] = []
    
    // метод по агрегации всех плейлистов
    func addPlaylist(name: String) {
        listOfPlaylists.append(name)
    }
}

// класс - абстракция "Плейлист (категория треков)"
public class FirstPlaylist {
    // хранимое свойство - название категории
    var name: String
    // хранимое свойство - список песен
    var songList: [Track]
    // вычислимое свойство - количество треков
    var numberOfTracks: Int {
        return songList.count
    }
    
    func add(song: Track) {
        // проверка на добавление повторного трека
        if checkForRepeatingTrack(testedSong: song) {
            print("!!!   Вы пытаетесь добавить трек, который уже есть в плейлисте   !!!\n")
        } else {
        self.songList.append(song)
        }
    }
    
    // метод, удаляющий трек
    func delete(title: String) {
        var index = 0
        for song in self.songList {
            if song.name == title {
                self.songList.remove(at: index)
            }
            index += 1
        }
    }
    
    // метод, проверяющий наличие в плейлисте добавляемого вновь трека
    func checkForRepeatingTrack(testedSong: Track) -> Bool {
        for item in self.songList {
            if (item.artist == testedSong.artist) && (item.country == testedSong.country) && (item.duration == testedSong.duration) && (item.genre == testedSong.genre) && (item.name == testedSong.name) {
                return true
            }
        }
        return false
    }
    
    // инициализатор класса
    init(name: String, songList: [Track]) {
        self.name = name
        self.songList = songList
    }
}

// создаем коллекцию треков
var medialibrary:[Track] = [Track(name: "Austronaut in the ocean", artist: "Masked Wolf", duration: 2.13, country: "USA", genre: "Rap"),
                            Track(name: "Godzilla", artist: "Eminem", duration: 3.31, country: "USA", genre: "Rap"),
                            Track(name: "Back in Black", artist: "AC/DC", duration: 4.16, country: "USA", genre: "Rock"),
                            Track(name: "Rockstar", artist: "Nickelback", duration: 4.12, country: "USA", genre: "Rock"),
                            Track(name: "Photograph", artist: "Nickelback", duration: 4.19, country: "USA", genre: "Rock"),
                            Track(name: "Кто убил Марка?", artist: "Oxxxymiron", duration: 9.28, country: "Russia", genre: "Rap")]

// получаем из общей библиотеки только песни жанра "Рэп"
let rapSongs = medialibrary.filter {$0.genre == "Rap"}

// создаем экземпляр класса "Первый плейлист" - музыка в стиле Рэп
var rapMusic: FirstPlaylist = FirstPlaylist(name: "Музыка жанра Rap/Hip-hop", songList: rapSongs)

// добавляем новый элемент в категорию
rapMusic.add(song: Track(name: "Monster", artist: "Eminem", duration: 4.10, country: "USA", genre: "Rap"))
rapMusic.add(song: Track(name: "Monster", artist: "Eminem", duration: 4.10, country: "USA", genre: "Rap"))

// удаляем трек из плейлиста (по названию песни)
rapMusic.delete(title: "Monster")
rapMusic.delete(title: "Godzilla")

print("Количество песен в плейлисте \"\(rapMusic.name)\": \(rapMusic.numberOfTracks)")

// класс "Второй плейлист"
public class SecondPlaylist: FirstPlaylist {}

// получаем из общей библиотеки только песни жанра "Рок"
let rockSongs = medialibrary.filter {$0.genre == "Rock"}

// новый экземпляр класса "Второй плейлист" - музыка в стиле Рок
var rockMusic: SecondPlaylist = SecondPlaylist(name: "Музыка жанра Рок", songList: rockSongs)
print("Количество песен в плейлисте \"\(rockMusic.name)\": \(rockMusic.numberOfTracks)")

// объект класса "Медиатека"
let homeMediaLibrary = MediaLibrary()
homeMediaLibrary.addPlaylist(name: rapMusic.name)
homeMediaLibrary.addPlaylist(name: rockMusic.name)

// выводим на экран список наших плейлистов
print("Мои домашние плейлисты: \(homeMediaLibrary.listOfPlaylists)")

