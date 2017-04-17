# frozen_string_literal: true
# ApplicationHelper
module ApplicationHelper
  def text_with_icon(icon, text)
    capture do
      concat content_tag(:i, nil, class: icon)
      concat text
    end
  end
end
