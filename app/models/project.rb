class Project < ApplicationRecord
  belongs_to :category
  belongs_to :owner, class_name: 'User'
  
  has_many :tasks, dependent: :destroy
  has_many :project_contributions, dependent: :destroy
  has_many :contributors, through: :project_contributions, source: :user
end
