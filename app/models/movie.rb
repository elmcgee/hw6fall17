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
      puts('hello')
      matching_movies.each do |ii|
        if(ii == '/^[the]+/')
          
         smovie[:title] = matching_movies.title
         smovie[:rating] = matching_movies.rating
         smovie[:release_date] = matching_movies.release_date
         smovie[:overview] = matching_movies.overview
         matching_movies = smovie
        end
      end
      Tmdb::Movie.find(matching_movies)
    rescue Tmdb::InvalidApiKeyError
      raise Movie::InvalidKeyError, 'Invalid API key'
    end
  end

end
