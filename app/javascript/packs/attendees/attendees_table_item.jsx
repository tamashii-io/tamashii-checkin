import React from 'react';
import PropTypes from 'prop-types';

import { startRegister } from './actions';

class AttendeesTableItem extends React.Component {
  registerAttendee() {
    const attendee = this.props.attendee;
    startRegister(attendee.id);
  }

  unbindButton() {
    const attendee = this.props.attendee;

    if (!attendee.card_serial || attendee.card_serial.length <= 0) {
      return null;
    }

    return (
      <a
        href={attendee.links.unbind}
        className="btn btn-secondary"
        data-method="post"
        data-remote="true"
      >解除</a>
    );
  }

  renderCardSerial(value) {
    if (value && value.length > 0) {
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
    const attendee = this.props.attendee;

    return (
      <tr>
        <td>{attendee.serial}</td>
        <td>{attendee.code}</td>
        <td>{attendee.name}</td>
        <td>{attendee.email}</td>
        <td>{attendee.phone}</td>
        <td>{this.renderCardSerial(attendee.card_serial)}</td>
        <td>
          <a href={attendee.links.edit} className="btn btn-primary">編輯</a>
          <a
            href={attendee.links.self}
            className="btn btn-danger"
            data-method="delete"
            data-confirm="Are you sure?"
          >刪除</a>
          { this.unbindButton() }
        </td>
      </tr>
    );
  }
}

AttendeesTableItem.propTypes = {
  attendee: PropTypes.shape({}).isRequired,
};

export default AttendeesTableItem;
