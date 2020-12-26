class Admin::PlayersController < ApplicationController
  before_action :authorize!
end
