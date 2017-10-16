class Movie < ActiveRecord::Base
  def self.all_ratings
    %w(G PG PG-13 NC-17 R)
  end
  
class Movie::InvalidKeyError < StandardError ; end
  
  def self.find_in_tmdb(string)
    require 'themoviedb'
    Tmdb::Api.key("f4702b08c0ac6ea5b51425788bb26562")
    begin 
      smovie = Hash.new
      matching_movies = Tmdb::Movie.find(string)
      puts (matching_movies)
      matching_movies.each do |ii|
        puts("MADE IT")
         smovie[:title] = ii.title
         smovie[:release_date] = ii.release_date
         smovie[:overview] = ii.overview
      end
      Tmdb::Movie.find(smovie)
    rescue Tmdb::InvalidApiKeyError
      raise Movie::InvalidKeyError, 'Invalid API key'
    end
  end

end
