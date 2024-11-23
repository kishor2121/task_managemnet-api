class TasksController < ApplicationController
    before_action :authenticate_user!
    before_action :set_task, only: [:show, :update, :destroy]
  
   
    def index
      tasks = Task.all

      if params[:category_id].present?
        tasks = tasks.where(category_id: params[:category_id])
      end
    
      if params[:sort_by].present? && %w[priority due_date title].include?(params[:sort_by])
        tasks = tasks.order(params[:sort_by] => :asc)
      end

      if params[:search].present?
        search_query = params[:search]
        tasks = tasks.where("title LIKE ? OR description LIKE ?", "%#{search_query}%", "%#{search_query}%")
      end
 
      per_page = params[:per_page].presence || 20
      page = params[:page].presence || 1
      tasks = tasks.limit(per_page).offset((page.to_i - 1) * per_page.to_i)
    
      render json: { 
        tasks: tasks,
        total_count: tasks.count 
      }
    end

    # GET /tasks/:id
    def show
      render json: @task, status: :ok
    end
  
    # POST /tasks
    def create
      task = Task.new(task_params)
      if task.save
        render json: { message: 'Task created successfully', task: task }, status: :created
      else
        render json: { errors: task.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    def update
      task = Task.find(params[:id])
      if task.update(task_params)
        render json: { message: 'Task updated successfully', task: task }, status: :ok
      else
        render json: { errors: task.errors.full_messages }, status: :unprocessable_entity
      end
    end

    # DELETE /tasks/:id
    def destroy
      @task.destroy
      render json: { message: "Task deleted successfully" }, status: :ok
    end
  
    private
  
    def set_task
      @task = current_user.tasks.find_by(id: params[:id])
      render json: { error: "Task not found" }, status: :not_found unless @task
    end
  
    def task_params
      params.require(:task).permit(:title, :description, :due_date, :priority, :remind_before_at, :completion_status)
    end
  end
  