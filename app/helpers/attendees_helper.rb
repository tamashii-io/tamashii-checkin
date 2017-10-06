# frozen_string_literal: true
# AttendeesHelper
module AttendeesHelper
  def sync_button_for_event(event)
    return unless policy(event).write_attendee?
    link_to '同步', sync_event_attendees_path(event), class: 'btn btn-secondary', method: :post if event.pansci_event?
  end

  def new_attendee_button_for_event(event)
    return unless policy(event).write_attendee?
    link_to '新增會眾', new_event_attendee_path(event), class: 'btn btn-secondary'
  end
end
