import { Controller } from "@hotwired/stimulus"
import 'chartjs-adapter-moment';
import 'moment';

// https://www.chartjs.org/docs/3.3.0/getting-started/integration.html#bundlers-webpack-rollup-etc
import { Chart, registerables } from 'chart.js';
Chart.register(...registerables);


export default class extends Controller {
   static values = { data: Array, label: String }

  connect() {
    const data = {
      datasets: [{
        label: this.labelValue,
        stepped: true,
        data: this.dataValue,
        backgroundColor: 'rgba(242, 169, 0, 0.2)',
        borderColor: 'rgba(242, 169, 0, 1)',
        borderWidth: 3
      }]
    };

    const config = {
      type: 'line',
      data,
      options: {
        scales: {
          x: {
            title: {
              display: true,
              text: "Quaters",
              align: "center"
            },
            type: "time",
            time: {
              unit: 'quarter'
            },
            max: new Date()
          },
          y: {
            title: {
              display: true,
              text: "₿",
              align: "center"
            }
          }
        },
        responsive: true,
      }
    };

    const myChart = new Chart(
      document.getElementById('myChart'),
      config
    );
  }
}
