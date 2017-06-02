import {
  RECEIVE_ACCESS_RECORDS,
} from './constants';

import store from './store';

const ENDPOINTS = {
  accessRecords: eventId => `/events/${eventId}/accesses.json`,
};

export const fetchAccessRecords = (eventId) => {
  $.get(ENDPOINTS.accessRecords(eventId))
   .promise()
   .done((data) => { store.dispatch({ type: RECEIVE_ACCESS_RECORDS, accessRecords: data }); });
};

export default {
  fetchAccessRecords,
};
