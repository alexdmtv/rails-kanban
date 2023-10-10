# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

alex = User.find_by(email: 'alex@email.com')
return if alex

alex = User.create!(
  first_name: 'Alex',
  last_name: 'D',
  email: 'alex@email.com',
  is_active: true
)

file = File.read(Rails.root.join('db/seed_files', 'data.json'))
data = JSON.parse(file)

data['boards'].each_with_index do |board, idx|
  db_board = alex.boards.create!(
    name: board['name'],
    position: idx
  )

  board['columns'].each_with_index do |list, idx|
    db_list = db_board.lists.create!(
      name: list['name'],
      position: idx
    )

    list['tasks'].each_with_index do |task, idx|
      db_task = db_list.tasks.create!(
        title: task['title'],
        description: task['description'],
        position: idx
      )

      task['subtasks'].each_with_index do |subtask, idx|
        db_task.subtasks.create!(
          title: subtask['title'],
          is_completed: subtask['isCompleted'],
          position: idx
        )
      end
    end
  end
end
