import React from 'react';
import PropTypes from 'prop-types';

import { startRegister } from './actions';


class CheckRecordsTableItem extends React.Component {
  registerCheckRecord() {
    const check_record = this.props.check_record;
    startRegister(check_record.id);
  }

  renderCardSerial(value) {
    if (value.length > 0) {
      return value;
    }

    const onClick = (ev) => {
      ev.preventDefault();
      this.registerCheckRecord();
    };

    return (
      <a href="" onClick={onClick} className="btn btn-success">報到</a>
    );
  }

  render() {
    const find_check_record_name = (attendee_id) => (attendee_id);

    const check_record = this.props.check_record;
    console.log(check_record);
    return (
      <tr>
        <td>{find_check_record_name(check_record.attendee_id)} </td>
        <td>{check_record.check_point_id}</td>
        <td>{check_record.times}</td>
        <td>{check_record.updated_at}</td>
      </tr>
    );
  }
}

CheckRecordsTableItem.propTypes = {
  check_record: PropTypes.shape({}).isRequired,
};

export default CheckRecordsTableItem;
