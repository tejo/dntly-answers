# frozen_string_literal: true

class AnswersController < ApplicationController
  before_action :authenticate_user!, only: %i[new edit update destroy like]
  before_action :set_answer, only: %i[show edit update destroy]

  def index
    @answers = Answer.all
  end

  def show
  end

  def new
    @answer = Answer.new
  end

  def edit
  end

  def like
    @answer = Answer.find(params[:id])
    current_user.like(@answer)
    redirect_to question_url(@answer.question)
  end

  def create
    @answer = Answer.new(answer_params)
    @answer.user = current_user
    @question = @answer.question

    respond_to do |format|
      if @answer.save
        format.html do
          redirect_to question_url(@answer.question),
                      notice: "Answer was successfully created."
        end
        format.json { render :show, status: :created, location: @answer }
      else
        format.html { render "questions/show", status: :unprocessable_entity }
        format.json do
          render json: @answer.errors, status: :unprocessable_entity
        end
      end
    end
  end

  def update
    respond_to do |format|
      if @answer.update(answer_params)
        format.html do
          redirect_to answer_url(@answer),
                      notice: "Answer was successfully updated."
        end
        format.json { render :show, status: :ok, location: @answer }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json do
          render json: @answer.errors, status: :unprocessable_entity
        end
      end
    end
  end

  def destroy
    @answer.destroy

    respond_to do |format|
      format.html do
        redirect_to answers_url, notice: "Answer was successfully destroyed."
      end
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_answer
    @answer = Answer.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def answer_params
    params.require(:answer).permit(:description, :question_id)
  end
end
