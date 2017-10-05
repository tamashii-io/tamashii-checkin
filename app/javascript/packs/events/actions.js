import {
  RECEIVE_ATTENDEES,
  RECEIVE_CHECK_POINTS,
} from './constants';

import store from './store';

const ENDPOINTS = {
  attendees: eventId => `/api/v1/events/${eventId}/attendees/summary`,
  check_points: eventId => `/api/v1/events/${eventId}/check_points`,
};

export const fetchAttendeesFromApi = (eventId, eventApiToken) => {
  $.ajax({
    url: ENDPOINTS.attendees(eventId),
    type: 'GET',
    headers: {
      Authorization: `Bearer ${eventApiToken}`,
    },
  })
   .promise()
   .done((data) => { store.dispatch({ type: RECEIVE_ATTENDEES, attendees: data }); });
};


export const fetchCheckPointsFromApi = (eventId, eventApiToken) => {
  $.ajax({
    url: ENDPOINTS.check_points(eventId),
    type: 'GET',
    headers: {
      Authorization: `Bearer ${eventApiToken}`,
    },
  })
   .promise()
   .done((data) => { store.dispatch({ type: RECEIVE_CHECK_POINTS, check_points: data }); });
};

export default {
  fetchAttendeesFromApi,
  fetchCheckPointsFromApi,
};
