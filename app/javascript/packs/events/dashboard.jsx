import React from 'react';

import InverseCardChart from '../components/inverse_card_chart.jsx';
import { LineFullWidth } from '../options/chart';

// TODO: Use real-time data
const labels = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15];

const Charts = [
  { name: 'Attendees', value: 0, icon: 'icon-settings', skin: 'primary' },
  { name: 'New Register', value: 0, icon: 'icon-location-pin', skin: 'info' },
  { name: 'Members online', value: 0, icon: 'icon-user', skin: 'success' },
  { name: 'Active members', value: 0, icon: 'icon-layers', skin: 'warning' },
];

const buildCharts = datasets => (
  Charts.map(
    chart => (
      <div key={chart.name} className="col-sm-6 col-lg-3">
        <InverseCardChart
          label={chart.name}
          value={chart.value}
          labels={labels}
          datasets={datasets}
          icon={chart.icon}
          skin={chart.skin}
          options={Object.assign({}, LineFullWidth, { animation: false })}
          fullWidth
        />
      </div>
    ),
  )
);

class Dashboard extends React.Component {
  constructor() {
    super();
    this.state = { data: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0] };
  }

  componentDidMount() {
    this.timer = setTimeout(() => { this.updateData(); }, 500);
  }

  componentWillUnmount() {
    clearTimeout(this.timer);
  }

  // TODO: Use real-time data
  updateData() {
    const data = this.state.data;
    data.shift();
    data.push(Math.floor(Math.random() * 100));
    this.setState({ data });
    this.timer = setTimeout(() => { this.updateData(); }, 1000);
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
        { buildCharts(this.buildDatasets()) }
      </div>
    );
  }
}

export default Dashboard;
