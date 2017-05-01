import React from 'react';
import PropTypes from 'prop-types';

import { Modal, ModalBody } from 'reactstrap';

import {
  RECEIVE_CHECK_RECORDS,
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
    };
  }

  componentWillMount() {
    fetchCheckRecords(this.props.eventId);
    CheckrecordsChannel.follow({ event_id: this.props.eventId });
  }

  componentDidMount() {
    store.on(RECEIVE_CHECK_RECORDS, check_records => this.setState({ check_records }));
    store.on(
      REGISTER_UPDATE,
      (check_records, nextId) => this.setState({ check_records }),
    );

  }

  componentWillUnmount() {
    CheckrecordsChannel.unfollow();
    store.off();
  }

  check_records() {
    const check_records = this.state.check_records;
    return check_records.map(check_record => <CheckRecordsTableItem key={check_record.id} check_record={check_record} />);
  }

  render() {
    return (
      <div>
        <table className="table table-bordered table-striped table-condensed">
          <thead>
            <tr>
              <th>會眾5</th>
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
