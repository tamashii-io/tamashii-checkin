import React from 'react';
import PropTypes from 'prop-types';



class CheckRecordsTableItem extends React.Component {
  render() {
    const find_check_record_name = (attendee_id) => (attendee_id);
    const check_record = this.props.check_record;
    return (
      <tr>
        <td>{find_check_record_name(check_record.id)} </td>
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
