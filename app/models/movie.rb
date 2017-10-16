class Movie < ActiveRecord::Base
  def self.all_ratings
    %w(G PG PG-13 NC-17 R)
  end
  
class Movie::InvalidKeyError < StandardError ; end
  
  def self.find_in_tmdb(string)
    require 'themoviedb'
    Tmdb::Api.key("f4702b08c0ac6ea5b51425788bb26562")
    begin 
      
      master_movies = Array.new
      matching_movies = Tmdb::Movie.find(string)
      puts (matching_movies)
      matching_movies.each do |ii|
        puts("MADE IT")
         smovie = Hash.new
         smovie[:tmdb_id] = ii.id
         smovie[:title] = ii.title
         smovie[:overview] = ii.overview
        Tmdb::Movie.releases(ii.id)["countries"].each do|jj|
            if(jj["iso_3166_1"] == "US" )
              if(Movie.all_ratings.include?(jj["certification"]))
                smovie[:rating] = jj["certification"]
                smovie[:release_date]= jj["release_date"]
                master_movies << smovie
              end
              break
            end
        end
      end
      master_movies
    rescue Tmdb::InvalidApiKeyError
      raise Movie::InvalidKeyError, 'Invalid API key'
    end
  end

end
