import React from 'react';
import PropTypes from 'prop-types';

import InverseCardChart from '../components/inverse_card_chart.jsx';
import { LineFullWidth } from '../options/chart';

class DashboardItem extends React.Component {
  item() {
    const { className, labels, chart, datasets } = this.props;

    return (
      <div key={chart.name} className={className}>
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
    );
  }
  render() {
    return (this.item());
  }
}

DashboardItem.propTypes = {
  className: PropTypes.string.isRequired,
  labels: PropTypes.node.isRequired,
  chart: PropTypes.shape({}).isRequired,
  datasets: PropTypes.shape({}).isRequired,
};

export default DashboardItem;
