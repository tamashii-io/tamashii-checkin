# frozen_string_literal: true
# Event
class Event < ApplicationRecord
  include PansciEvent

  has_many :attendees
  has_many :check_points
  has_many :check_records, through: :check_points
  has_many :machines, through: :check_points
  has_many :user_event_relationships, dependent: :destroy
  has_many :staffs, through: :user_event_relationships, source: :user

  scope :now, -> { where('? BETWEEN start_at AND end_at', Time.zone.now) }
  scope :overlap, ->(range) { where('TSRANGE(start_at, end_at) && TSRANGE(?, ?)', range.begin, range.end) }

  validates :name, presence: true

  before_save :ensure_api_token_exists

  def peroid
    start_at..end_at
  end

  def to_s
    name
  end

  def ensure_api_token_exists
    self.api_token = Devise.friendly_token if api_token.blank?
  end

  # Note: if no records available, the pair will NOT exist in the hash
  # Namely, there will be no records with value is 0
  def check_point_summary(time_interval)
    check_records.where('check_records.updated_at >= ?', Time.zone.now - time_interval)
                 .group(:check_point_id)
                 .count
                 .tap do |hash|
      hash.each do |k, v|
        hash[k] = { count: v }
      end
    end
  end
end
