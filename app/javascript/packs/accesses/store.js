import { EventEmitter } from 'events';
import { fromJS, Record } from 'immutable';

import {
  RECEIVE_ACCESS_RECORDS,
  ACCESS_RECORD_UPDATE,
  ACCESS_RECORD_SET,
  REQUEST_ACCESS,
  ACCESS_UPDATE,
  CANCEL_REQUEST,
} from './constants';
import { AccessesChannel } from '../channels';

const AccessRecord = Record({
  id: 0,
  attendee_id: '',
  check_point_id: '',
  times: '',
  created_at: '',
  updated_at: '',
  attendee: '',
  check_point: '',
});

const Attendee = Record({
  id: 0,
  name: '',
});

const accessRecordsToRecord = records => records.map(
  record => new AccessRecord(record),
);


class AccessRecordStore extends EventEmitter {
  constructor() {
    super();
    this.accessRecords = fromJS([]);
    this.requestAttendee = null;
    AccessesChannel.onReceived(action => this.dispatch(action));
  }

  update(recordId, newRecord) {
    const index = this.index(recordId);
    if (index >= 0) {
      this.accessRecords = this.accessRecords.set(index, newRecord);
    }
  }

  index(recordId) {
    return this.accessRecords.findIndex(record => record.id === recordId);
  }

  dispatch(action) {
    switch (action.type) {
      case RECEIVE_ACCESS_RECORDS: {
        this.accessRecords = fromJS(accessRecordsToRecord(action.accessRecords));
        this.emit(action.type, this.accessRecords);
        break;
      }
      case ACCESS_RECORD_UPDATE: {
        const record = new AccessRecord(action.record);
        this.update(record.id, record);
        this.emit(action.type, this.accessRecords);
        break;
      }
      case ACCESS_RECORD_SET: {
        const record = new AccessRecord(action.record);
        this.accessRecords = this.accessRecords.push(record);
        this.emit(action.type, this.accessRecords);
        break;
      }
      case REQUEST_ACCESS: {
        this.requestAttendee = new Attendee(action.record);
        this.emit(action.type, this.requestAttendee);
        break;
      }
      case ACCESS_UPDATE: {
        this.requestAttendee = null;
        this.emit(action.type);
        break;
      }
      case CANCEL_REQUEST: {
        this.requestAttendeeId = null;
        break;
      }
      default: {
        break;
      }
    }
  }

  off() {
    this.removeAllListeners(RECEIVE_ACCESS_RECORDS);
    this.removeAllListeners(ACCESS_RECORD_UPDATE);
    this.removeAllListeners(ACCESS_RECORD_SET);
  }
}

const accessRecords = new AccessRecordStore();

export default accessRecords;
