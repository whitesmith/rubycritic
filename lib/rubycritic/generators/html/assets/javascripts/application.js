prettyPrint();

// sidebar navigation
$(function() {
  var loc = window.location.href; // returns the full URL
  if(/overview/.test(loc)) {
    $('.overview-nav').addClass('active');
  }
  else if(/code_index/.test(loc)) {
    $('.code-index-nav').addClass('active');
  }
  else if(/smells_index/.test(loc)) {
    $('.smells-index-nav').addClass('active');
  }
  else if(/simple_cov_index/.test(loc)) {
    $('.coverage-index-nav').addClass('active');
  }
});

var turbulenceData = turbulenceData || [];
var COLOR = {
  'A' : '#00B50E',
  'B': '#53D700',
  'C': '#FDF400',
  'D': '#FF6C00',
  'F': '#C40009'
};
$("#churn-vs-complexity-graph-container").highcharts({
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
    series: {
      turboThreshold: 0
    },
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
      tooltip: {
        headerFormat: "<b>{point.key}</b><br>",
        pointFormat: "Committed {point.x} times, with Flog score of {point.y}"
      }
    }
  },
  series: [{
    showInLegend: false,
    color: "steelblue",
    data: getMappedTurbulenceData()
  }]
});

function getMappedTurbulenceData(){
  var dataWithColorInformation = turbulenceData.map(function(data){
    data.color = COLOR[data.rating];
    return data;
  });
  return dataWithColorInformation;
};

$(function() {
  $("#gpa-chart").highcharts(
    {
      chart: {
        type: 'pie',
        events: {
            load: addTitle,
            redraw: addTitle,
        },
      },
      title: {
        text: "",
        useHTML: true
      },
      plotOptions: {
        pie: {
          shadow: false
        }
      },
      tooltip: {
        formatter: function() {
          return '<b>'+ this.point.name +'</b>: '+ this.y +' %';
        }
      },
      series: [{
        name: 'Browsers',
        data: getGpaData(),
        size: '90%',
        innerSize: '65%',
        showInLegend:true,
        dataLabels: {
          enabled: false
        }
      }]
    });
});

function addTitle() {
    if (this.title) {
        this.title.destroy();
    }
    var r = this.renderer,
        x = this.series[0].center[0] + this.plotLeft,
        y = this.series[0].center[1] + this.plotTop;
    this.title = r.label('<span class="obtained-score">'+score.toFixed(2)+'</span><span class="total-score">/100</span>', 0, 0, "", 0, 0, true)
        .css({
        color: 'black'
    }).hide().add();
    var bbox = this.title.getBBox();
    this.title.attr({
        x: x - (bbox.width / 2),
        y: y
    }).show();
    this.title.useHTML = true;
};

function getGpaData(){
  var ratingACount = getRatingWiseCount("A");
  var ratingBCount = getRatingWiseCount("B");
  var ratingCCount = getRatingWiseCount("C");
  var ratingDCount = getRatingWiseCount("D");
  var ratingFCount = getRatingWiseCount("F");
  var total = ratingACount + ratingBCount + ratingCCount + ratingDCount + ratingFCount;
  return [
    {name: 'A', y: parseFloat(calculatePercentage(ratingACount, total).toFixed(2)), color: COLOR['A']},
    {name: 'B', y: parseFloat(calculatePercentage(ratingBCount, total).toFixed(2)), color: COLOR['B']},
    {name: 'C', y: parseFloat(calculatePercentage(ratingCCount, total).toFixed(2)), color: COLOR['C']},
    {name: 'D', y: parseFloat(calculatePercentage(ratingDCount, total).toFixed(2)), color: COLOR['D']},
    {name: 'F', y: parseFloat(calculatePercentage(ratingFCount, total).toFixed(2)), color: COLOR['F']},
  ];
};

function calculatePercentage(gradeCount, total){
  return (gradeCount/total)*100;
};

function getRatingWiseCount(rating){
  var count = 0;
  turbulenceData.forEach(function(data, index){
    if(data.rating === rating){
      count++;
    }
  });
  return count;
};

function emphasizeLineFromFragment() {
  emphasizeLine(window.location.hash)
}

$(".js-file-code").on("click", ".js-smell-location", emphasizeLineFromHref);

function emphasizeLineFromHref(event) {
  if (hrefTargetIsOnCurrentPage(this) && !event.ctrlKey) {
    $(".js-file-code li").removeClass("highlight");
    var lineId = "#" + this.href.split("#")[1];
    emphasizeLine(lineId);
    return false;
  }
}

function hrefTargetIsOnCurrentPage(aTag) {
  return (window.location.pathname === aTag.pathname);
}

function emphasizeLine(lineReference) {
  scrollToTarget(lineReference);
  highlightLine(lineReference);
}

function scrollToTarget(lineReference) {
  window.location.hash = lineReference;
  $.scrollTo(lineReference, {
    duration: 300,
    easing: "linear",
    offset: {top: -87},
    axis: 'y'
  });
}

function highlightLine(lineReference) {
  $(lineReference).addClass("highlight");
}

$("#toggle-code").on("click", showCode);
$("#toggle-smells").on("click", showSmells);
$("#toggle-coverage").on("click", showCoverage);

function showCode() {
  $('#toggle-code').parent('li').addClass('active');
  $('#toggle-smells').parent('li').removeClass('active');
  $('#toggle-coverage').parent('li').removeClass('active');
  $(".smells").hide();
}

function showSmells() {
  $('#toggle-code').parent('li').removeClass('active');
  $('#toggle-coverage').parent('li').removeClass('active');
  $('#toggle-smells').parent('li').addClass('active');
  $(".smells").show();
}

function showCoverage() {
  $('#toggle-code').parent('li').removeClass('active');
  $('#toggle-smells').parent('li').removeClass('active');
  $('#toggle-coverage').parent('li').addClass('active');
  $(".coverage").show();
}

$("#codeTable")
  .tablesorter({          // Sort the table
    sortList: [[0,1]]
  });

$("#js-index-table")
  .tablesorter({          // Sort the table
    sortList: [[0,0]]
  });

$(".js-timeago").timeago();

$(function(){
  $('.table-header').click(function(){
    $('.table-header').not(this).each(function(){
      $(this).removeClass('active');
      $(this).find('.sort-type').removeClass('table-header-asc');
      $(this).find('.sort-type').removeClass('table-header-desc');
    });
    if($(this).hasClass('active')){
      $(this).find('.sort-type').toggleClass('table-header-asc table-header-desc');
    }
    else{
      $(this).addClass('active');
      $(this).find('.sort-type').addClass('table-header-asc');
    }
  });
});

function assignIdsToCodeLines(){
  $($('.linenums')[1]).children().each(function(index){
    $(this).attr('id', "L" + index)
  });
};

$(document).ready(function(){
  assignIdsToCodeLines();
  emphasizeLineFromFragment();
  initTableFilters();
});

var initTableFilters = function() {
  $("#codeTable").filterTable({ignoreColumns: [2], placeholder: 'Filter by Name'});
  $("#js-index-table").filterTable({ignoreColumns: [2, 3, 4, 5], placeholder: 'Filter by Smell or Location', inputSelector: 'form-control'});
}
