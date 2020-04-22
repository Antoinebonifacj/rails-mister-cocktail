# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :set_search

  private

  def set_search
    if params[:query].present?
      sql_query = " \
        cocktails.name @@ :query \
        OR cocktails.description @@ :query \
        OR glasses.name @@ :query \
        OR categories.name @@ :query \
        OR alcoholics.name @@ :query \
      "
      @cocktails = Cocktail.joins(:category, :glass, :alcoholic).where(sql_query, query: "%#{params[:query]}%")
    end
  end
end
