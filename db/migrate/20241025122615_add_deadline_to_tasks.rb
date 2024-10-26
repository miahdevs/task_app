class AddDeadlineToTasks < ActiveRecord::Migration[7.2]
  def change
    add_column :tasks, :deadline, :datetime
  end
end
