class Api::V1::QuestionsController < ApplicationController
  def index
    @questions = Question.all
    render :index, status: :ok
  end
end