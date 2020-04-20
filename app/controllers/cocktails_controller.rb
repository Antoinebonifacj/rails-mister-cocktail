# frozen_string_literal: true

class CocktailsController < ApplicationController
  def index
    if params[:query].present?
      sql_query = " \
        cocktails.name @@ :query \
        OR cocktails.description @@ :query \
        OR glasses.name @@ :query \
        OR categories.name @@ :query \
        OR alcoholics.name @@ :query \
      "
      @cocktails = Cocktail.joins(:category, :glass, :alcoholic).where(sql_query, query: "%#{params[:query]}%")
    else
     @cocktails = Cocktail.includes(:glass, :category, :alcoholic)
    end
  end

  def show
    @cocktail = Cocktail.find(params[:id])
    @review = Review.new

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
