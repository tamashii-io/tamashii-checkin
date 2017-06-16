# frozen_string_literal: true
# CheckPointsHelper
module CheckPointsHelper
  def edit_button_for_check_point(event, checkpoint)
    link_to '編輯', edit_event_check_point_path(event, checkpoint), class: 'btn btn-primary'
  end

  def delete_button_for_check_point(event, checkpoint)
    relationship = UserEventRelationship.find_by(event_id: event.id, user_id: current_user.id)
    avaliable = policy(event).manage? || policy(relationship).write_check_point?
    link_to '刪除', event_check_point_path(event, checkpoint), method: 'delete', data: { confirm: '確認?' }, class: 'btn btn-danger' if avaliable
  end
end
