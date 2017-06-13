# frozen_string_literal: true
# missing top-level class documentation comment
class CustomFieldsDecorator
  MODEL_NAME = ActiveModel::Name.new(self.class, nil, 'custom_fields')

  def model_name
    MODEL_NAME
  end

  def initialize(hash)
    @object = hash.symbolize_keys
  end

  def method_missing(method, *args, &block)
    if @object.key? method
      @object[method]
    elsif @object.respond_to? method
      @object.send(method, *args, &block)
    else
      super
    end
  end

  def attribute?(attr)
    @object.key? attr
  end

  def respond_to_missing?(method, _include_private = false)
    @object.key? method
  end
end
