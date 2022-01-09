export default function drawLineChart(id, my_labels, my_data) {
  const ctx = document.getElementById(id);
  const labels = my_labels;
  const data = {
    labels: labels,
    datasets: [{
      label: 'Readability Score',
      data: my_data[0],
      borderColor: 'rgb(75, 192, 192)', //green
      backgroundColor: "rgba(255, 205, 86, 0.75)",
      yAxisID: 'y',
      order: 1
    }, {
      label: 'Sentiment Score',
      data: my_data[1],
      borderColor: 'rgb(255, 192, 192)',
      backgroundColor: "rgba(0, 20, 86, 0.75)",
      yAxisID: 'y1',
      type: 'line',
      order: 0
    }]
  };
  const config = {
    type: 'line',
    data: data,
    options: {
      responsive: true,
      animations: {
        tension: {
          duration: 2500,
          easing: 'linear',
          from: 0.5,
          to: 0,
          loop: true
        }
      },
      interaction: {
        mode: 'index',
        intersect: false,
      },
      stacked: false,
      scales: {
        y: {
          type: 'linear',
          display: true,
          position: 'left',
          reverse: true
        },
        y1: {
          type: 'linear',
          display: true,
          position: 'right',

          // grid line settings
          grid: {
            drawOnChartArea: false, // only want the grid lines for one axis to show up
          },
        },
      }
    },
  };
  const myChart = new Chart(ctx, config);
}
