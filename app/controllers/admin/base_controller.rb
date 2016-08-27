class Admin::BaseController < ApplicationController

  layout 'admin'
  before_action :authenticate_user!
  helper_method :show_onboarding?

  # Here we are just checking if the onboarding should be shown, based on the
  # current admin username.
  def show_onboarding?
    User.first.email == 'admin@test.com' && current_user.email == 'admin@test.com' && current_user.is_admin?
  end

  protected

  def pipeline
    @pipeline = true
  end

  def remote_search
    @remote_search = true
  end

  def date_from_params
    if params[:start_date].present?
      @start_date = params[:start_date].to_datetime
    else
      @start_date = Time.zone.today.at_beginning_of_week
    end

    if params[:end_date].present?
      @end_date = params[:end_date].to_datetime
    else
      @end_date = Time.zone.today.at_end_of_day
    end
  end

end
