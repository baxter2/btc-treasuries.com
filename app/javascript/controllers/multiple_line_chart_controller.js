import { Controller } from "@hotwired/stimulus"
import 'chartjs-adapter-moment';
import 'moment';

// https://www.chartjs.org/docs/3.3.0/getting-started/integration.html#bundlers-webpack-rollup-etc
import { Chart, registerables } from 'chart.js';
Chart.register(...registerables);

export default class extends Controller {
  static values = {
    countriesLabel: String,
    countriesData: Array,
    pubCompaniesLabel: String,
    pubCompaniesData: Array,
    privCompaniesLabel: String,
    privCompaniesData: Array,
  }

  connect() {
    const data = {
      datasets: [
        {
          label: this.countriesLabelValue,
          stepped: true,
          data: this.countriesDataValue,
          backgroundColor: 'rgba(242, 169, 0, 0.2)',
          borderColor: 'rgba(242, 169, 0, 1)',
          borderWidth: 3
        },
        {
          label: this.privCompaniesLabelValue,
          stepped: true,
          data: this.privCompaniesDataValue,
          backgroundColor: 'rgba(106, 90, 205, 0.2)',
          borderColor: 'rgba(106, 90, 205, 1)',
          borderWidth: 3
        },
        {
          label: this.pubCompaniesLabelValue,
          stepped: true,
          data: this.pubCompaniesDataValue,
          backgroundColor: 'rgba(255, 99, 71, 0.2)',
          borderColor: 'rgba(255, 99, 71, 1)',
          borderWidth: 3
        },
      ]
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
      document.getElementById('lineChartTreasuries'),
      config
    );
  }
}
