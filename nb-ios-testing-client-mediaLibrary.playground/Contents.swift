/// Данный код не претендует на полноценную музыкальную библиотеку, однако
/// он с достаточной точностью реализует ее основные функции на Swift.
/// А это - хранение в коллекции данных треков, выгрузка "плейлистов" по определенному
/// жанру, добавление и удаление треков из "медиатеки".
/// N. Bogdanov (c)


// структура Track, содержащая свойства-информацию о музыкальном треке
struct Track {
    var name: String
    var artist: String
    var duration: Double
    var country: String
    var genre: String
}

// класс "Медиатека" (музыкальная библиотека)
public class MediaLibrary {
    // плейлисты-массивы
    var listOfPlaylists: [String] = []
    
    // метод по агрегации всех плейлистов
    func addPlaylist(name: String) {
        listOfPlaylists.append(name)
    }
}

// класс-абстракция "Плейлист (категория треков)"
public class FirstPlaylist {
    // название категории
    var name: String
    // список песен
    var songList: [Track]
    // количество треков
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

// добавляем новый элемент в категорию, проверяем, тестируем
rapMusic.add(song: Track(name: "Monster", artist: "Eminem", duration: 4.10, country: "USA", genre: "Rap"))
rapMusic.add(song: Track(name: "Monster", artist: "Eminem", duration: 4.10, country: "USA", genre: "Rap"))

// удаляем трек из плейлиста (по названию песни)
rapMusic.delete(title: "Monster")
rapMusic.delete(title: "Godzilla")

print("Количество песен в плейлисте \"\(rapMusic.name)\": \(rapMusic.numberOfTracks)")

// второй плейлист
public class SecondPlaylist: FirstPlaylist {}

// получаем из общей библиотеки только песни жанра "Рок"
let rockSongs = medialibrary.filter {$0.genre == "Rock"}

// новый экземпляр класса "Второй плейлист" - музыка в стиле Рок
var rockMusic: SecondPlaylist = SecondPlaylist(name: "Музыка жанра Рок", songList: rockSongs)

// для проверки добавим новые песни в жанре "Рок"
rockMusic.add(song: Track(name: "Unforgiven", artist: "Metallica", duration: 4.00, country: "USA", genre: "Rock"))
rockMusic.add(song: Track(name: "Unforgiven II", artist: "Metallica", duration: 4.30, country: "USA", genre: "Rock"))
rockMusic.add(song: Track(name: "Unforgiven III", artist: "Metallica", duration: 5.10, country: "USA", genre: "Rock"))

print("Количество песен в плейлисте \"\(rockMusic.name)\": \(rockMusic.numberOfTracks)")

// создаем объект класса "Медиатека"
let homeMediaLibrary = MediaLibrary()
homeMediaLibrary.addPlaylist(name: rapMusic.name)
homeMediaLibrary.addPlaylist(name: rockMusic.name)

// выводим на экран список наших плейлистов
print("Мои домашние плейлисты: \(homeMediaLibrary.listOfPlaylists)")

/// немного расширим наши абстракции - создаем новый класс "Артист" - он будет суперклассом
class Artist {
    var name: String = ""
    var country: String = ""
    var genre: String = ""
    
    // общий метод "написать трек"
    public func writeTrack(artist: Artist, track: Track) {
        print("Я \(artist.name) написал трек \(track.name)")
    }
    
    // общий метод "исполнить трек"
    public func performTrack(artist: Artist, track: Track) {
        print("Я \(artist.name) исполнил трек \(track.name)")
    }
    
    init(artistName: String, artistCountry: String, artistGenre: String) {
        self.name = artistName
        self.country = artistCountry
        self.genre = artistGenre
    }
}

// создание сабкласса "Одиночный исполнитель"
final class Singer: Artist {
    
    // переопределение свойства суперкласса "страна"
    override var country: String {
        willSet {
            print("Исполнитель \(self.name) переехал из страны: \(self.country) в страну: \(newValue)")
        }
    }
    // переопределение свойства суперкласса "жанр"
    override var genre: String {
        willSet {
            print("Исполнитель \(self.name) переехал из страны: \(self.country) в страну: \(newValue)")
        }
    }
    // свойства "Количество альбомов" и "Количество одиночных композиций"
    var numberOfAlbums: Int = 0
    var numberOfSingles: Int = 0
    // свойство "Выступает ли исполнитель с концертами"
    var performConcerts: Bool
    
    // переопределение инициализатора
    init(artistName: String,
         artistCountry: String,
         artistGenre: String,
         performConcerts: Bool) {
        self.performConcerts = performConcerts
        super.init(artistName: artistName, artistCountry: artistCountry, artistGenre: artistGenre)
    }
}

// создание сабкласса "Музыкальная группа"
final class Group: Artist {
    // переопределение свойства "Имя"
    override var name: String {
        willSet {
            print("Группа \(self.name) сменила название! Теперь она называется \(newValue)")
        }
    }
    
    // переопределение свойства суперкласса "страна"
    override var country: String {
        willSet {
            print("Группа \(self.name) переехала из страны: \(self.country) в страну: \(newValue)")
        }
    }
    
    // переопределение свойства суперкласса "жанр"
    override var genre: String {
        willSet {
            print("У группы \(self.name) новый жанр \(newValue)")
        }
    }
    // создание уникального свойства "Количество человек в группе"
    var numberOfPeople: Int
    // создание уникального свойства "Выступает ли группа с концертами"
    var performConcerts: Bool
    
    // уникальный для прочих классов метод "Поиск по названию группы"
    func searchAndPrintGroupSongs() {
        let nameOftheGroup = self.name
        let selectedSongs = rockMusic.songList.filter {$0.artist == nameOftheGroup}
        print("Найдено \(selectedSongs.count) песен группы \(self.name) в плейлисте")
    }
    
    // переопределение инициализатора
    init(artistName: String,
                  artistCountry: String,
                  artistGenre: String,
                  numberOfPeople: Int,
                  performConcerts: Bool) {
        self.numberOfPeople = numberOfPeople
        self.performConcerts = performConcerts
        super.init(artistName: artistName, artistCountry: artistCountry, artistGenre: artistGenre)
    }
}

// создание экземпляра класса Group, проверка его значений
var metallica: Group = Group(artistName: "Metallica", artistCountry: "USA", artistGenre: "Rock", numberOfPeople: 4, performConcerts: true)

// другие группы и отдельные исполнители
var offspring: Group = Group(artistName: "The Offspring", artistCountry: "USA", artistGenre: "Rock", numberOfPeople: 4, performConcerts: true)
var sting: Singer = Singer(artistName: "Sting", artistCountry: "USA", artistGenre: "Pop", performConcerts: false)

// проверка метода "Поиск песен выбранной группы в плейлисте"
metallica.searchAndPrintGroupSongs()

// проверим, сколько артистов присутствует в медиатеке
var arstistsArray = [Artist]()
arstistsArray.append(metallica)
arstistsArray.append(offspring)
arstistsArray.append(sting)
print("В медиатеке найдено \(arstistsArray.count) артистов. Вот они:")
for item in arstistsArray {
    print(item.name)
}
