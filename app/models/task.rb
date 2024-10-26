class Task < ApplicationRecord
  belongs_to :project
  belongs_to :assignee, class_name: 'User'

  # add default status of "Not Started"
  after_initialize :set_default_status, if: :new_record?

  def set_default_status
    self.status ||= "Not Started"
  end
end
