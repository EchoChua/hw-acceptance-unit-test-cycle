require 'rails_helper'

describe MoviesController, :type => :controller do 
  describe '#director' do
    it 'When I follow "Find Movies With Same Director", I should be on the Similar Movies page for the Movies' do
      double = double('Movie')
      double.stub(:director).and_return('double director')
      similarMocks = [double('Movie'), double('Movie')]
      Movie.should_receive(:find).with('58').and_return(double)
      Movie.should_receive(:similar_director).with(double.director).and_return(similarMocks)
      get :similar_director, {:id => '58'}
    end
    it 'should redirect to index if movie does not have a director' do
      double = double('Movie')
      double.stub(:director).and_return(nil)
      double.stub(:title).and_return(nil)
      Movie.should_receive(:find).with('58').and_return(double)
      get :similar_director, {:id => '58'}
      response.should redirect_to(movies_path)
    end
  end
  
  describe 'index action' do
    it 'should display title sort properly' do
      Movie.order(:title => :asc).to_sql.should =~ /ORDER BY "movies"."title" ASC/
      get :index, :sort => 'title'
    end
    it 'should display release_date properly' do
      Movie.order(:release_date => :asc).to_sql.should =~ /ORDER BY "movies"."release_date" ASC/
      get :index, :sort => 'release_date'
    end
  end
  
  describe 'edit action' do
    before :each do
      @movie = double('Movie', :id => '58', :title => 'CaiCaiMeetCatCat')
      Movie.stub(:find).with('58').and_return(@movie)
    end
    it 'should allow movie date to be changed' do
      get :edit, :id => '58'
      response.should render_template('edit')
    end
  end

  describe "show action" do
    it 'should show form for new movie' do
      @movie = double('Movie', :id => '58', :title => 'CaiCaiMeetCatCat')
      Movie.stub(:find).with('58').and_return(@movies)
      get :show, :id => '58'
      response.should render_template('show')
    end
  end
  
  describe 'update action' do
    before :each do
      @movie = double('Movie', :id => '58', :title => 'CaiCaiMeetCatCat')
      Movie.stub(:find).and_return(@movie)
    end
    
    it 'should update and show movie' do
      @movie.should receive(:update_attributes!)
      put :update, :movie => { :title => 'WhateverYouLike'}, :id => '58'
      response.should redirect_to(movie_path(@movie))
    end
  end
  
  describe 'destroy action' do
    it 'should destroy a movie' do 
      @movie = double('Movie', :id => '58', :title => 'CaiCaiMeetCatCat')
      Movie.stub(:find).and_return(@movie)
      @movie.should receive(:destroy)
      delete :destroy, :id => '58'
      response.should redirect_to(movies_path)
    end
  end
  
  describe 'create action' do
    it 'should redirect to movies_path once completed' do
      @movie = double(:id => '58', :title => 'CaiCaiMeetCatCat', :director => 'XingyiCai', )
      post :create, :movie => {:id => '58'}
      response.should redirect_to(movies_path)
    end
  end
    
end
