class MatchesController < ApplicationController
    def index
      id = params.require(:id)
      @matches = Player.find(id).matches.order(:date)
    end
  end
