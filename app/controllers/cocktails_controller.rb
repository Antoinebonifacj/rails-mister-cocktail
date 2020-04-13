# frozen_string_literal: true

class CocktailsController < ApplicationController
  def index
   if params[:query].present?
      sql_query = " \
        cocktails.name ILIKE :query \
        OR cocktails.description ILIKE :query \
        OR categories.name ILIKE :query \
        OR glasses.name ILIKE :query \
      "
      @cocktails = Cocktail.joins(:category, :glass).where(sql_query, query: "%#{params[:query]}%")
    else
      @cocktails = Cocktail.all
    end
  end

  def show
    @cocktail = Cocktail.find(params[:id])
    @category = Category.where(id: @cocktail.category_id)
    @glass = Glass.where(id: @cocktail.glass_id)
    @alcoholic = Alcoholic.where(id: @cocktail.alcoholic_id)
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
    @cocktail.category_id = @category
    @cocktail.glass_id = @glass
    @cocktail.alcoholic_id = @alcoholic
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
      :alcoholic_id,
      :style,
      :photo
    )
  end
end
