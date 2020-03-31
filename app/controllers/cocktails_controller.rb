class CocktailsController < ApplicationController

  def index
    @cocktails = Cocktail.all
  end

  def show
    @cocktail = Cocktail.find(params[:id])
    # redirect_to cocktail_path(@cocktail)
  end

  def new
    @cocktail = Cocktail.new
  end

  def create
    @category = Category.find(params[:cocktail][:category_id])
    @glass = Glass.find(params[:cocktail][:glass_id])
    @alcoholic = Alcoholic.find(params[:cocktail][:alcoholic_id])
    @cocktail = Cocktail.new(cocktail_params)
    @cocktail.category = @category
    @cocktail.glass = @glass
    @cocktail.alcoholic = @alcoholic
    if @cocktail.save
      redirect_to cocktail_path(@cocktail)
    else
      render :new
    end
  end

  def destroy
    @cocktail = Cocktail.find(params[:id])
    @cocktail.destroy
  end

  private

  def cocktail_params
    params.require(:cocktail).permit(
      :name,
      :description,
      :category_id,
      :glass_id,
      :alcoholic,
      :prep_time,
      :photo
      )
  end
end
