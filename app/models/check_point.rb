# frozen_string_literal: true
# missing top-level class documentation comment
class CheckPoint < ApplicationRecord
  self.inheritance_column = :_type
  has_many :check_record
  belongs_to :event
  belongs_to :machine
end
