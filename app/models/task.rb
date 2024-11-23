class Task < ApplicationRecord
  belongs_to :user
  belongs_to :category, optional: true

  validates :title, presence: true, length: { maximum: 15 }
  validates :description, length: { maximum: 15 }, allow_blank: true
  validates :due_date, presence: true, comparison: { greater_than: Date.today, message: "must be in the future" }
  validates :priority, inclusion: { in: %w[High Medium Low], message: "%{value} is not a valid priority" }
end
