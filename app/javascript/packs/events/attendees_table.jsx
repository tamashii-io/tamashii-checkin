import React from 'react';
import PropTypes from 'prop-types';

import { Modal, ModalBody } from 'reactstrap';

import {
  RECEIVE_ATTENDEES,
  START_REGISTER,
  CANCEL_REGISTER,
  REGISTER_SUCCESS,
  REGISTER_UPDATE,
  AGAIN_ATTENDEES,
} from './constants';
import { fetchAttendees, fetchAttendeesAgain } from './actions';
import { RegistrarChannel } from '../channels';
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
    RegistrarChannel.follow({ event_id: this.props.eventId });
  }

  componentDidMount() {
    store.on(RECEIVE_ATTENDEES, attendees => this.setState({ attendees }));
    store.on(START_REGISTER, attendeeId => this.setState({ nextRegisterAttendeeId: attendeeId }));
    store.on(
      REGISTER_UPDATE,
      (attendees, nextId) => fetchAttendeesAgain(this.props.eventId),
    );
    store.on(
      REGISTER_SUCCESS,
      attendees => this.setState({ attendees, nextRegisterAttendeeId: 0 }),
    );
    store.on(
      AGAIN_ATTENDEES,
      attendees => this.setState({ attendees }),
    );
  }

  componentWillUnmount() {
    RegistrarChannel.unfollow();
    store.off();
  }

  attendees() {
    const attendees = this.state.attendees;
    return attendees.size;
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
        <span class="pa-2 pull-right">
          <i class="icon-location-pin"></i>
        </span>
        <h4 class="mb-2">{ this.attendees() }</h4>
        <p>Attendees</p>
      </div>
    );
  }
}

AttendeesTable.propTypes = {
  eventId: PropTypes.string.isRequired,
};

export default AttendeesTable;
