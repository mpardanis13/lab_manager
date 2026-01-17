class TodosController < ApplicationController
  def index
    @todos = current_user.todos
    render json: @todos
  end

  def create
    @todo = current_user.todos.create!(todo_params)
    render json: @todo, status: :created
  end

  def show
    @todo = Todo.find(params[:id])
    render json: @todo
  end

  def update
    @todo = Todo.find(params[:id])
    @todo.update(todo_params)
    head :no_content
  end

  def destroy
    @todo = Todo.find(params[:id])
    @todo.destroy
    head :no_content
  end

  private
  def todo_params
    params.permit(:title)
  end
end