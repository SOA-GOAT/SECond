export default function drawMixBarLineChart(id, my_labels, my_data) {
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
    type: 'scatter',
    data: data,
    options: {
      scales: {
        y: {
          beginAtZero: true
        }
      }
    }
  };
  const myChart = new Chart(ctx, config)
}

//

        const config = {
          
        const data = {
          labels: [
            'January',
            'February',
            'March',
            'April'
          ],
          datasets: [{
            type: 'bar',
            label: 'Bar Dataset',
            data: [10, 20, 30, 40],
            borderColor: 'rgb(255, 99, 132)',
            backgroundColor: 'rgba(255, 99, 132, 0.2)'
          }, {
            type: 'line',
            label: 'Line Dataset',
            data: [50, 50, 50, 50],
            fill: false,
            borderColor: 'rgb(54, 162, 235)'
          }]
        };
        const mixedChart = new Chart(ctx, {
          data: {
            datasets: [{
              type: 'bar',
              label: 'Bar Dataset',
              data: [10, 20, 30, 40]
            }, {
              type: 'line',
              label: 'Line Dataset',
              data: [50, 50, 50, 50],
            }],
            labels: ['January', 'February', 'March', 'April']
          },
          options: options
        });