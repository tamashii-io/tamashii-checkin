import {
  RECEIVE_ATTENDEES,
} from './constants';

import store from './store';

const ENDPOINTS = {
  attendees: eventId => `/attendees/summary/?event_id=${eventId}`,
};

export const fetchAttendees = (eventId) => {
  $.get(ENDPOINTS.attendees(eventId))
   .promise()
   .done((data) => { store.dispatch({ type: RECEIVE_ATTENDEES, attendees: data }); });
};

export default {
  fetchAttendees,
};
