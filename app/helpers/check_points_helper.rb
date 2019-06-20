# frozen_string_literal: true

# CheckPointsHelper
module CheckPointsHelper
  def new_button_for_check_point(event)
    return unless policy(event).write_check_point?

    link_to '新增打卡點', new_event_check_point_path, class: 'btn btn-secondary'
  end

  def edit_button_for_check_point(event, checkpoint)
    return unless policy(event).write_check_point?

    link_to '編輯', edit_event_check_point_path(event, checkpoint), class: 'btn btn-primary'
  end

  def delete_button_for_check_point(event, checkpoint)
    return unless policy(event).write_check_point?

    link_to '刪除', event_check_point_path(event, checkpoint), method: 'delete', data: { confirm: '確認?' }, class: 'btn btn-danger'
  end
end
