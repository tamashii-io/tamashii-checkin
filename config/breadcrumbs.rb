# frozen_string_literal: true
crumb :root do
  link 'Home', root_path
end

crumb :events do
  link 'Events', events_path
end

crumb :event do |event|
  link event.name, event_path(event)
  parent :events
end

crumb :machines do
  link 'Machines', machines_path
end

crumb :attendees do |event|
  link 'Attendees', event_attendees_path(event)
  # TODO: From events to event
  parent :events
end

crumb :attendee do |attendee|
  link attendee.name || 'New'
  parent :attendees, attendee.event
end

crumb :check_points do
  link 'Check Points', check_points_path
end

crumb :check_point do |point|
  link point.name || 'New'
  parent :check_points
end

crumb :check_records do
  link 'Check Records', check_records_path
end
