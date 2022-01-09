export default function drawGauge(id, my_label, my_data, my_color) { //,  , my_color
  const ctx = document.getElementById(id);
  const labels = my_label;
  const data = {
    labels: labels,
    datasets: [{
      // label: labels,
      data: my_data,
      backgroundColor: [my_color[0], 'rgba(255, 255, 255, 0.85)'],
      borderColor: [my_color[1]],
      borderWidth: 1
    }]
  };
  const config = {
    type: "doughnut",
    data: data,
    options: {
      maintainAspectRatio: false,
      circumference: 180,
      rotation: -90,
      cutoutPercentage: 64,
    }
  };
  const myChart = new Chart(ctx, config);
}