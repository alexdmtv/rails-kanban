class UpdateRankedModelColumnNames < ActiveRecord::Migration[7.0]
  def change
    rename_column :boards, :row_order, :user_order
    rename_column :lists, :row_order, :board_order
    rename_column :tasks, :row_order, :list_order
    rename_column :subtasks, :row_order, :task_order
  end
end
