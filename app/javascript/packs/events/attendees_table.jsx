import React from 'react';
import PropTypes from 'prop-types';

import {
  RECEIVE_ATTENDEES,
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
    };
  }

  componentWillMount() {
    fetchAttendees(this.props.eventId);
    RegistrarChannel.follow({ event_id: this.props.eventId });
  }

  componentDidMount() {
    store.on(RECEIVE_ATTENDEES, attendees => this.setState({ attendees }));
    store.on(
      REGISTER_UPDATE,
      (attendees, nextId) => fetchAttendeesAgain(this.props.eventId),
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
    const checkin = attendees.filter(attendee => attendee.card_serial !== "");
    return attendees.size+ "/" + checkin.size;
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
