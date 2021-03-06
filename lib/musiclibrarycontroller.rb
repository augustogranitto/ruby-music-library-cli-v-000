class MusicLibraryController

attr_accessor :music_importer

def initialize (path="./db/mp3s")
  MusicImporter.new(path).import
end

def call
  command = " "
  puts "Welcome to your music library!"
  puts "To list all of your songs, enter 'list songs'."
  puts "To list all of the artists in your library, enter 'list artists'."
  puts "To list all of the genres in your library, enter 'list genres'."
  puts "To list all of the songs by a particular artist, enter 'list artist'."
  puts "To list all of the songs of a particular genre, enter 'list genre'."
  puts "To play a song, enter 'play song'."
  puts "To quit, type 'exit'."
  puts "What would you like to do?"

  until command == "exit"
    command = gets.chomp.downcase

  case command
  when "list songs"
    list_songs

  when "list artists"
    list_artists

  when "list genres"
    list_genres

  when "list artist"
    list_songs_by_artist

  when "list genre"
    list_songs_by_genre

  when "play song"
    play_song

 end
end
end

    def list_songs
      sorted_songs = Song.all.sort_by {|song| song.name}
      sorted_songs.each_with_index do |song, index|
         puts "#{index+1}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
       end
    end

  def list_artists
    sorted_artists = Artist.all.sort_by {|artist| artist.name}
    sorted_artists.each_with_index do |artist,index|
      puts "#{index+1}. #{artist.name}"
    end
  end

  def list_genres
    # binding.pry
    sorted_genres = Genre.all.sort_by {|genre| genre.name}
    sorted_genres.each_with_index do |genre,index|
      puts "#{index+1}. #{genre.name}"
    end
  end

def play_song
  puts  "Which song number would you like to play?"
  input = gets.chomp.to_i
  #binding.pry
  #sorted_songs = Song.all.sort_by {|song| song.artist.name}
  #sorted_songs.each_with_index do |song, index|
  #puts "Playing #{Song.all[input -1].name} by #{Song.all[input -1].artist.name}"
  if (1..Song.all.length).include?(input)
    song = Song.all.sort{ |a, b| a.name <=> b.name }[input - 1]
  end

 if song
   puts "Playing #{song.name} by #{song.artist.name}"
 end

end

def list_songs_by_artist
  puts "Please enter the name of an artist:"
  artist_name = gets.chomp
  artist = Artist.find_by_name(artist_name)
  if artist != nil
      sorted_songs = artist.songs.sort_by {|song| song.name}
      sorted_songs.each_with_index do |song,index|
      puts "#{index+1}. #{song.name} - #{song.genre.name}"
    end
  end
end


def list_songs_by_genre
  puts "Please enter the name of a genre:"
  genre_name = gets.chomp
  genre = Genre.find_by_name(genre_name)
  if genre != nil
      sorted_songs = genre.songs.sort_by {|song| song.name}
      sorted_songs.each_with_index do |song,index|
      puts "#{index+1}. #{song.artist.name} - #{song.name}"
    end
  end
end


end
