class CreateProjectContributions < ActiveRecord::Migration[7.2]
  def change
    create_table :project_contributions do |t|
      t.references :project, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end

    add_index :project_contributions, [:project_id, :user_id], unique: true
  end
end
