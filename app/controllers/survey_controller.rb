class SurveyController < ApplicationController
  before_filter :present_login
  before_filter :must_consent

  def show
    @survey = Game.find_by_path(params[:id]).survey
  end
end