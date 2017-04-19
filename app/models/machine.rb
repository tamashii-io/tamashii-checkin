# frozen_string_literal: true
# missing top-level class documentation comment
class Machine < ApplicationRecord
  has_many :check_points
  has_many :events, through: :check_points
end
