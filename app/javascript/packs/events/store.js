import { EventEmitter } from 'events';
import { fromJS } from 'immutable';

import {
  RECEIVE_ATTENDEES,
  REGISTER_UPDATE,
} from './constants';
import { EventAttendeesDashboardChannel } from '../channels';

class AttendeeStore extends EventEmitter {
  constructor() {
    super();
    this.attendees = fromJS([]);
    EventAttendeesDashboardChannel.onReceived(action => this.dispatch(action));
  }

  dispatch(action) {
    switch (action.type) {
      case RECEIVE_ATTENDEES: {
        this.attendees = action.attendees;
        this.emit(action.type, this.attendees);
        break;
      }
      case REGISTER_UPDATE: {
        this.emit(action.type);
        break;
      }
      default: {
        break;
      }
    }
  }

  off() {
    this.removeAllListeners(RECEIVE_ATTENDEES);
    this.removeAllListeners(REGISTER_UPDATE);
  }
}

const attendees = new AttendeeStore();

export default attendees;
