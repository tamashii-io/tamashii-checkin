import {
  RECEIVE_ACCESS_RECORDS,
  ACCESS_UPDATE,
} from './constants';

import store from './store';

const ENDPOINTS = {
  accessRecords: eventId => `/events/${eventId}/accesses.json`,
  setAttendeeAccess: eventId => `/api/v1/events/${eventId}/accesses`,
};

export const fetchAccessRecords = (eventId) => {
  $.get(ENDPOINTS.accessRecords(eventId))
   .promise()
   .done((data) => { store.dispatch({ type: RECEIVE_ACCESS_RECORDS, accessRecords: data }); });
};

export const setAttendeeAccess = (eventId, eventApiToken, checkPointId, attendeeId, isAccept) => {
  $.ajax({
    url: ENDPOINTS.setAttendeeAccess(eventId),
    type: 'POST',
    headers: {
      Authorization: `Bearer ${eventApiToken}`,
    },
    data: { event_id: eventId,
      check_point_id: checkPointId,
      attendee_id: attendeeId,
      accept: isAccept,
    },
  })
   .promise()
   .done(() => { store.dispatch({ type: ACCESS_UPDATE }); });
};

export default {
  fetchAccessRecords,
  setAttendeeAccess,
};
