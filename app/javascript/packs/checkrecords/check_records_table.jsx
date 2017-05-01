import React from 'react';
import PropTypes from 'prop-types';
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
      check_records => this.setState({ check_records }),
    );
  }

  componentWillUnmount() {
    CheckrecordsChannel.unfollow();
    store.off();
  }

  checkRecords() {
    const checkRecords = this.state.check_records;
    return checkRecords.map(checkRecord => <CheckRecordsTableItem key={checkRecord.id} checkRecord={checkRecord} />);
  }

  render() {
    return (
      <div>
        <table className="table table-bordered table-striped table-condensed">
          <thead>
            <tr>
              <th>會眾9</th>
              <th>打卡點</th>
              <th>次數</th>
              <th>時間</th>
            </tr>
          </thead>
          <tbody>
            { this.checkRecords() }
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
