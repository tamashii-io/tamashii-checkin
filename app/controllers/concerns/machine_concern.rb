# frozen_string_literal: true

module MachineConcern
  extend ActiveSupport::Concern

  def check_machine_permission!
    return if has_machine_permission?

    flash[:error] = I18n.t('permission.denied')
    redirect_to machines_path
  end

  # rubocop:disable Style/PredicateName
  def has_machine_permission?
    current_user&.admin
  end
  # rubocop:enable Style/PredicateName
end
