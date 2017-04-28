# frozen_string_literal: true
crumb :root do
  link 'Home', root_path
end

crumb :home do
  link 'Dashbaord', root_path
end

crumb :events do
  link 'Events', events_path
end

crumb :event do |event|
  link event.name || 'New', event
  parent :events
end

crumb :machines do
  link 'Machines', machines_path
end

crumb :machine do |machine|
  link machine.name || 'New', machine
  parent :machines
end

crumb :attendees do |event|
  link 'Attendees', event_attendees_path(event)
  parent :event, event
end

crumb :attendee do |attendee|
  link attendee.name || 'New'
  parent :attendees, attendee.event
end

crumb :check_points do
  link 'Check Points', check_points_path
end

crumb :check_points do |event|
  link 'Check Records', event_check_points_path(event)
  parent :event, event
end

crumb :check_point do |point|
  link point.name || 'New'
  parent :check_points, point.event
end

crumb :check_records do
  link 'Check Records', check_records_path
end

crumb :check_records do |event|
  link 'Check Records', event_check_records_path(event)
  parent :event, event
end

crumb :staffs do |event|
  link 'Staffs', event_staffs_path(event)
  parent :event, event
end

crumb :staff do |staff|
  link staff.user || 'New'
  parent :staffs, staff.event
end

crumb :user do |user|
  link user.username
end
