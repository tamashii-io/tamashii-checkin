import React from 'react';
import PropTypes from 'prop-types';

import {
  RECEIVE_ATTENDEES,
  REGISTER_UPDATE,
  AGAIN_ATTENDEES,
} from './constants';
import { fetchAttendees, fetchAttendeesAgain } from './actions';
import { RegistrarChannel } from '../channels';
import store from './store';

import DashboardItem from './dashboard_item.jsx';

class EventDashboard extends React.Component {
  constructor() {
    super();
    this.state = {
      attendees: [],
      Charts: [
        { name: 'Attendees', value: 0, icon: 'icon-settings', skin: 'primary' },
        { name: 'New Register', value: 0, icon: 'icon-location-pin', skin: 'info' },
        { name: 'Members online', value: 0, icon: 'icon-user', skin: 'success' },
        { name: 'Active members', value: 0, icon: 'icon-layers', skin: 'warning' },
      ],
      // TODO: Use real-time data
      labels: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15],
      data: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    };
  }

  componentWillMount() {
    fetchAttendees(this.props.eventId);
    RegistrarChannel.follow({ event_id: this.props.eventId });
  }

  componentDidMount() {
    const { Charts } = this.state;
    store.on(RECEIVE_ATTENDEES, attendees => this.setState({ attendees, Charts: this._attendees(Charts, attendees) }));
    store.on(
      REGISTER_UPDATE,
      (attendees, nextId) => fetchAttendeesAgain(this.props.eventId),
    );
    store.on(
      AGAIN_ATTENDEES,
      attendees => this.setState({ attendees, Charts: this._attendees(Charts, attendees) }),
    );
    this.timer = setTimeout(() => { this.updateData(); }, 500);
  }

  componentWillUnmount() {
    RegistrarChannel.unfollow();
    store.off();
    clearTimeout(this.timer);
  }

  _attendees(Charts, attendees) {
    Charts[0].value = attendees.size;
    Charts[1].value = attendees.filter(attendee => attendee.card_serial !== "").size; 
    return Charts;
  }
  // TODO: Use real-time data
  updateData() {
    const data = this.state.data;
    data.shift();
    data.push(Math.floor(Math.random() * 100));
    this.setState({ data });
    this.timer = setTimeout(() => { this.updateData(); }, 1000);
  }

  buildCharts(datasets) {
    const { Charts, labels} = this.state
    return Charts.map(
      chart => ( 
        <DashboardItem className = { "col-sm-6 col-lg-3" } labels = {labels} chart = {chart} datasets = {datasets}/> 
      ),
    )
  }

  buildDatasets() {
    return [{
      backgroundColor: 'rgba(255, 255, 255, .2)',
      borderColor: 'rgba(255,255,255,.55)',
      data: this.state.data,
    }];
  }

  render() {
    return (
      <div className="row">
        { this.buildCharts(this.buildDatasets()) }
      </div>
    );
  }
}

EventDashboard.propTypes = {
  eventId: PropTypes.string.isRequired,
};

export default EventDashboard;
