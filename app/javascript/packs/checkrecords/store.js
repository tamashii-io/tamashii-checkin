import { EventEmitter } from 'events';
import { fromJS, Record } from 'immutable';

import {
  RECEIVE_CHECK_RECORDS,
  REGISTER_UPDATE,
} from './constants';
import { CheckrecordsChannel } from '../channels';

const CheckRecord = Record({
  id: 0,
  attendee_id: '',
  check_point_id: '',
  times: '',
  created_at: '',
  updated_at: '',
  attendee: '',
  check_point: '',
});

const checkRecordsToRecord = checkRecords => checkRecords.map(
  checkRecord => new CheckRecord(checkRecord),
  );


class CheckRecordStore extends EventEmitter {
  constructor() {
    super();
    this.check_records = fromJS([]);
    CheckrecordsChannel.onReceived(action => this.dispatch(action));
  }

  update(checkRecordId, newCheckRecord) {
    const index = this.index(checkRecordId);
    if (index >= 0) {
      this.check_records = this.check_records.set(index, newCheckRecord);
    } else {
      this.check_records = this.check_records.set(this.check_records.size, newCheckRecord);
    }
  }

  index(checkRecordId) {
    return this.check_records.findIndex(checkRecord => checkRecord.id === checkRecordId);
  }

  dispatch(action) {
    switch (action.type) {
      case RECEIVE_CHECK_RECORDS: {
        this.check_records = fromJS(checkRecordsToRecord(action.check_records));
        this.emit(action.type, this.check_records);
        break;
      }
      case REGISTER_UPDATE: {
        const checkRecord = new CheckRecord(action.check_record);
        this.update(checkRecord.id, checkRecord);
        this.emit(action.type, this.check_records);
        break;
      }
      default: {
        break;
      }
    }
  }

  off() {
    this.removeAllListeners(RECEIVE_CHECK_RECORDS);
    this.removeAllListeners(REGISTER_UPDATE);
  }
}

const checkRecords = new CheckRecordStore();

export default checkRecords;
