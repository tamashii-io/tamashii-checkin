# frozen_string_literal: true
# missing top-level class documentation comment
class CheckRecord < ApplicationRecord
  belongs_to :attendee
  belongs_to :check_point

  def increment
    self.times += 1
    save
  end
end
