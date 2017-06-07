# frozen_string_literal: true

# :nodoc:
class CheckRecord < ApplicationRecord
  MAX_CHECKIN_TIME = 5.minutes

  belongs_to :attendee
  belongs_to :check_point
  after_save :broadcast

  scope :active, -> { where(updated_at: MAX_CHECKIN_TIME.ago..Float::INFINITY) }

  def increment
    self.times += 1
    save
  end

  def broadcast
    method = times == 1 ? :set : :update
    [CheckRecordsChannel, AccessesChannel].map { |chan| chan.send(method, self) }
  end
end
