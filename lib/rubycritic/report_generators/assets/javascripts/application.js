prettyPrint();

highlightLineFromFragment();

function highlightLineFromFragment() {
    highlightLine(window.location.hash)
}

$(".js-file-code").on("click", ".js-smell-location", highlightSmellyLine);

function highlightSmellyLine() {
    var lineId = "#" + this.href.split("#")[1];
    $(".js-file-code li").removeClass("highlight");
    highlightLine(lineId);
}

function highlightLine(lineReference) {
    $(lineReference).addClass("highlight");
}

$("#js-toggle-smells").on("click", toggleSmells);

function toggleSmells() {
    $(".js-smells").toggle();
}

$("#js-chart-container").highcharts({
    chart: {
        type: "scatter",
        zoomType: "xy"
    },
    title: {
        text: "Churn vs Complexity"
    },
    xAxis: {
        title: {
            enabled: true,
            text: "Churn"
        },
        floor: 0,
        startOnTick: true,
        endOnTick: true
    },
    yAxis: {
        title: {
            text: "Complexity"
        },
        floor: 0,
        startOnTick: true,
        endOnTick: true
    },
    plotOptions: {
        scatter: {
            marker: {
                radius: 5,
                states: {
                    hover: {
                        enabled: true,
                        lineColor: "rgb(100,100,100)"
                    }
                }
            },
            states: {
                hover: {
                    marker: {
                        enabled: false
                    }
                }
            },
            tooltip: {
                headerFormat: "<b>{point.key}</b><br>",
                pointFormat: "Committed {point.x} times, with Flog score of {point.y}"
            }
        }
    },
    series: [{
        color: "steelblue",
        data: turbulence_data,
        showInLegend: false
    }]
});
