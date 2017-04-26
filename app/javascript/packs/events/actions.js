import {
  RECEIVE_ATTENDEES,
  START_REGISTER,
  AGAIN_ATTENDEES,
} from './constants';

import store from './store';

const ENDPOINTS = {
  attendees: eventId => `/events/${eventId}/attendees.json`,
};

export const fetchAttendees = (eventId) => {
  $.get(ENDPOINTS.attendees(eventId))
   .promise()
   .done((data) => { store.dispatch({ type: RECEIVE_ATTENDEES, attendees: data }); });
};

export const startRegister = (attendeeId) => {
  store.dispatch({ type: START_REGISTER, attendeeId });
};

export const fetchAttendeesAgain = (eventId) => {
  $.get(ENDPOINTS.attendees(eventId))
   .promise()
   .done((data) => { store.dispatch({ type: AGAIN_ATTENDEES, attendees: data }); });
};

export default {
  fetchAttendees,
  startRegister,
  fetchAttendeesAgain,
};
