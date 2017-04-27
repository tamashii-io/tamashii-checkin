/* eslint no-console:0 */
// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
//
// To reference this file, add <%= javascript_pack_tag 'application' %> to the appropriate
// layout file, like app/views/layouts/application.html.erb

import Mounter from './helpers/mounter.jsx';
import EventDashboard from './events/dashboard.jsx';
import MachinesTable from './machines/machines_table.jsx';
import AttendeesTable from './attendees/attendees_table.jsx';
import EventAttendeeDashboard from './events/event_dashboard.jsx';

const modules = [
  new Mounter('#machines', MachinesTable),
  new Mounter('#event', EventDashboard),
  new Mounter('#attendees', AttendeesTable),
  new Mounter('#eventAttendee', EventAttendeeDashboard),
];

document.addEventListener('turbolinks:before-cache', () => {
  modules.forEach(module => module.unmount());
});

document.addEventListener('turbolinks:load', () => {
  modules.forEach(module => module.mount());
});
