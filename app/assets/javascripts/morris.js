$(document).ready(function () {

var add_amount = function () {
    var amount = $('#amount').val();

    $.ajax({
      dataType: 'json',
      type: 'post',
      url: '/merchants/sendtxt/' + amount
    }).done(chart_balance);
  };

var chart_balance = function () {

   new Morris.Line({
      element: 'chart',
      data: transactions,
      xkey: 'amount',
      ykeys: ['transactions'],
      labels: ['amount']
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

$('#create_trans').click(add_amount);
});