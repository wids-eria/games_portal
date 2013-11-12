class SurveyController < ApplicationController
  def show
    @survey = Game.find_by_path(params[:id]).survey
  end
end
