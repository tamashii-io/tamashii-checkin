class Event < ApplicationRecord
	validates :name, presence: true
end
