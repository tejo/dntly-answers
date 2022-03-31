# frozen_string_literal: true

class QuestionsController < ApplicationController
  before_action :set_question, only: %i[show edit update destroy]
  before_action :set_current_user_questions

  # GET /questions or /questions.json
  def index
    @questions =
      Question.search(params[:q]).includes(:answers, :user).order(
        created_at: :desc
      ).page(params[:page])
  end

  # GET /questions/1 or /questions/1.json
  def show
  end

  # GET /questions/new
  def new
    @question = Question.new
  end

  # GET /questions/1/edit
  def edit
  end

  # POST /questions or /questions.json
  def create
    @question = Question.new(question_params)
    @question.user = current_user

    respond_to do |format|
      if @question.save
        format.html do
          redirect_to question_url(@question),
                      notice: "Question was successfully created."
        end
        format.json { render :show, status: :created, location: @question }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json do
          render json: @question.errors, status: :unprocessable_entity
        end
      end
    end
  end

  # PATCH/PUT /questions/1 or /questions/1.json
  def update
    respond_to do |format|
      if @question.update(question_params)
        format.html do
          redirect_to question_url(@question),
                      notice: "Question was successfully updated."
        end
        format.json { render :show, status: :ok, location: @question }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json do
          render json: @question.errors, status: :unprocessable_entity
        end
      end
    end
  end

  # DELETE /questions/1 or /questions/1.json
  def destroy
    @question = current_user.questions.find(params[:id])

    respond_to do |format|
      format.html do
        redirect_to questions_url,
                    notice: "Question was successfully destroyed."
      end
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_question
    @question = Question.includes(:answers, :user).find(params[:id])
  end

  def set_current_user_questions
    @current_user_questions =
      Question.where(user: current_user).order(created_at: :desc)
  end

  # Only allow a list of trusted parameters through.
  def question_params
    params.require(:question).permit(:title, :description)
  end
end
