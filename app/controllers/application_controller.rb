# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pundit

  rescue_from Pundit::NotAuthorizedError do
    render file: 'public/403.html', status: 403
  end
end
