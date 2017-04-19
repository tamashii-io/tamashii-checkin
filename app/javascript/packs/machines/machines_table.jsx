import React, { PropTypes } from 'react';

import store from './store';
import { RECEIVE_MACHINES } from './constants';
import { fetchMachines } from './action';

const MachineTableItem = ({ machine }) => (
  <tr>
    <td>{machine.serial}</td>
    <td>{machine.name}</td>
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
    this.state = {
      machines: [],
    };
  }

  componentWillMount() {
    fetchMachines();
  }

  componentWillUnmount() {
    store.removeAllListeners(RECEIVE_MACHINES);
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
