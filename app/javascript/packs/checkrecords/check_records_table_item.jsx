import React from 'react';
import PropTypes from 'prop-types';
import moment from 'moment';

class CheckRecordsTableItem extends React.Component {
  render() {
    const formatLastActive = date => (date ? moment(date).calendar() : '');
    const checkRecord = this.props.check_record;
    return (
      <tr>
        <td>{checkRecord.attendee.name} </td>
        <td>{checkRecord.check_point.name}</td>
        <td>{checkRecord.times}</td>
        <td>{formatLastActive(checkRecord.updated_at)}</td>
      </tr>
    );
  }
}

CheckRecordsTableItem.propTypes = {
  checkRecord: PropTypes.shape({}).isRequired,
};

export default CheckRecordsTableItem;
