# frozen_string_literal: true

class SwitchInput < SimpleForm::Inputs::BooleanInput
  include ActionView::Context
  include ActionView::Helpers::TextHelper

  def input(wrapper_options = nil)
    merged_input_options = merge_wrapper_options(input_html_options.merge(class: 'switch-input'), wrapper_options)
    build_switch(merged_input_options)
  end

  protected

  def build_switch(merged_input_options)
    content_tag :label, class: "switch switch-icon switch-#{type} switch-#{style}-alt mx-2" do
      concat build_check_box(unchecked_value, merged_input_options)
      concat content_tag :span, '', class: 'switch-label', data: { on: on_label, off: off_label }
      concat content_tag :span, '', class: 'switch-handle'
    end
  end

  def type
    options[:type] || 'pill'
  end

  def style
    options[:style] || 'primary-outline'
  end

  def on_label
    options[:on] || ''
  end

  def off_label
    options[:off] || ''
  end
end
