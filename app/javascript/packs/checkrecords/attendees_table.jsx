import React from 'react';
import PropTypes from 'prop-types';

import { Modal, ModalBody } from 'reactstrap';

import {
  RECEIVE_ATTENDEES,
  START_REGISTER,
  CANCEL_REGISTER,
  REGISTER_SUCCESS,
  REGISTER_UPDATE,
} from './constants';
import { fetchAttendees } from './actions';
import { CheckrecordsChannel } from '../channels';
import store from './store';

import AttendeesTableItem from './attendees_table_item.jsx';

class AttendeesTable extends React.Component {
  constructor() {
    super();
    this.state = {
      attendees: [],
      nextRegisterAttendeeId: 0,
    };

    this.closeModal = this.closeModal.bind(this);
  }

  componentWillMount() {
    fetchAttendees(this.props.eventId);
    CheckrecordsChannel.follow({ event_id: this.props.eventId });
  }

  componentDidMount() {
    store.on(RECEIVE_ATTENDEES, attendees => this.setState({ attendees }));
    store.on(START_REGISTER, attendeeId => this.setState({ nextRegisterAttendeeId: attendeeId }));
    store.on(
      REGISTER_UPDATE,
      (attendees, nextId) => this.setState({ attendees, nextRegisterAttendeeId: nextId }),
    );
    store.on(
      REGISTER_SUCCESS,
      attendees => this.setState({ attendees, nextRegisterAttendeeId: 0 }),
    );
  }

  componentWillUnmount() {
    CheckrecordsChannel.unfollow();
    store.off();
  }

  attendees() {
    const attendees = this.state.attendees;
    console.log("Hello~~~~~World!!!");
    console.log(attendees);
    return attendees.map(attendee => <AttendeesTableItem key={attendee.id} attendee={attendee} />);
  }

  hasNextAttendee() {
    return this.state.nextRegisterAttendeeId > 0;
  }

  closeModal() {
    this.setState({ nextRegisterAttendeeId: 0 });
    store.dispatch({ type: CANCEL_REGISTER });
  }

  render() {
    return (
      <div>
        <Modal isOpen={this.hasNextAttendee()} toggle={this.closeModal}>
          <ModalBody>Please scan your RFID card to check-in</ModalBody>
        </Modal>
        <table className="table table-bordered table-striped table-condensed">
          <thead>
            <tr>
              <th>會眾3</th>
              <th>打卡點</th>
              <th>次數</th>
              <th>時間</th>
            </tr>
          </thead>
          <tbody>
            { this.attendees() }
          </tbody>
        </table>
      </div>
    );
  }
}

AttendeesTable.propTypes = {
  eventId: PropTypes.string.isRequired,
};

export default AttendeesTable;
