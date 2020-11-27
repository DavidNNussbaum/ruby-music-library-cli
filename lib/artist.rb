# class Artist
#     @@all = []
#     def initialize(name) #accepts a name for the new song
#         @name = name
#         @songs = []
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

#     def songs #returns the artist's 'songs' collection (artist has many songs)
#         @songs 
#     end
#     # add_song:
#     #   assigns the current artist to the song's 'artist' property (song belongs to artist)
#     #   does not assign the artist if the song already has an artist
#     #   adds the song to the current artist's 'songs' collection
#     #   does not add the song to the current artist's collection of songs if it already exists therein
#     def add_song(song)
#         song.artist = self unless song.artist
#         @songs << song unless songs.include?(song) 
#     end

#     # genres:
#     # returns a collection of genres for all of the artist's songs (artist has many genres through songs)
#     # does not return duplicate genres if the artist has more than one song of a particular genre (artist has many genres through songs)
#     # collects genres through its songs instead of maintaining its own @genres instance variable (artist has many genres through songs)

#     def genres
#        songs.collect{ |s| s.genre }.uniq 
#     end

# end

class Artist
    extend Concerns::Findable
  
    attr_accessor :name
    attr_reader :songs
  
    @@all = []
  
    def initialize(name)
      @name = name
      @songs = []
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
      artist = new(name)
      artist.save
      artist
  
      # Or, as a one-liner:
      # new(name).tap{ |a| a.save }
    end
  
    def add_song(song)
      song.artist = self unless song.artist
      songs << song unless songs.include?(song)
    end
  
    def genres
      songs.collect{ |s| s.genre }.uniq
    end
  end
  