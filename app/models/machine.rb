# frozen_string_literal: true

# :nodoc:
class Machine < ApplicationRecord
  has_many :check_points
  has_many :events, through: :check_points

  validates :serial, uniqueness: true

  scope :recent_update, -> { where(updated_at: 5.minutes.ago..Float::INFINITY) }

  def current_event_check_point
    check_points.find_by(event: events.now)
  end

  def current_event
    events.now.first
  end

  def write(packet)
    Tamashii::Manager::Client.send_to(serial, packet.dump)
  end

  def on_accept
    process_command :lcd_set_idle_text, "Tamashii Checkin\nSystem Ready"
  end

  # TODO: Use ruby auto generate below code
  def beep(type = 'ok')
    process_command :beep, type
  end

  def restart
    process_command :restart
  end

  def reboot
    process_command :reboot
  end

  def poweroff
    process_command :poweroff
  end

  # TODO: Fix conflict with ActiveModel#update
  # def update
  #   process_command :update
  # end

  def lcd_message(message)
    process_command :lcd_message, message
  end

  def lcd_set_idle_text(text)
    process_command :lcd_set_idle_text, text
  end

  def to_s
    name
  end

  private

  def process_command(command, options = nil)
    Tamashii::Commander.new(self, command).process(options)
  end
end
