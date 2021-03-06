class FilmsController < ApplicationController
before_action :authenticate_user!, except:[:index, :show]


  def new
    @film = Film.new
  end

  def create
    @film = Film.new(film_params)
    if @film.valid?
      @film.save
      redirect_to @film
    else
      render :new
    end
  end

  def show
    @film = Film.find(params[:id])
  end

  def index
    @films = Film.search(params[:search])
    # @films = Film.all
  end

  def update
    @film = Film.find(params[:id])
    if @film.update(film_params)
      redirect_to @film
    else
      render 'edit'
    end
  end

  def edit
    @film = Film.find(params[:id])
  end

  def destroy
    @film = Film.find(params[:id])
    @film.destroy

    redirect_to films_path, notice: "That film has been deleted"
  end

  private

  def film_params
    params.require(:film).permit(:title, :director, :studio)
  end
 
end