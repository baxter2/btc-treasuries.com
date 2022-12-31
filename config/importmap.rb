# Pin npm packages by running ./bin/importmap

pin "application", preload: true
pin "@hotwired/turbo-rails", to: "turbo.min.js", preload: true
pin "@hotwired/stimulus", to: "stimulus.min.js", preload: true
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js", preload: true
pin_all_from "app/javascript/controllers", under: "controllers"

# $ bin/importmap pin chart.js
pin "chart.js", to: "https://ga.jspm.io/npm:chart.js@4.1.1/dist/chart.js"
pin "@kurkle/color", to: "https://ga.jspm.io/npm:@kurkle/color@0.3.1/dist/color.esm.js"

# $ bin/importmap pin chartjs-adapter-moment
pin "chartjs-adapter-moment", to: "https://ga.jspm.io/npm:chartjs-adapter-moment@1.0.1/dist/chartjs-adapter-moment.esm.js"
pin "moment", to: "https://ga.jspm.io/npm:moment@2.29.4/moment.js"
