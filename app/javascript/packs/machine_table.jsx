// Run this example by adding <%= javascript_pack_tag 'hello_react' %> to the head of your layout file,
// like app/views/layouts/application.html.erb. All it does is render <div>Hello React</div> at the bottom
// of the page.

import React from 'react'
import ReactDOM from 'react-dom'

import store from './machines/store';
import { RECEIVE_MACHINES } from './machines/constants';
import { fetchMachines } from './machines/action';

const MachineTableItem = ({machine}) => (
  <tr>
    <td>{machine.serial}</td>
    <td>{machine.name}</td>
    <td>
      <a href={machine.links.edit} className='btn btn-primary'>編輯</a>
      <a href={machine.links.self} className='btn btn-danger' data-method='delete' data-confirm='Are you sure?'>刪除</a>
    </td>
  </tr>
)

class MachineTable extends React.Component {
  constructor(props) {
    super(props);
    store.on(RECEIVE_MACHINES, () => this.setState({machines: store.machines}));
    this.state = {
      machines: []
    }
  }

  componentWillMount() {
    fetchMachines();
  }

  componentWillUnmount() {
    store.removeAllListeners(RECEIVE_MACHINES);
  }

  render() {
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
        {this.state.machines.map(machine => <MachineTableItem key={machine.id} machine={machine}/>)}
        </tbody>
      </table>
    );
  }
}

MachineTable.defaultProps = {
}

MachineTable.propTypes = {
}

export default class MachineTableModule {
  mount() {
    const machines = document.getElementById('machines');
    if(machines) {
      ReactDOM.render(<MachineTable />, machines)
    }
  }

  unmount() {
    const machines = document.getElementById('machines');
    if(machines) {
      ReactDOM.unmountComponentAtNode(machines);
    }
  }
}

