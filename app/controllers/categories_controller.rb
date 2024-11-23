class CategoriesController < ApplicationController
    def index
      categories = Category.all
      render json: categories
    end
  
    def show
      category = Category.find(params[:id])
      tasks = category.tasks.order(:priority, :due_date) # Sorting by priority and due_date
      render json: tasks
    end
  end
  