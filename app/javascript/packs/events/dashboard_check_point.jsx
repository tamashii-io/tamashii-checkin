import React from 'react';
import PropTypes from 'prop-types';

import DashboardChart from './dashboard_chart.jsx';

const buildDataset = data => [{
  backgroundColor: 'rgba(255, 255, 255, .2)',
  borderColor: 'rgba(255,255,255,.55)',
  data,
}];

const buildChart = chartData => (
  <DashboardChart
    className={'col-md-6'}
    labels={chartData.labels}
    chart={chartData.chart}
    datasets={buildDataset(chartData.data)}
  />
  );

class DashboardCheckPoint extends React.Component {

  item() {
    return (
      <div key={this.props.name} className="row">
        <p className="col-md-12">{this.props.name}</p>
        {buildChart(this.props.summary)}
        {buildChart(this.props.realtime)}
      </div>
    );
  }

  render() {
    return (this.item());
  }
}

DashboardCheckPoint.propTypes = {
  name: PropTypes.string.isRequired,
  summary: PropTypes.shape({}).isRequired,
  realtime: PropTypes.shape({}).isRequired,
};

export default DashboardCheckPoint;
