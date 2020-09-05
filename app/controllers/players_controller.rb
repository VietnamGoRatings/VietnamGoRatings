# frozen_string_literal: true

class PlayersController < ApplicationController
  def index
    @men = Player.where(is_male: 1).order(rating: :desc).all.filter(&:active?)
    @women = Player.where(is_male: 0).order(rating: :desc).all.filter(&:active?)
  end
end
