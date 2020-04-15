# frozen_string_literal: true

class CocktailsController < ApplicationController
  def index
  @cocktails = Cocktail.all
  @categories = Category.all
  @glasses = Glass.all
  if params[:query].present?
     sql_query = " \
       @cocktails.name ILIKE :query \
       OR @cocktails.description ILIKE :query \
       OR @categories.name ILIKE :query \
       OR @glasses.name ILIKE :query \
     "
     @cocktails = Cocktail.joins(:category, :glass).where(sql_query, query: "%#{params[:query]}%")
   else
     @cocktails = Cocktail.all
  end
  end

  def show
    @cocktail = Cocktail.joins(:category, :glass, :alcoholic).find(params[:id])
    # @category = Category.where(id: @cocktail.category_id)
    # @glass = Glass.where(id: @cocktail.glass_id)
    # @alcoholic = Alcoholic.where(id: @cocktail.alcoholic_id)
    # redirect_to cocktail_path(@cocktail)
  end

  def new
    @cocktail = Cocktail.new
  end

  def create
    @cocktail = Cocktail.new(cocktail_params)
    if @cocktail.save
      redirect_to cocktail_path(@cocktail)
    else
      render :new
    end
  end

  def destroy
    cocktail = Cocktail.find(params[:id])
    cocktail.destroy
  end

  private

  def cocktail_params
    params.require(:cocktail).permit(
      :name,
      :description,
      :category_id,
      :glass_id,
      :alcoholic_id,
      :style,
      :photo
    )
  end
end
