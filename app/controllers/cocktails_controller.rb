# frozen_string_literal: true

class CocktailsController < ApplicationController
  def index
    if params["search"]
      @filter = params["search"]["flavors"].concat(params["search"]["strengths"]).flatten.reject(&:blank?)
      @cocktails = Cocktail.all.global_search("#{@filter}")
    else
      @cocktails = Cocktail.all
    end
    respond_to do |format|
      format.html
      format.js
    end
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
