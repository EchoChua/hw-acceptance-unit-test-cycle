require 'rails_helper'
require 'spec_helper'

describe Movie do
  it "@all_ratings should match this" do
    Movie.all_ratings.should == ['G', 'PG', 'PG-13', 'NC-17', 'R']
  end
end

describe "retrieving a list of all movies by the same director" do
  it "should retrieve the lsit of the director's movies" do
    @movies = ["Movie 1", "Movie 2", "Movie 3"]
    Movie.stub(:where).with(:director => "Director").and_return @movies
    Movie.similar_director("Director").should == @movies
  end
  it "should return nil" do
    @movies = []
    Movie.stub(:where).with(:director => "").and_return @movies
    @movies = Movie.where(:director => "")
    @movies.should be_empty
  end
end

describe "filter_sort" do
  it "should filter and sort" do
    @movies = ["Movie 1", "Movie 2", "Movie 3"]
    Movie.stub_chain(:where, :order).and_return @movies
    Movie.filter_and_sort(["G", "PG"],title: :asc).should == @movies
  end
end