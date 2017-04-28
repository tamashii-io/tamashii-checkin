import React from 'react';
import PropTypes from 'prop-types';

import { Modal, ModalBody } from 'reactstrap';

import {
  RECEIVE_CHECK_RECORDS,
  START_REGISTER,
  CANCEL_REGISTER,
  REGISTER_SUCCESS,
  REGISTER_UPDATE,
} from './constants';
import { fetchCheckRecords } from './actions';
import { CheckrecordsChannel } from '../channels';
import store from './store';

import CheckRecordsTableItem from './check_records_table_item.jsx';

class CheckRecordsTable extends React.Component {
  constructor() {
    super();
    this.state = {
      check_records: [],
      nextRegisterCheckRecordId: 0,
    };

    this.closeModal = this.closeModal.bind(this);
  }

  componentWillMount() {
    fetchCheckRecords(this.props.eventId);
    CheckrecordsChannel.follow({ event_id: this.props.eventId });
  }

  componentDidMount() {
    store.on(RECEIVE_CHECK_RECORDS, check_records => this.setState({ check_records }));
    store.on(START_REGISTER, check_recordId => this.setState({ nextRegisterCheckRecordId: check_recordId }));
    store.on(
      REGISTER_UPDATE,
      (check_records, nextId) => this.setState({ check_records, nextRegisterCheckRecordId: nextId }),
    );
    store.on(
      REGISTER_SUCCESS,
      check_records => this.setState({ check_records, nextRegisterCheckRecordId: 0 }),
    );
  }

  componentWillUnmount() {
    CheckrecordsChannel.unfollow();
    store.off();
  }

  check_records() {
    const check_records = this.state.check_records;
    console.log("Hello~~~~~World!!!");
    console.log(check_records);
    return check_records.map(check_record => <CheckRecordsTableItem key={check_record.id} check_record={check_record} />);
  }

  hasNextCheckRecord() {
    return this.state.nextRegisterCheckRecordId > 0;
  }

  closeModal() {
    this.setState({ nextRegisterCheckRecordId: 0 });
    store.dispatch({ type: CANCEL_REGISTER });
  }

  render() {
    return (
      <div>
        <Modal isOpen={this.hasNextCheckRecord()} toggle={this.closeModal}>
          <ModalBody>Please scan your RFID card to check-in</ModalBody>
        </Modal>
        <table className="table table-bordered table-striped table-condensed">
          <thead>
            <tr>
              <th>會眾1</th>
              <th>打卡點</th>
              <th>次數</th>
              <th>時間</th>
            </tr>
          </thead>
          <tbody>
            { this.check_records() }
          </tbody>
        </table>
      </div>
    );
  }
}

CheckRecordsTable.propTypes = {
  eventId: PropTypes.string.isRequired,
};

export default CheckRecordsTable;
