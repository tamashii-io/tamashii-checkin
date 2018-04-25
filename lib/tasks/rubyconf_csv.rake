# frozen_string_literal: true
require 'csv'    
namespace :rubyconf_csv do
  desc "import attendees data from csv"
  task :import_csv => :environment do
    csv = CSV.open('event-rubyelixirconftaiwan2018-attendees.csv', headers: true)
    ev = Event.last
    attendees = csv.select { |attendee| attendee['報名序號'].present? }
      .map { |attendee| ev.attendees.build(serial: attendee['報名序號'], code: attendee['檢查碼'], name: attendee['姓名'], email: attendee['Email'], phone: attendee['手機'], note: attendee['T-Shirt Size（Please look T-Shirt Size Section）']) }
  end
end
