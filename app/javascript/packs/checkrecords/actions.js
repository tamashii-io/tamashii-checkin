import {
  RECEIVE_CHECK_RECORDS,
  START_REGISTER,
} from './constants';

import store from './store';

const ENDPOINTS = {
  check_records: eventId => `/events/${eventId}/check_records.json`,
};

export const fetchCheckRecords = (eventId) => {
  $.get(ENDPOINTS.check_records(eventId))
   .promise()
   .done((data) => { store.dispatch({ type: RECEIVE_CHECK_RECORDS, check_records: data }); });
};

export const startRegister = (check_recordId) => {
  store.dispatch({ type: START_REGISTER, check_recordId });
};

export default {
  fetchCheckRecords,
  startRegister,
};
