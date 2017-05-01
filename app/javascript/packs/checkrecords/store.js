import { EventEmitter } from 'events';
import { fromJS, Record } from 'immutable';

import {
  RECEIVE_CHECK_RECORDS,
  REGISTER,
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

const check_recordsToRecord = check_records => check_records.map(check_record => new CheckRecord(check_record));

class CheckRecordStore extends EventEmitter {
  constructor() {
    super();
    this.check_records = fromJS([]);
    this.nextRegisterCheckRecordId = 0;
    CheckrecordsChannel.onReceived(action => this.dispatch(action));
  }

  update(check_recordId, newCheckRecord) {
    const index = this.index(check_recordId);
    if (index >= 0) {
      this.check_records = this.check_records.set(index, newCheckRecord);
    }else{
      this.check_records = this.check_records.set(this.check_records.size , newCheckRecord);
    }
  }

  index(check_recordId) {
    return this.check_records.findIndex(check_record => check_record.id === check_recordId);
  }

  dispatch(action) {
    switch (action.type) {
      case RECEIVE_CHECK_RECORDS: {
        this.check_records = fromJS(check_recordsToRecord(action.check_records));
        this.emit(action.type, this.check_records);
        break;
      }
      case REGISTER: {
        if (this.nextRegisterCheckRecordId > 0) {
          CheckrecordsChannel.perform(
            'register',
            {
              check_recordId: this.nextRegisterCheckRecordId,
              serial: action.serial,
            },
          );
        }
        break;
      }
      case REGISTER_UPDATE: {
        const check_record = new CheckRecord(action.check_record);
        this.update(check_record.id, check_record);
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
    this.removeAllListeners(REGISTER);
    this.removeAllListeners(REGISTER_UPDATE);
  }
}

const check_records = new CheckRecordStore();

export default check_records;
