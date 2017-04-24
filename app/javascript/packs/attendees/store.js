import { EventEmitter } from 'events';
import { fromJS, Record } from 'immutable';

import {
  RECEIVE_ATTENDEES,
  START_REGISTER,
  REGISTER,
  REGISTER_SUCCESS,
  REGISTER_UPDATE,
  CANCEL_REGISTER,
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
    this.nextRegisterAttendeeId = 0;
    RegistrarChannel.onReceived(action => this.dispatch(action));
  }

  update(attendeeId, newAttendee) {
    const index = this.index(attendeeId);
    if (index >= 0) {
      this.attendees = this.attendees.set(index, newAttendee);
    }
  }

  index(attendeeId) {
    return this.attendees.findIndex(attendee => attendee.id === attendeeId);
  }

  dispatch(action) {
    switch (action.type) {
      case RECEIVE_ATTENDEES: {
        this.attendees = fromJS(attendeesToRecord(action.attendees));
        this.emit(action.type, this.attendees);
        break;
      }
      case START_REGISTER: {
        this.nextRegisterAttendeeId = action.attendeeId;
        this.emit(action.type, this.nextRegisterAttendeeId);
        break;
      }
      case REGISTER: {
        this.emit(action.type, action.serial);
        if (this.nextRegisterAttendeeId > 0) {
          RegistrarChannel.perform(
            'register',
            {
              attendeeId: this.nextRegisterAttendeeId,
              serial: action.serial,
            },
          );
        }
        break;
      }
      case REGISTER_SUCCESS: {
        this.nextRegisterAttendeeId = 0;
        this.update(action.attendee.id, new Attendee(action.attendee));
        this.emit(action.type, this.attendees);
        break;
      }
      case REGISTER_UPDATE: {
        const attendee = new Attendee(action.attendee);
        this.update(attendee.id, attendee);
        if (this.nextRegisterAttendeeId === attendee.id) {
          this.nextRegisterAttendeeId = 0;
        }
        this.emit(action.type, this.attendees, this.nextRegisterAttendeeId);
        break;
      }
      case CANCEL_REGISTER: {
        this.nextRegisterAttendeeId = 0;
        break;
      }
      default: {
        break;
      }
    }
  }

  off() {
    this.removeAllListeners(RECEIVE_ATTENDEES);
    this.removeAllListeners(START_REGISTER);
    this.removeAllListeners(REGISTER);
    this.removeAllListeners(REGISTER_SUCCESS);
    this.removeAllListeners(REGISTER_UPDATE);
    this.removeAllListeners(CANCEL_REGISTER);
  }
}

const attendees = new AttendeeStore();

export default attendees;
