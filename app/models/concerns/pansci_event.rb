# frozen_string_literal: true

module PansciEvent
  extend ActiveSupport::Concern

  included do
    store :meta, accessors: %i[pansci_event pansci_event_id pansci_event_secret]

    validates :pansci_event_id, :pansci_event_secret, presence: true, if: :pansci_event?

    def pansci_event=(value)
      super(ActiveModel::Type::Boolean.new.cast(value))
    end
  end

  def sync_pansci_attendees
    return unless pansci_event?

    pansci_attendees = PansciEventService.new(pansci_event_id, pansci_event_secret).fetch_attendees
    pansci_attendees.map! { |attendee| pansci_attendee_to_attendee(attendee) }
    attendees.import pansci_attendees, on_duplicate_key_update: {
      conflict_target: %i[event_id code],
      columns: %i[name email phone]
    }
  end

  def pansci_event?
    pansci_event == true
  end

  protected

  def pansci_attendee_to_attendee(attendee)
    attendees.build(
      code: attendee.fetch('uid'),
      name: attendee.dig('info', 'name'),
      email: attendee.dig('info', 'email'),
      phone: attendee.dig('info', 'phone')
    )
  end
end
