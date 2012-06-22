class AnimalsController < ApplicationController

  def index
    @animals = Animal.all
    respond_to do |format|
      format.html
      format.json { render json: @animals }
    end
  end

  def show
    @animal = Animal.find(params[:id])
    render json: @animal
  end

  def new
    @animal = Animal.new
    render json: @animal
  end

  def edit
    @animal = Animal.find(params[:id])
  end

  def create
    @animal = Animal.new(params[:animal])
    if @animal.save
      render json: @animal, status: :created, location: @animal
    else
      render json: @animal.errors, status: :unprocessable_entity
    end
  end

  def update
    @animal = Animal.find(params[:id])
    if @animal.update_attributes(params[:animal])
      head :no_content
    else
      render json: @animal.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @animal = Animal.find(params[:id])
    @animal.destroy
    head :no_content
  end

end
