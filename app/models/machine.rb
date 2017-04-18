# frozen_string_literal: true
# missing top-level class documentation comment
class Machine < ApplicationRecord
  has_many :check_points

  scope :recent_update, -> { where(updated_at: 5.minutes.ago..Float::INFINITY) }

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

  def update
    process_command :update
  end

  private

  def process_command(command, options = nil)
    Tamashii::Commander.new(self, command).process(options)
  end
end
