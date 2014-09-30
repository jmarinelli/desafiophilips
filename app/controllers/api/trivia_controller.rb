class Api::TriviaController < ApplicationController
  def index
    render json: Question.all
  end

  def show
    render json: Question.find(params[:id])
  end

  def answer
    user = User.find(session[:user_id])
    question = Question.find(params[:question_id])
    if (question.correct_option_id == params[:option_id])
      user.add_trivia_points(5)
      render json: { result: 'correct', user: user }
    else
      render json: { result: 'incorrect', user: user }
    end
  end
end