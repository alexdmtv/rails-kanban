class AddNullabilityForForeignKeys < ActiveRecord::Migration[7.0]
  def change
    change_column_null :boards, :user_id, true
    change_column_null :lists, :board_id, true
    change_column_null :tasks, :list_id, true
    change_column_null :subtasks, :task_id, true
  end
end
