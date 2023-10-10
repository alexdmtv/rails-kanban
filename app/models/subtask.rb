class Subtask < ApplicationRecord
  include RankedModel

  belongs_to :task
  ranks :task_order, with_same: :task_id

  validates :title, presence: true
  validates :title, length: { maximum: 100 }
end
