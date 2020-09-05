# frozen_string_literal: true

class ClubsController < ApplicationController
  def index
    @clubs = Club.all
  end

  def show
    id = params.require(:id)
    @players = Player.where(club_id: id).all
    @club = Club.find(id)
  end
end
