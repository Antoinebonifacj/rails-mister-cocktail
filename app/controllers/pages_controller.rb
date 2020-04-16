class PagesController < ApplicationController
    def home
        @cocktails_mint = Ingredient.find_by(name: 'mint').cocktails
        @cocktails_lime = Ingredient.find_by(name: "lime").cocktails
    end
end
