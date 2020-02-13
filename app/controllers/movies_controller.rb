class MoviesController < ApplicationController
  #before_action :set_movie, only: [:show, :update, :destroy]

  # GET /movies
  def index
    @movies = Movie.all
    if params[:query]
      if @movies.where(:id => params[:query]).empty?
        @movies = @movies.where("title ILIKE ?", "%#{params[:query]}%")
      else
        @movies = @movies.where(:id => params[:query])
      end
    end
    render json: @movies
  end

  # GET /movies/1
  def show
    @movie = Movie.find(params[:id])
    render json: @movie
  end

  def date_range
    @start_date = params[:start].to_date
    @finish_date = params[:finish].to_date
    @movies = Movie.where(:release_date => @start_date.beginning_of_day..@finish_date.end_of_day)
    render json: @movies
  end

  # POST /movies
  def create
    @movie = Movie.new(movie_params)

    if @movie.save
      render json: @movie, status: :created, location: @movie
    else
      render json: @movie.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /movies/1
  def update
    if @movie.update(movie_params)
      render json: @movie
    else
      render json: @movie.errors, status: :unprocessable_entity
    end
  end

  # DELETE /movies/1
  def destroy
    @movie.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_movie
      @movie = Movie.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def movie_params
      params.require(:movie).permit(:title, :movie_overview, :vote_count, :porter_path, :release_date)
    end
end
