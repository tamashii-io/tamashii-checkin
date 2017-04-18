import { EventEmitter } from 'events';
import { fromJS, Record } from 'immutable';

import { RECEIVE_MACHINES } from './constants';

const Machine = Record({
    id: 0,
    serial: '',
    name: '',
    links: {
        self: '',
        edit: ''
    }
});

const machinesToRecords = machines => machines.map(machine => new Machine(machine))

class MachineStore extends EventEmitter {
    constructor() {
        super();
        this.machines = fromJS([]);
    }

    dispatch(action) {
        switch(action.type) {
            case RECEIVE_MACHINES: {
                this.machines = fromJS(machinesToRecords(action.machines));
                this.emit(action.type);
                break;
            }
        }

    }
}

const machines = new MachineStore();

export default machines;
