# frozen_string_literal: true
# missing top-level class documentation comment
class CheckRecord < ApplicationRecord
  MAX_CHECKIN_TIME = 5.minutes

  belongs_to :attendee
  belongs_to :check_point

  scope :active, -> { where(updated_at: MAX_CHECKIN_TIME.ago..Float::INFINITY) }

  def increment
    self.times += 1
    save
  end
end
