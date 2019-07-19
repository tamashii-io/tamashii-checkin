import React from 'react';
import PropTypes from 'prop-types';

import InverseCard from './inverse_card.jsx';
import Chart from './chart.jsx';

const chartWrapperClass = isFull => (isFull ? 'chart-wrapper' : 'chart-wrapper px-3');

const InverseCardChart = ({
  datasets,
  options,
  labels,
  type,
  skin,
  icon,
  label,
  value,
  fullWidth,
}) => (
  <InverseCard skin={skin}>
    <div className="card-body pb-2">
      <span className="pa-2 pull-right">
        <i className={icon} />
      </span>
      <h4 className="mb-2">{value}</h4>
      <p>{label}</p>
      <div className={chartWrapperClass(fullWidth)} style={{ height: '227px' }}>
        <Chart
          datasets={datasets}
          options={options}
          labels={labels}
          type={type}
        />
      </div>
    </div>
  </InverseCard>
);

InverseCardChart.defaultProps = {
  skin: 'primary',
  icon: '',
  fullWidth: false,
  type: 'line',
  options: {},
};

InverseCardChart.propTypes = {
  skin: PropTypes.string,
  icon: PropTypes.string,
  fullWidth: PropTypes.bool,
  label: PropTypes.string.isRequired,
  value: PropTypes.number.isRequired,
  type: PropTypes.oneOf(['line']),
  datasets: PropTypes.arrayOf(PropTypes.object).isRequired,
  options: PropTypes.shape({}),
  labels: PropTypes.arrayOf(
    PropTypes.oneOfType([PropTypes.string, PropTypes.number]),
  ).isRequired,
};

export default InverseCardChart;
