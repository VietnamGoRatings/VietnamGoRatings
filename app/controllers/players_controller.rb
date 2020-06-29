class PlayersController < ApplicationController
  def index
    @men = Player.where(is_male: 1).order(rating: :desc).all.filter{ |player| player.is_active }
    @women = Player.where(is_male: 0).order(rating: :desc).all.filter{ |player| player.is_active }
  end
end
