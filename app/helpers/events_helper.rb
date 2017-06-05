# frozen_string_literal: true
# EventsHelper
module EventsHelper
  def edit_button(event)
    link_to '編輯', edit_event_path(event), class: 'btn btn-primary'
  end

  def delete_button(event)
    link_to '刪除', event_path(event), class: 'btn btn-danger', method: 'delete', data: { confirm: '確認刪除' } if policy(event).delete_button?
  end
end
