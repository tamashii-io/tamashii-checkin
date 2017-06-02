import React from 'react';
import PropTypes from 'prop-types';

import { Modal, Button, ModalHeader, ModalBody, ModalFooter } from 'reactstrap';

import {
  RECEIVE_ACCESS_RECORDS,
  ACCESS_RECORD_UPDATE,
  ACCESS_RECORD_SET,
  REQUEST_ACCESS,
  CANCEL_REQUEST,
} from './constants';
import { fetchAccessRecords } from './actions';
import { AccessesChannel } from '../channels';
import store from './store';

import AccessRecordsTableItem from './access_records_table_item.jsx';

class AccessRecordsTable extends React.Component {
  constructor() {
    super();
    this.state = {
      requestAttendee: null,
      accessRecords: [],
    };

    this.closeModal = this.closeModal.bind(this);
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
    store.on(REQUEST_ACCESS, requestAttendee => this.setState({ requestAttendee }));
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

  hasAccessRequest() {
    return this.state.requestAttendee != null;
  }

  requestAttendeeName() {
    if (this.state.requestAttendee) {
      return this.state.requestAttendee.name;
    }

    return 'Attendee';
  }

  closeModal() {
    this.setState({ requestAttendee: null });
    store.dispatch({ type: CANCEL_REQUEST });
  }

  acceptRequest() {
  }

  rejectRequest() {
  }

  render() {
    return (
      <div>
        <Modal isOpen={this.hasAccessRequest()} toggle={this.closeModal}>
          <ModalHeader toggle={this.closeModal}>Access Request</ModalHeader>
          <ModalBody>
            {this.requestAttendeeName()} is request to access this gate.
          </ModalBody>
          <ModalFooter>
            <Button color="danger" onClick={this.rejectRequest}>Reject</Button>
            <Button color="success" onClick={this.acceptRequest}>Accept</Button>
          </ModalFooter>
        </Modal>
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
