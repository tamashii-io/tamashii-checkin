import React from 'react';
import PropTypes from 'prop-types';
import ChartJS from 'chart.js';

export default class Chart extends React.Component {
  constructor() {
    super();
    this.context = null;
    this.chart = null;
  }

  componentDidMount() {
    this.createChart();
  }

  componentWillReceiveProps(nextProps) {
    this.chart.data.labels = nextProps.labels;
    this.chart.data.datasets = nextProps.datasets;
    this.chart.update();
  }

  componentWiiUnmount() {
    this.chart.destroy();
  }

  createChart() {
    this.chart = new ChartJS(
      this.context,
      {
        type: this.props.type,
        data: this.buildData(),
        options: this.props.options,
      },
    );
  }

  buildData() {
    return {
      labels: this.props.labels,
      datasets: this.props.datasets,
    };
  }

  render() {
    return (<canvas
      height={this.props.height}
      ref={(el) => { this.context = el; }}
      className="chartjs-render-monitor"
    />);
  }
}

Chart.defaultProps = {
  height: 227,
  options: {},
};

Chart.propTypes = {
  height: PropTypes.number,
  options: PropTypes.shape({}),
  datasets: PropTypes.arrayOf(PropTypes.object).isRequired,
  labels: PropTypes.arrayOf(
    PropTypes.oneOfType([PropTypes.number, PropTypes.string]),
  ).isRequired,
  type: PropTypes.string.isRequired,
};
