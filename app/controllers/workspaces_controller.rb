class WorkspacesController < ApplicationController
    before_action :authenticate_user! 
  
    # Create a new workspace
    def create
      workspace = Workspace.new(workspace_params)
      workspace.api_key = SecureRandom.hex(6) 
      if workspace.save
        render json: { message: 'Workspace created successfully', workspace: workspace }, status: :created
      else
        render json: { errors: workspace.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    # Add a team member to the workspace
    def add_team_member
      workspace = Workspace.find(params[:workspace_id])
      user = User.find(params[:user_id])
  
      if workspace.users.include?(user)
        render json: { message: 'User already part of the workspace' }, status: :unprocessable_entity
      else
        workspace.users << user
        render json: { message: 'User added to workspace successfully' }, status: :ok
      end
    end
  
    private
  
    def workspace_params
      params.require(:workspace).permit(:name, :url)
    end
  end
  