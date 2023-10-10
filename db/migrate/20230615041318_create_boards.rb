class CreateBoards < ActiveRecord::Migration[7.0]
  def change
    create_table :boards do |t|
      t.string :name, null: false
      t.float :position, null: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end

    add_index :boards, %i[user_id name], unique: true
  end
end
