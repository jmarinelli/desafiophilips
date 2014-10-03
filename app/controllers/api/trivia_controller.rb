class Api::TriviaController < ApplicationController
  def index
    render json: Question.all
  end

  def show
    render json: Question.find(params[:id])
  end

  def questions_for_user
    user = User.find(params[:id])
    render json: Question.select("*").where.not(id: user.answered_questions_ids)
  end

  def next_question_for_user
    user = User.find(params[:id])
    render json: Question.select("*").where.not(id: user.answered_questions_ids).first
  end

  def answer
    user = User.find(params[:id])
    question = Question.find(params[:question_id])
    if ( user.answered_questions_ids.include? params[:question_id] )
      render json: { result: 'already_answered', user: user }
    else
      if (question.correct_option_id == params[:option_id])
        user.add_trivia_points(question.points)
        user.questions << question
        render json: { result: 'correct', user: user }
      else
        render json: { result: 'incorrect', user: user }
      end
    end
  end
end