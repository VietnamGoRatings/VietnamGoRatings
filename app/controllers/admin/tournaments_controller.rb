class Admin::TournamentsController < ApplicationController
  before_action :authorize!

  def new
  end

  def create
    date = allowed_params[:date]
    allowed_params.delete(:date)
    update = UpdateTournament.new(allowed_params)
    update.data = JSON.generate({date: date})
    update.save!

  end

  private
  def allowed_params
    @allowed_params ||= params.require(:tournament).permit(:file, :date)
  end

  def authorize!
    authorize Tournament
  end
end
