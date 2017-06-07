import React from 'react';
import PropTypes from 'prop-types';
import moment from 'moment';

const formatLastActive = date => (date ? moment(date).calendar() : '');

const CheckRecordsTableItem = ({ checkRecord }) => (
  <tr>
    <td>{checkRecord.attendee.name} </td>
    <td>{checkRecord.check_point.name}</td>
    <td>{checkRecord.times}</td>
    <td>{formatLastActive(checkRecord.updated_at)}</td>
  </tr>
);

CheckRecordsTableItem.propTypes = {
  checkRecord: PropTypes.shape({}).isRequired,
};

export default CheckRecordsTableItem;
