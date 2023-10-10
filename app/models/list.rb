class List < ApplicationRecord
  include RankedModel

  belongs_to :board
  ranks :board_order,
        with_same: :board_id

  has_many :tasks, dependent: :destroy

  validates :name, presence: true
  validates :name, uniqueness: { scope: :board_id }
  validates :color_code, format: { with: /\A#?(?:[A-F0-9]{3}){1,2}\z/i, message: 'Must be a valid hex color' },
            allow_nil: true,
            allow_blank: true
end
