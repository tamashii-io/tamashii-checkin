import {
  RECEIVE_ATTENDEES,
} from './constants';

import store from './store';

const ENDPOINTS = {
  attendees: eventId => `/api/v1/events/${eventId}/attendees/summary`,
};

export const fetchAttendees = (eventId) => {
  $.get(ENDPOINTS.attendees(eventId))
   .promise()
   .done((data) => { store.dispatch({ type: RECEIVE_ATTENDEES, attendees: data }); });
};

export default {
  fetchAttendees,
};
