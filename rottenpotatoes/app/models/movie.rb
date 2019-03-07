class Movie < ActiveRecord::Base
  def self.all_ratings
    %w(G PG PG-13 NC-17 R)
  end
  
  def self.similar_director(director)
    Movie.where(director: director)
  end
  
  def self.filter_and_sort(title_sort,sort_order)
    Movie.where(rating: title_sort).order(sort_order)
  end
  
end
