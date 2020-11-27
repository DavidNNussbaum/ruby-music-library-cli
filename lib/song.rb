# require_relative "./artist.rb"

# class Song
#     attr_accessor :name
#     attr_reader :artist, :genre
#     @@all = []
#     def initialize(name, artist = nil, genre = nil) #accepts a name for the new song, optional artist 
#         @name = name
#         self.artist = artist if artist
#         self.genre = genre if genre
#     end

#     def name #retrieves the name of a song
#         @name
#     end

#     def name=(name) #can set the name of a song
#         @name = name 
#     end

#     def self.all # returns the class variable @@all
#         @@all
#     end

#     def self.destroy_all
#         @@all.clear
#     end

#     def save
#         @@all << self #adds the Song instance to the @@all class variable
#     end

#     def self.create(name) #initializes, saves, and returns the song
#         @@all << self.new(name)
#         self
#     end

#     def artist #returns the artist of the song (song belongs to artist)
#         @artist
#     end
#  # In artist=
#  #line 1 - #assigns an artist to the song (song belongs to artist)
#  #line 2 - invokes Artist#add_song to add itself to the artist's collection of songs (artist has many songs)
    
#     def artist=(artist)  
#         @artist = artist
#         artist.add_song(self)
#     end

#     def genre
#         @genre
#     end

#     # For genre
#     # assigns a genre to the song (song belongs to genre)
#     #   adds the song to the genre's collection of songs (genre has many songs)
#     #   does not add the song to the genre's collection of songs if it already exists therein
#     def genre=(genre)
#         @genre = genre
#         genre.songs << self unless genre.songs.include?(self) 
#     end
#     def self.find_by_name(name)
#         @@all.detect {|s| s.name == name}
#     end
# end

class Song
    attr_accessor :name
    attr_reader :artist, :genre
  
    @@all = []
  
    def initialize(name, artist = nil, genre = nil)
      @name = name
      self.artist = artist if artist
      self.genre = genre if genre
    end
  
    def artist=(artist)
      @artist = artist
      artist.add_song(self)
    end
  
    def genre=(genre)
      @genre = genre
      genre.songs << self unless genre.songs.include?(self)
    end
  
    def self.all
      @@all
    end
  
    def self.destroy_all
      all.clear
    end
  
    def save
      self.class.all << self
    end
  
    def self.create(name)
      song = new(name)
      song.save
      song
  
      # Or, as a one-liner:
      # new(name).tap{ |s| s.save }
    end
  
    def self.find_by_name(name)
      all.detect{ |s| s.name == name }
    end
  
    def self.find_or_create_by_name(name)
      find_by_name(name) || create(name)
    end
  
    def self.new_from_filename(filename)
      parts = filename.split(" - ")
      artist_name, song_name, genre_name = parts[0], parts[1], parts[2].gsub(".mp3", "")
  
      artist = Artist.find_or_create_by_name(artist_name)
      genre = Genre.find_or_create_by_name(genre_name)
  
      new(song_name, artist, genre)
    end
  
    def self.create_from_filename(filename)
      new_from_filename(filename).tap{ |s| s.save }
    end
  end

 