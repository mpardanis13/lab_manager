class TodosController < ApplicationController
  # GET /todos
  def index
    @todos = Todo.all
    render json: @todos, status: :ok
  end

  # POST /todos
  def create
    @todo = Todo.create!(todo_params)
    render json: @todo, status: :created
  end

  private
  def todo_params
    params.permit(:title, :created_by)
  end
end