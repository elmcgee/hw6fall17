class Movie < ActiveRecord::Base
  def self.all_ratings
    %w(G PG PG-13 NC-17 R)
  end
  
class Movie::InvalidKeyError < StandardError ; end
  
  def self.find_in_tmdb(string)
    begin 
      require 'themoviedb'
      Tmdb::Api.key("f4702b08c0ac6ea5b51425788bb262562")
      smovie = Array.new
     # smovie = string.split(" ")
      puts('hello')
      smovie.each do |ii|
        if(ii == '/^[the]+/')
         Tmdb::Movie.find(ii)
         puts(ii)
        end
      end
      Tmdb::Movie.find(string)
    rescue Tmdb::InvalidApiKeyError
      raise Movie::InvalidKeyError, 'Invalid API key'
    end
  end

end
