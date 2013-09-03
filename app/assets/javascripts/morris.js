$(document).ready(function () {

var show_chart = function () {
    var phone = $('#phone').val();

    $.ajax({
      dataType: 'json',
      type: 'get',
      url: '/merchants/chart/' + phone
    }).done(chart_balance);
  };


// var sum_balance = function () {
//   var phone = $('#phone').val()

//    $.ajax({
//       dataType: 'json',
//       type: 'get',
//       url: '/merchants/chart/sum/' + phone
//     }).done(chart_balance);
//   };




var chart_balance = function (transactions) {

   new Morris.Line({
      element: 'chart',
      data: transactions,
      xkey: 'created_at',
      ykeys: ['amount'],
      labels: ['balance']
    });

};



// var show_chart = function () {

// // $('#chart').empty();
// new Morris.Line({
//   // ID of the element in which to draw the chart.
//   element: 'chart',
//   // Chart data records -- each entry in this array corresponds to a point on
//   // the chart.
//   data: [
//     { year: '2008', value: 20 },
//     { year: '2009', value: 10 },
//     { year: '2010', value: 5 },
//     { year: '2011', value: 5 },
//     { year: '2012', value: 20 }
//   ],
//   // The name of the data record attribute that contains x-values.
//   xkey: 'year',
//   // A list of names of data record attributes that contain y-values.
//   ykeys: ['value'],
//   // Labels for the ykeys -- will be displayed when you hover over the
//   // chart.
//   labels: ['Value']
// });
// }

$('#show_chart').click(show_chart);
});