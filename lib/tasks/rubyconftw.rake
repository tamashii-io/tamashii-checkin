# frozen_string_literal: true

require 'csv'

# :nodoc:
class RubyConfTWImporter
  attr_reader :event, :csv

  def initialize(event, file)
    @event = event
    @csv = CSV.open(file, headers: true)
  end

  def import!
    event.attendees.import attendees, on_duplicate_key_update: {
      conflict_target: %i[event_id code],
      columns: %i[name email phone note]
    }

    puts "Total #{attendees.count} attendees imported."
  end

  def attendees
    @attendees ||=
      csv
      .select { |row| row['報名序號'].present? }
      .map do |row|
        transform_attendee(row)
      end
  end

  private

  def transform_attendee(attendee)
    event.attendees.build(
      serial: attendee['報名序號'],
      code: "#{attendee['報名序號']}-#{attendee['檢查碼']}",
      name: attendee['姓名'],
      email: attendee['Email'],
      phone: attendee['手機'],
      t_shirt: attendee['T-Shirt'],
      ticket_type: attendee['票種']
    )
  end
end

namespace :rubyconftw do
  desc 'Import RubyConf Taiwan attendees data from csv'
  task :import, %i[event file] => [:environment] do |_, args|
    event = Event.find(args[:event])
    RubyConfTWImporter.new(event, args[:file]).import!
  end
end
