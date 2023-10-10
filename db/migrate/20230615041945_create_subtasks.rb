class CreateSubtasks < ActiveRecord::Migration[7.0]
  def change
    create_table :subtasks do |t|
      t.string :title, null: false
      t.boolean :is_completed, null: false, default: false
      t.references :task, null: false, foreign_key: true
      t.float :position, null: false

      t.timestamps
    end
  end
end
