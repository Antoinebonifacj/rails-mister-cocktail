# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include PgSearch::Model
end
