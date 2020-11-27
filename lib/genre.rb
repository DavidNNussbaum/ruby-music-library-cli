# class Genre
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

#     def songs
#         @songs
#     end

#     def artists
#         songs.collect{ |s| s.artist }.uniq 
#     end

# end

class Genre
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
      genre = new(name)
      genre.save
      genre
  
      # Or, as a one-liner:
      # new(name).tap{ |g| g.save }
    end
  
    def artists
      songs.collect{ |s| s.artist }.uniq
    end
  end
  