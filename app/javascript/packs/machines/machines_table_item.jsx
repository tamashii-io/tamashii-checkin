import React from 'react';
import PropTypes from 'prop-types';
import moment from 'moment';

import CommandButton from './command_button.jsx';

const COMMANDS = [
  { command: 'beep', name: 'Beep', skin: 'warning' },
  { command: 'update', name: 'Update', skin: 'info' },
  { command: 'restart', name: 'Restart', skin: 'primary' },
  { command: 'reboot', name: 'Reboot', skin: 'success' },
  { command: 'poweroff', name: 'Poweroff', skin: 'danger' },
];

const formatLastActive = date => (date ? moment(date).calendar() : '');
const buildCommands = link => (
  COMMANDS.map(attr => <CommandButton key={attr.command} link={link} {...attr} />)
);


const MachinesTableItem = ({ machine }) => (
  <tr>
    <td>{machine.serial}</td>
    <td>{machine.name}</td>
    <td>
      <div className="btn-group">{ buildCommands(machine.links.command) }</div>
    </td>
    <td>{formatLastActive(machine.lastActive)}</td>
    <td>
      <a href={machine.links.edit} className="btn btn-primary">編輯</a>
      <a
        href={machine.links.self}
        className="btn btn-danger"
        data-method="delete"
        data-confirm="Are you sure?"
      >刪除</a>
    </td>
  </tr>
);

MachinesTableItem.propTypes = {
  machine: PropTypes.shape({}).isRequired,
};

export default MachinesTableItem;
