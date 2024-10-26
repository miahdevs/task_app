# app/models/user.rb
class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Projects owned by the user
  has_many :owned_projects, class_name: 'Project', foreign_key: :owner_id

  # Projects the user contributes to
  has_many :project_contributions
  has_many :contributed_projects, through: :project_contributions, source: :project

  # Tasks assigned to the user
  has_many :assigned_tasks, class_name: 'Task', foreign_key: :assignee_id

  # Helper method to get all projects (both owned and contributed)
  def all_projects
    Project.where(id: (owned_project_ids + contributed_project_ids).uniq)
  end
end