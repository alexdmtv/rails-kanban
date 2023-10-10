class Board < ApplicationRecord
  belongs_to :user
  has_many :lists, dependent: :destroy

  accepts_nested_attributes_for :lists, reject_if: :all_blank, allow_destroy: true

  validates :name, presence: true
  validates :name, uniqueness: { scope: :user_id }
  validates_associated :lists
end
