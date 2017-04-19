import { EventEmitter } from 'events';
import { fromJS, Record } from 'immutable';

import { RECEIVE_MACHINES } from './constants';

const Machine = Record({
  id: 0,
  serial: '',
  name: '',
  links: {
    self: '',
    edit: '',
  },
  lastActive: null,
});

const machinesToRecords = machines => machines.map(machine => new Machine(machine));

class MachineStore extends EventEmitter {
  constructor() {
    super();
    this.machines = fromJS([]);
    App.machines.received = (data) => { this.onReceive(data); };
  }

  update(serial, attr, value) {
    this.machines = this.machines.update(this.index(serial), item => item.set(attr, value));
  }

  index(serial) {
    return this.machines.findIndex(machine => machine.serial === serial);
  }

  // Processing ActionCable data
  onReceive(data) {
    switch (data.event) {
      case 'LAST_ACTIVE_UPDATED': {
        this.update(data.serial, 'lastActive', new Date(data.last_active));
        this.emit(RECEIVE_MACHINES);
        break;
      }
      default: {
        break;
      }
    }
  }

  dispatch(action) {
    switch (action.type) {
      case RECEIVE_MACHINES: {
        this.machines = fromJS(machinesToRecords(action.machines));
        this.emit(action.type);
        break;
      }
      default: {
        break;
      }
    }
  }
}

const machines = new MachineStore();

export default machines;
