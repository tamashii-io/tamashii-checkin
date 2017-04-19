// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
// TODO: Move everythings to javascript/packs

document.addEventListener('turbolinks:load', () => {
  const $charts = document.querySelectorAll('.fake-chart');
  $charts.forEach(($el) => {
    const color = $el.dataset.color;
    const labels = ['January', 'February', 'March', 'April', 'May', 'June', 'July'];
    const data = {
      labels,
      datasets: [
        {
          label: 'Fake Dataset',
          backgroundColor: $[color],
          borderColor: 'rgba(255,255,255,.55)',
          data: [65, 59, 84, 84, 51, 55, 40],
        },
      ],
    };

    const options = {
      maintainAspectRatio: false,
      legend: {
        display: false,
      },
      scales: {
        xAxes: [{
          gridLines: {
            color: 'transparent',
            zeroLineColor: 'transparent',
          },
          ticks: {
            fontSize: 2,
            fontColor: 'transparent',
          },
        }],
        yAxes: [{
          display: false,
          ticks: {
            display: false,
            min: Math.min(...data.datasets[0].data) - 5,
            max: Math.max(...data.datasets[0].data) + 5,
          },
        }],
      },
      elements: {
        line: {
          borderWidth: 1,
        },
        point: {
          radius: 4,
          hitRadius: 10,
          hoverRadius: 4,
        },
      },
    };

    new Chart($el, {
      type: 'line',
      data,
      options,
    });
  });
});
