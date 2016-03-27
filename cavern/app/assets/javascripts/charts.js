var frequencyChart = function (high, low) {
    var chart = new Highcharts.Chart({
        chart: {
            renderTo: 'container',
            zoomType: 'x',
            type: 'column',
        },
        title: {
            text: 'Song frequency'
        },
        subtitle: {
            text: 'Song frequency on a song.'
        },
        xAxis: {
            type: 'time'
        },
        yAxis: {
            title: {
                text: 'Amplitude'
            }
        },
        legend: {
            enabled: false
        },
        plotOptions: {
            column: {
                pointPadding: 0.1,
                borderWidth: 0.5
            }
        },

        series: [{
            data: high
        }, {
            data: low
        }]
    });
};

/// For line graphs in plotOptions

// area: {
//     fillColor: {
//         linearGradient: {
//             x1: 0,
//             y1: 0,
//             x2: 0,
//             y2: 1
//         },
//         stops: [
//             [0, Highcharts.getOptions().colors[0]],
//             [1, Highcharts.Color(Highcharts.getOptions().colors[0]).setOpacity(0).get('rgba')]
//         ]
//     },
//     marker: {
//         radius: 2
//     },
//     lineWidth: 1,
//     threshold: null
// }