# frozen_string_literal: true
# StaffsHelper
module StaffsHelper
  def edit_button_for_staff(event, staff)
    link_to '編輯', edit_event_staff_path(event, staff), class: 'btn btn-primary' if policy(event).manage?
  end

  def delete_button_for_staff(event, staff)
    avaliable = (policy(event).manage? && event.user_id != staff.id)
    link_to '刪除', event_staff_path(event, staff), class: 'btn btn-danger', method: 'delete', data: { confirm: '刪除?' } if avaliable
  end
end
