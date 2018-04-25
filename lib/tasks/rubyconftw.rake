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
      conflict_target: [:event_id, :code],
      columns: [:name, :email, :phone, :note]
    }

    puts "Total #{attendees.count} attendees imported."
  end

  def attendees
    csv.rewind
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
      code: attendee['檢查碼'],
      name: attendee['姓名'],
      email: attendee['Email'],
      phone: attendee['手機'],
      note: attendee['T-Shirt Size（Please look T-Shirt Size Section）']
    )
  end
end

namespace :rubyconftw do
  desc 'Import RubyConf Taiwan attendees data from csv'
  task :import, [:event, :file] => [:environment] do |_, args|
    event = Event.find(args[:event])
    RubyConfTWImporter.new(event, args[:file]).import!
  end
end
