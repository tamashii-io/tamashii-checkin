# frozen_string_literal: true
# StaffsHelper
module StaffsHelper
  def edit_button_for_staff(event, staff)
    link_to '編輯', edit_event_staff_path(event, staff), class: 'btn btn-primary' if policy(event).admin_or_event_manager?
  end

  def delete_button_for_staff(event, staff)
    link_to '刪除', event_staff_path(event, staff), class: 'btn btn-danger', method: 'delete', data: { confirm: '刪除?' } if policy(event).admin_or_event_manager?
  end
end
