export default function drawMixBarLineChart(id, my_labels, my_data, my_ticks) {
  const ctx = document.getElementById(id);

  const labels = my_labels;
  const data = {
    labels: labels,
    datasets: [{
      label: my_ticks[0],
      data: my_data[0],
      borderColor: 'rgb(75, 192, 192)',
      backgroundColor: "rgba(255, 205, 86, 0.75)",
      yAxisID: 'y',
      order: 1
    }, {
      label: my_ticks[1],
      data: my_data[1],
      borderColor: 'rgb(255, 192, 192)',
      backgroundColor: "rgba(0, 20, 86, 0.75)",
      yAxisID: 'y2',
      type: 'line',
      order: 0
    }]
  };
  const config = {
    type: 'bar',
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
      plugins: {
        legend: {
          position: 'top',
        }
      },
      scales: {
        y: {
          type: 'linear',
          position: 'left',
        },
        y2: {
          type: 'linear',
          position: 'right',
          grid: {
            drawOnChartArea: false // only want the grid lines for one axis to show up
          }
        }
      }
    }
  };
  const myChart = new Chart(ctx, config);
}
