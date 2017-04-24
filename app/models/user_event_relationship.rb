# frozen_string_literal: true
# User Event Relationship
class UserEventRelationship < ApplicationRecord
  belongs_to :user
  belongs_to :event

  enum role: {
    owner: 0,
    staff: 1
  }
end
