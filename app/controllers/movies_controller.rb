class MoviesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_movie, only: [:show, :edit, :update, :destroy]
  before_action :authorize_owner!, only: [:edit, :update, :destroy]

  # GET /movies
  def index
    @movies = Movie.includes(:categories).order(created_at: :desc)

    if params[:query].present?
      q = "%#{params[:query].to_s.strip}%"
      @movies = @movies
        .joins("LEFT JOIN categories_movies ON categories_movies.movie_id = movies.id")
        .joins("LEFT JOIN categories ON categories.id = categories_movies.category_id")
        .where(
          "movies.title ILIKE :q
           OR movies.genre ILIKE :q
           OR movies.director ILIKE :q
           OR categories.name ILIKE :q",
          q: q
        ).distinct
    end

    @movies = @movies.page(params[:page]).per(6)
  end


  # GET /movies/1
  def show
    @comments = @movie.comments.order(created_at: :desc)
  end

  # GET /movies/new
  def new
    @movie = Movie.new
  end

  # GET /movies/1/edit
  def edit; end

  # POST /movies
  def create
    @movie = current_user.movies.build(movie_params)

    respond_to do |format|
      if @movie.save
        format.html { redirect_to @movie, notice: "Filme criado com sucesso." }
        format.json { render :show, status: :created, location: @movie }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @movie.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /movies/1
  def update
    if @movie.update(movie_params)
      redirect_to @movie, notice: "Filme atualizado!"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /movies/1
  def destroy
    @movie.destroy
    redirect_to movies_url, notice: "Filme apagado!"
  end

  private

  def set_movie
    @movie = Movie.find(params[:id])
  end

  def authorize_owner!
    return if @movie.user == current_user
    redirect_to @movie, alert: "Você só pode alterar ou apagar filmes que você criou!"
  end

  def movie_params
    params.require(:movie).permit(
      :title, :genre, :year, :rating, :director, :duration, :synopsis, :poster,
      category_ids: []
    )
  end
end
