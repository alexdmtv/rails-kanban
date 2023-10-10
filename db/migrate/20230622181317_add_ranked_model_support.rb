class AddRankedModelSupport < ActiveRecord::Migration[7.0]
  def change
    add_column :boards, :row_order, :integer
    Board.update_all('row_order = cast(position as integer)')
    remove_column :boards, :position, :float

    add_column :lists, :row_order, :integer
    List.update_all('row_order = cast(position as integer)')
    remove_column :lists, :position, :float

    add_column :tasks, :row_order, :integer
    Task.update_all('row_order = cast(position as integer)')
    remove_column :tasks, :position, :float

    add_column :subtasks, :row_order, :integer
    Subtask.update_all('row_order = cast(position as integer)')
    remove_column :subtasks, :position, :float
  end
end
