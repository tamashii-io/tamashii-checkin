import React from 'react';
import PropTypes from 'prop-types';
import moment from 'moment';

const formatLastActive = date => (date ? moment(date).calendar() : '');

const AccessRecordsTableItem = ({ record }) => (
  <tr>
    <td>{record.attendee.name} </td>
    <td>{record.times}</td>
    <td>{formatLastActive(record.updated_at)}</td>
  </tr>
);

AccessRecordsTableItem.propTypes = {
  record: PropTypes.shape({}).isRequired,
};

export default AccessRecordsTableItem;
