class Api::V1::QuestionsController < ApplicationController
  def index
    @questions = Question.where(private: false)
    render :index, status: :ok
  end
end