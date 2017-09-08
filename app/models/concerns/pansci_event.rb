# frozen_string_literal: true

module PansciEvent
  extend ActiveSupport::Concern

  included do
    store :meta, accessors: [:pansci_event, :pansci_event_id, :pansci_event_secret]

    validates :pansci_event_id, :pansci_event_secret, presence: true, if: :pansci_event?

    def pansci_event=(value)
      super(ActiveModel::Type::Boolean.new.cast(value))
    end
  end

  def pansci_event?
    pansci_event == true
  end
end
