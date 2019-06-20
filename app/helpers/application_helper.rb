# frozen_string_literal: true

# ApplicationHelper
module ApplicationHelper
  def text_with_icon(icon, text)
    capture do
      concat content_tag(:i, nil, class: icon)
      concat text
    end
  end

  def progress_bar(color: 'success', value: 0, max: 100, size: 'progress-xs')
    percent = number_to_percentage(value.to_f / max * 100)
    content_tag :div, class: "progress #{size}" do
      content_tag :div, nil, class: "progress-bar bg-#{color}", style: "width: #{percent}"
    end
  end

  def button(name, target, type = 'primary', **options)
    options ||= {}
    options[:class] = merge_classes(options[:class] || '', "btn btn-#{type}")
    link_to name, target, **options
  end

  def merge_classes(origin, new)
    (origin.split(' ') + new.split(' ')).uniq.join(' ')
  end
end
