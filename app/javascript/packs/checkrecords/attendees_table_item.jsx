import React from 'react';
import PropTypes from 'prop-types';

import { startRegister } from './actions';


class AttendeesTableItem extends React.Component {
  registerAttendee() {
    const attendee = this.props.attendee;
    startRegister(attendee.id);
  }

  renderCardSerial(value) {
    if (value.length > 0) {
      return value;
    }

    const onClick = (ev) => {
      ev.preventDefault();
      this.registerAttendee();
    };

    return (
      <a href="" onClick={onClick} className="btn btn-success">報到</a>
    );
  }

  render() {
    const find_attendee_name = (attendee_id) => (attendee_id);

    const attendee = this.props.attendee;
    console.log(attendee);
    return (
      <tr>
        <td>{find_attendee_name(attendee.attendee_id)} </td>
        <td>{attendee.check_point_id}</td>
        <td>{attendee.times}</td>
        <td>{attendee.updated_at}</td>
      </tr>
    );
  }
}

AttendeesTableItem.propTypes = {
  attendee: PropTypes.shape({}).isRequired,
};

export default AttendeesTableItem;
