export default function drawLineChart(id, my_labels, my_data) {
  const ctx = document.getElementById(id);
  const labels = my_labels;
  const data = {
    labels: labels,
    datasets: [{
      label: 'Readability Trend',
      data: my_data,
      fill: false,
      borderColor: 'rgb(75, 192, 192)',
      tension: 0.1
    }]
  };
  const config = {
    type: 'line',
    data: data,
    options: {
      animations: {
        tension: {
          duration: 2500,
          easing: 'linear',
          from: 0.5,
          to: 0,
          loop: true
        }
      }
    }
  };
  const myChart = new Chart(ctx, config);
}
