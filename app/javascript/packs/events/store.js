import { EventEmitter } from 'events';
import { fromJS, Record } from 'immutable';

import {
  RECEIVE_ATTENDEES,
  REGISTER_UPDATE,
  AGAIN_ATTENDEES,
} from './constants';
import { EventAttendeesDashboardChannel } from '../channels';

const Attendee = Record({
  attendees: 0,
  checkin: 0,
});

const attendeesToRecord = attendees => new Attendee(attendees);

class AttendeeStore extends EventEmitter {
  constructor() {
    super();
    this.attendees = fromJS([]);
    EventAttendeesDashboardChannel.onReceived(action => this.dispatch(action));
  }

  dispatch(action) {
    switch (action.type) {
      case RECEIVE_ATTENDEES: {
        this.attendees = fromJS(attendeesToRecord(action.attendees));
        this.emit(action.type, this.attendees);
        break;
      }
      case REGISTER_UPDATE: {
        this.emit(action.type);
        break;
      }
      case AGAIN_ATTENDEES: {
        this.attendees = fromJS(attendeesToRecord(action.attendees));
        this.emit(action.type, this.attendees);
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
    this.removeAllListeners(AGAIN_ATTENDEES);
  }
}

const attendees = new AttendeeStore();

export default attendees;
