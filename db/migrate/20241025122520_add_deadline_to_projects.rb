class AddDeadlineToProjects < ActiveRecord::Migration[7.2]
  def change
    add_column :projects, :deadline, :datetime
  end
end
