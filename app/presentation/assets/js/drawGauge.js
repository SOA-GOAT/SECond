export default function drawGauge(id, my_data) {
  const ctx = document.getElementById(id);
  //const labels = my_labels;
  const data = {
    labels: ["Readability"],
    datasets: [{
      // label: labels,
      data: my_data,
      backgroundColor: ["rgb(255, 205, 86)", 'rgba(255, 255, 255, 0.85)'],
      borderColor: ["rgba(255, 205, 86, 0.75)"],
      borderWidth: 1
    }]
  };
  const config = {
    type: "doughnut",
    data: data,
    options: {
      maintainAspectRatio: false,
      circumference: 180,
      rotation:-90,
      cutoutPercentage: 64,
    }
  };
  const myChart = new Chart(ctx, config);
}