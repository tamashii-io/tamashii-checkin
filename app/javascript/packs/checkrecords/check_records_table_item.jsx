import React from 'react';
import PropTypes from 'prop-types';
import moment from 'moment';

class CheckRecordsTableItem extends React.Component {
  render() {
    const formatLastActive = date => (date ? moment(date).calendar() : '');
    const check_record = this.props.check_record;
    return (
      <tr>
        <td>{check_record.attendee.name} </td>
        <td>{check_record.check_point.name}</td>
        <td>{check_record.times}</td>
        <td>{formatLastActive(check_record.updated_at)}</td>
      </tr>
    );
  }
}

CheckRecordsTableItem.propTypes = {
  check_record: PropTypes.shape({}).isRequired,
};

export default CheckRecordsTableItem;
