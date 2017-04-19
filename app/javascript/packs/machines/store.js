import { EventEmitter } from 'events';
import { fromJS, Record } from 'immutable';

import {
  RECEIVE_MACHINES,
  LAST_ACTIVE_CHANGED,
} from './constants';
import { MachineChannel } from '../channels';

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
    MachineChannel.onReceived(action => this.dispatch(action));
  }

  update(serial, attr, value) {
    this.machines = this.machines.update(this.index(serial), item => item.set(attr, value));
  }

  index(serial) {
    return this.machines.findIndex(machine => machine.serial === serial);
  }

  dispatch(action) {
    switch (action.type) {
      case RECEIVE_MACHINES: {
        this.machines = fromJS(machinesToRecords(action.machines));
        this.emit(action.type);
        break;
      }
      case LAST_ACTIVE_CHANGED: {
        this.update(action.serial, 'lastActive', new Date(action.last_active));
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
