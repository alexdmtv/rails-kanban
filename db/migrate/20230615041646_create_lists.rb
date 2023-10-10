class CreateLists < ActiveRecord::Migration[7.0]
  def change
    create_table :lists do |t|
      t.string :name, null: false
      t.string :color_code
      t.references :board, null: false, foreign_key: true
      t.float :position, null: false

      t.timestamps
    end

    add_index :lists, %i[name board_id], unique: true
  end
end
