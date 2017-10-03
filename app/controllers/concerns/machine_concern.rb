module MachineConcern
  extend ActiveSupport::Concern

  def check_machine_permission!
    if !has_machine_permission?
      flash[:error] =  "You have no permission to manage machines."
      redirect_to machines_path
    end
  end

  def has_machine_permission?
    current_user&.admin
  end
end