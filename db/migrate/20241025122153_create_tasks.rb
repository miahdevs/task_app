class CreateTasks < ActiveRecord::Migration[7.2]
  def change
    create_table :tasks do |t|
      t.string :name
      t.text :description
      t.string :status
      t.references :assignee, null: false, foreign_key: { to_table: :users }
      t.references :project, null: false, foreign_key: true

      t.timestamps
    end
  end
end
