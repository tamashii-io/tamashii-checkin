import { EventEmitter } from 'events';
import { fromJS, Record } from 'immutable';

import {
  RECEIVE_ATTENDEES,
  REGISTER_UPDATE,
  AGAIN_ATTENDEES,
} from './constants';
import { RegistrarChannel } from '../channels';

const Attendee = Record({
  id: 0,
  code: '',
  serial: 0,
  card_serial: '',
  email: '',
  name: '',
  phone: '',
  links: {
    edit: '',
    self: '',
  },
});

const attendeesToRecord = attendees => attendees.map(attendee => new Attendee(attendee));

class AttendeeStore extends EventEmitter {
  constructor() {
    super();
    this.attendees = fromJS([]);
    RegistrarChannel.onReceived(action => this.dispatch(action));
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
