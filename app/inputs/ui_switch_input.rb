# frozen_string_literal: true

class UiSwitchInput < SimpleForm::Inputs::BooleanInput
  include ActionView::Context
  include ActionView::Helpers::TextHelper

  def input(wrapper_options = nil)
    merged_input_options = merge_wrapper_options(input_html_options.merge(class: 'switch-input'), wrapper_options)
    build_switch(merged_input_options)
  end

  protected

  def build_switch(merged_input_options)
    content_tag :label, class: "switch switch-label switch-#{type} switch-#{style} mx-2" do
      concat build_check_box(unchecked_value, merged_input_options)
      concat content_tag :span, '', class: 'switch-slider', data: { checked: on_label, unchecked: off_label }
    end
  end

  def type
    options[:type] || 'pill'
  end

  def style
    options[:style] || 'success'
  end

  def on_label
    options[:checked] || '✓'
  end

  def off_label
    options[:unchecked] || '✕'
  end
end
