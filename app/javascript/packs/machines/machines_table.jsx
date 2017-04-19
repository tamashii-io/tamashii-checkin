import React from 'react';
import PropTypes from 'prop-types';
import moment from 'moment';

import store from './store';
import {
  RECEIVE_MACHINES,
  LAST_ACTIVE_CHANGED,
} from './constants';
import { fetchMachines } from './action';

const formatLastActive = date => (date ? moment(date).calendar() : '');

// TODO: Bind ajax:success event for command result
const CommandButton = ({ name, skin, link, command }) => (
  <a
    className={`btn btn-${skin}`}
    data-remote="true"
    data-method="post"
    href={`${link}?command=${command}`}
  >{name}</a>
);

CommandButton.propTypes = {
  link: PropTypes.string.isRequired,
  name: PropTypes.string.isRequired,
  skin: PropTypes.string.isRequired,
  command: PropTypes.string.isRequired,
};

const MachineTableItem = ({ machine }) => (
  <tr>
    <td>{machine.serial}</td>
    <td>{machine.name}</td>
    <td>
      <div className="btn-group">
        <CommandButton name="Beep" command="beep" skin="warning" link={machine.links.command} />
        <CommandButton
          name="Restart"
          command="restart"
          skin="primary"
          link={machine.links.command}
        />
        <CommandButton name="Reboot" command="reboot" skin="success" link={machine.links.command} />
        <CommandButton
          name="Poweroff"
          command="poweroff"
          skin="danger"
          link={machine.links.command}
        />
      </div>
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

MachineTableItem.propTypes = {
  machine: PropTypes.shape({}).isRequired,
};

class MachinesTable extends React.Component {
  constructor(props) {
    super(props);
    store.on(RECEIVE_MACHINES, () => this.setState({ machines: store.machines }));
    store.on(LAST_ACTIVE_CHANGED, () => this.setState({ machines: store.machines }));
    this.state = {
      machines: [],
    };
  }

  componentWillMount() {
    fetchMachines();
  }

  componentWillUnmount() {
    store.removeAllListeners(RECEIVE_MACHINES);
    store.removeAllListeners(LAST_ACTIVE_CHANGED);
  }

  render() {
    const machines = this.state
                         .machines
                         .map(machine => <MachineTableItem key={machine.id} machine={machine} />);
    return (
      <table className="table table-bordered table-striped table-condensed">
        <thead>
          <tr>
            <th>序號</th>
            <th>名稱</th>
            <th>指令</th>
            <th>最後連線</th>
            <th>動作</th>
          </tr>
        </thead>
        <tbody>
          { machines }
        </tbody>
      </table>
    );
  }
}

export default MachinesTable;
