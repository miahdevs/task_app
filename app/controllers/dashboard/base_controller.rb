module Dashboard
  class BaseController < ApplicationController
    before_action :authenticate_user!
    layout 'dashboard'  # Use a separate layout for dashboard
  end
end