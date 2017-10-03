import React from 'react';
import PropTypes from 'prop-types';

import {
  RECEIVE_ATTENDEES,
  REGISTER_UPDATE,
  RECEIVE_CHECK_POINTS,
  POLL_SUMMARY,
  SUMMARY_INTERVAL,
  REALTIME_INTERVAL,
} from './constants';
import {
  fetchAttendees,
  fetchCheckPoints,
} from './actions';
import { EventAttendeesDashboardChannel } from '../channels';
import store from './store';

import DashboardCheckPoint from './dashboard_check_point.jsx';

const updateCheckPointsData = (srcCheckPointsData, summary, timeInterval) => {
  let dataField = 'none';
  switch (timeInterval) {
    case SUMMARY_INTERVAL: {
      dataField = 'summary';
      break;
    }
    case REALTIME_INTERVAL: {
      dataField = 'realtime';
      break;
    }
    default: {
      break;
    }
  }
  if (dataField !== 'none') {
    const checkPointsData = srcCheckPointsData.map((srcCheckPointData) => {
      const checkPointData = srcCheckPointData;
      if (Date.now() - checkPointData[dataField].lastUpdateTime >= timeInterval - 5) {
        checkPointData[dataField].lastUpdateTime = Date.now();
        let count = 0;
        const summaryData = summary[checkPointData.id];
        // if there is no data, the summary[checkPointData.id] will be undefined
        if (summaryData) {
          count = summary[checkPointData.id].count;
        }

        checkPointData[dataField].chart.value = count;

        const data = checkPointData[dataField].data;
        data.shift();
        data.push(count);

        const labels = checkPointData[dataField].labels;
        labels.shift();
        labels.push(new Date().toLocaleTimeString());
      }
      return checkPointData;
    });
    return checkPointsData;
  }

  return srcCheckPointsData;
};

const fetchSummary = (eventId, timeInterval) => {
  EventAttendeesDashboardChannel.perform(
    'update_summary',
    {
      event_id: eventId,
      time_interval: timeInterval,
    },
  );
};

class EventDashboard extends React.Component {
  constructor() {
    super();
    this.state = {
      attendees: {},
      checkPointsData: [],
    };
  }

  componentWillMount() {
    fetchAttendees(this.props.eventId);
    EventAttendeesDashboardChannel.follow({ event_id: this.props.eventId });
  }

  componentDidMount() {
    store.on(RECEIVE_ATTENDEES,
      attendees => this.setState({ attendees }),
    );
    store.on(RECEIVE_CHECK_POINTS,
      (checkPoints) => {
        const checkPointsData = checkPoints.map(checkPoint => ({
          id: checkPoint.id,
          name: checkPoint.name,
          realtime: {
            labels: ['N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A'],
            data: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
            chart: { name: `Realtime (past ${REALTIME_INTERVAL} seconds)`, value: 0, icon: 'icon-location-pin', skin: 'info' },
            lastUpdateTime: 0,
          },
          summary: {
            labels: ['N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A', 'N/A'],
            data: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
            chart: { name: `Summary (past ${SUMMARY_INTERVAL} seconds)`, value: 0, icon: 'icon-settings', skin: 'primary' },
            lastUpdateTime: 0,
          },
        }));
        this.setState(
          { checkPointsData },
        );
      },
    );
    store.on(
      REGISTER_UPDATE, () => fetchAttendees(this.props.eventId),
    );
    store.on(POLL_SUMMARY, (summary, timeInterval) => {
      this.setState({
        checkPointsData: updateCheckPointsData(this.state.checkPointsData, summary, timeInterval),
      });
    });
    this.updateSummaryData();
    this.updateRealtimeData();
    fetchCheckPoints(this.props.eventId);
  }

  componentWillUnmount() {
    EventAttendeesDashboardChannel.unfollow();
    store.off();
    clearTimeout(this.summaryTimer);
    clearTimeout(this.realtimeTimer);
  }

  updateSummaryData() {
    fetchSummary(this.props.eventId, SUMMARY_INTERVAL);
    this.summaryTimer = setTimeout(() => { this.updateSummaryData(); }, SUMMARY_INTERVAL * 1000);
  }

  updateRealtimeData() {
    fetchSummary(this.props.eventId, REALTIME_INTERVAL);
    this.realtimeTimer = setTimeout(() => { this.updateRealtimeData(); }, REALTIME_INTERVAL * 1000);
  }

  buildCharts() {
    const { checkPointsData } = this.state;
    return checkPointsData.map(
      checkPointData => (
        <DashboardCheckPoint
          name={checkPointData.name}
          summary={checkPointData.summary}
          realtime={checkPointData.realtime}
          key={checkPointData.name}
        />
      ),
    );
  }

  render() {
    return (
      <div>
        <p>Total attendees: {this.state.attendees.attendees}</p>
        <p>Checked-in attendees: {this.state.attendees.checkin}</p>
        <hr />
        { this.buildCharts() }
      </div>
    );
  }
}

EventDashboard.propTypes = {
  eventId: PropTypes.string.isRequired,
};

export default EventDashboard;
