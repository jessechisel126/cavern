var lineChart = function (high, low, divName) {
    var chart = new Highcharts.Chart({
        chart: {
            renderTo: divName,
            zoomType: 'x',
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
            area: {
                fillColor: {
                    linearGradient: {
                        x1: 0,
                        y1: 0,
                        x2: 0,
                        y2: 1
                    },
                    stops: [
                        [0, Highcharts.getOptions().colors[1]],
                        [1, Highcharts.Color(Highcharts.getOptions().colors[0]).setOpacity(0).get('rgba')]
                    ]
                },
                marker: {
                    radius: 2
                },
                lineWidth: 1,
                threshold: null
            }
        },
        series: [{
            data: high
        }, {
            data: low
        }]
    });
};

// column: {
//     pointPadding: 0.1,
//     borderWidth: 0.5
// }

var beatChart = function (ranges, divName) {
    var chart = new Highcharts.Chart({
        chart: {
            renderTo: divName,
            type: 'columnrange',
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
            area: {
                fillColor: {
                    linearGradient: {
                        x1: 0,
                        y1: 0,
                        x2: 0,
                        y2: 1
                    },
                    stops: [
                        [0, Highcharts.getOptions().colors[1]],
                        [1, Highcharts.Color(Highcharts.getOptions().colors[0]).setOpacity(0).get('rgba')]
                    ]
                },
                marker: {
                    radius: 2
                },
                lineWidth: 1,
                threshold: null
            }
        },

        series: [{
            data: [ranges]
        }], 
    });
};


/// For line graphs in plotOptions