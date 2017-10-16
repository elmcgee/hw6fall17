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
      matching_movies.each do |ii|
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
  
    def self.create_from_tmdb(id)
      require 'themoviedb'
      Tmdb::Api.key("f4702b08c0ac6ea5b51425788bb26562")
      begin 
      checked_movies = Tmdb::Movie.detail(id)
      smovie = Hash.new
      smovie[:title] = checked_movies["title"]
      smovie[:description] = checked_movies["overview"]
       Tmdb::Movie.releases(checked_movies["id"])["countries"].each do |rmovie|
            if(rmovie["iso_3166_1"] == "US" )
              if(Movie.all_ratings.include?(rmovie["certification"]))
                smovie[:rating] = rmovie["certification"]
                smovie[:release_date]= rmovie["release_date"]
                Movie.create!(smovie)
              end
              break
            end
        end
   
      rescue Tmdb::InvalidApiKeyError
        raise Movie::InvalidKeyError, 'Invalid API key'
      end
    end
  
end
