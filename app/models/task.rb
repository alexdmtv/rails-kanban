class Task < ApplicationRecord
  include RankedModel

  belongs_to :list
  ranks :list_order, with_same: :list_id

  has_many :subtasks, dependent: :destroy
  accepts_nested_attributes_for :subtasks, reject_if: :all_blank, allow_destroy: true

  validates :title, presence: true, length: { maximum: 100 }
  validates :description, length: { maximum: 500, too_long: '%<count>s characters is the maximum allowed' }
  validates_associated :subtasks
end
