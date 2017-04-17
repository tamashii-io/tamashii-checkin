# frozen_string_literal: true
# missing top-level class documentation comment
class Machine < ApplicationRecord
  has_many :check_point

  scope :recent_update, -> { where(updated_at: 5.minutes.ago..Float::INFINITY) }
end
