# frozen_string_literal: true
# Machine Helper
module MachinesHelper
  def machine_command_button(machine, command, style = 'primary', _options = nil)
    button command.to_s.titleize, machine_actions_path(machine, command: command), style, method: :post, remote: true
  end
end
