import React from 'react';
import PropTypes from 'prop-types';

import {
  RECEIVE_ACCESS_RECORDS,
  ACCESS_RECORD_UPDATE,
  ACCESS_RECORD_SET,
} from './constants';
import { fetchAccessRecords } from './actions';
import { AccessesChannel } from '../channels';
import store from './store';

import AccessRecordsTableItem from './access_records_table_item.jsx';

class AccessRecordsTable extends React.Component {
  constructor() {
    super();
    this.state = {
      accessRecords: [],
    };
  }

  componentWillMount() {
    fetchAccessRecords(this.props.eventId);
    AccessesChannel.follow({ check_point_id: this.props.checkPointId });
  }

  componentDidMount() {
    store.on(RECEIVE_ACCESS_RECORDS, accessRecords => this.setState({ accessRecords }));
    store.on(
      ACCESS_RECORD_UPDATE,
      accessRecords => this.setState({ accessRecords }),
    );
    store.on(
      ACCESS_RECORD_SET,
      accessRecords => this.setState({ accessRecords }),
    );
  }

  componentWillUnmount() {
    AccessesChannel.unfollow();
    store.off();
  }

  records() {
    const records = this.state.accessRecords;
    return records.map(
      record => <AccessRecordsTableItem key={record.id} record={record} />,
    );
  }

  render() {
    return (
      <div>
        <table className="table table-bordered table-striped table-condensed">
          <thead>
            <tr>
              <th>會眾</th>
              <th>次數</th>
              <th>時間</th>
            </tr>
          </thead>
          <tbody>
            { this.records() }
          </tbody>
        </table>
      </div>
    );
  }
}

AccessRecordsTable.propTypes = {
  checkPointId: PropTypes.string.isRequired,
  eventId: PropTypes.string.isRequired,
};

export default AccessRecordsTable;
