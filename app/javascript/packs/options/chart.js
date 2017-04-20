export default {};

export const LineFullWidth = {
  maintainAspectRatio: false,
  legend: {
    display: false,
  },
  scales: {
    xAxes: [{
      display: false,
    }],
    yAxes: [{
      display: false,
    }],
  },
  elements: {
    line: {
      borderWidth: 2,
    },
    point: {
      radius: 0,
      hitRadius: 10,
      hoverRadius: 4,
    },
  },
};
