class Workspace < ApplicationRecord
    has_many :workspace_members
    has_many :users, through: :workspace_members
  
  
    validates :name, :url, :api_key, presence: true
  end
  