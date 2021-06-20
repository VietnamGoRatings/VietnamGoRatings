class Admin::TournamentsController < ApplicationController
  before_action :authorize!

  def new
  end

  def create
    date = allowed_params[:date]
    official_sheet = allowed_params[:official_sheet]
    allowed_params.delete(:date)
    allowed_params.delete(:official_sheet)
    update = UpdateTournament.new(allowed_params)
    update.data = JSON.generate({date: date, official_sheet: official_sheet})
    update.save!

  end

  def index
    @tournaments = Tournament.all
  end

  def show
    @tournament = Tournament.find_by(params[:id])
  end
  private
  def allowed_params
    @allowed_params ||= params.require(:tournament).permit(:file, :date, :official_sheet)
  end

  def authorize!
    authorize Tournament
  end
end
