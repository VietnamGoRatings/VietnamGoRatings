# frozen_string_literal: true

class Admin::Clubs::UpdatePlayersController < ApplicationController
  before_action :authorize!

  def new
    @update = UpdateFromFile.new
  end

  def create
    club_id = allowed_params[:club_id]
    allowed_params.delete(:club_id)
    update = UpdateClubPlayers.new(allowed_params)
    update.data = JSON.generate({ club_id: club_id })
    update.save!
    redirect_to admin_update_players_path
  end

  def index
    @update_from_files = UpdateClubPlayers.all
  end

  private

  def allowed_params
   @allowed_params ||= params.require(:update_from_file).permit(:file, :club_id)
  end

  def authorize!
    authorize UpdateClubPlayers
  end
end
