class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    @sort_by = session[:sort_by] || params[:sort_by]
    @all_ratings = Movie.all_ratings
    ratings_hash = Hash[*@all_ratings.collect {|rating| [rating, 1]}.flatten]
    @ratings_to_show = session[:ratings] || params[:ratings] || ratings_hash
    
    #retrieve session
    if params[:sort_by] != session[:sort_by]
      session[:sort_by] = @sort_by
    end
    if params[:ratings] != session[:ratings]
      session[:ratings] = @ratings_to_show
    end
    
    #render
    @movies = Movie.where(rating: @ratings_to_show.keys).order(@sort_by)
    @bg_release_date = @sort_by=='release_date' ? /\bhilite\b/ : ""
    @bg_title = @sort_by=='title' ? /\bhilite\b/ : ""    
    
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

  private
  # Making "internal" methods private is not required, but is a common practice.
  # This helps make clear which methods respond to requests, and which ones do not.
  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date)
  end
end
