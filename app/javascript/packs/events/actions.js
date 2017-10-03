import {
  RECEIVE_ATTENDEES,
  RECEIVE_CHECK_POINTS,
} from './constants';

import store from './store';

const ENDPOINTS = {
  attendees: eventId => `/api/v1/events/${eventId}/attendees/summary`,
  check_points: eventId => `/api/v1/events/${eventId}/check_points`,
};

export const fetchAttendees = (eventId) => {
  $.get(ENDPOINTS.attendees(eventId))
   .promise()
   .done((data) => { store.dispatch({ type: RECEIVE_ATTENDEES, attendees: data }); });
};


export const fetchCheckPoints = (eventId) => {
  $.get(ENDPOINTS.check_points(eventId))
   .promise()
   .done((data) => { store.dispatch({ type: RECEIVE_CHECK_POINTS, check_points: data }); });
};

export default {
  fetchAttendees,
  fetchCheckPoints,
};
