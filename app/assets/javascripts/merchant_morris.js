$(document).ready(function () {

// $('#new_priority').toggle();
// $('.form').toggleClass('invisible');


var toggle_back = function () {
    $('.chart').toggle();
    $('.trans_tables').show();
  }

var toggle = function () {
    // $('.trans_tables').hide();
    // $('.chart').show();
    $('.trans_tables').toggle();
    merchant_chart();
}

var merchant_chart = function () {

    $.ajax({
      dataType: 'json',
      type: 'get',
      url: '/merchants/mchart/merch',
    }).done(show_chart);
    return false;
  };


  var show_chart = function (transactions) {
    $('#chart').empty();
   new Morris.Line({
      element: 'chart',
      data: transactions,
      xkey: 'created_at',
      ykeys: ['amount'],
      labels: ['balance']
    });
 };


 var cumulative_chart = function () {

    $.ajax({
      dataType: 'json',
      type: 'get',
      url: '/merchants/mchart/bal',
    }).done(show_cumulative_chart);
    return false;
  };


  var show_cumulative_chart = function (transactions) {
    $('#cumulative_chart').empty();
   new Morris.Line({
      element: 'cumulative_chart',
      data: transactions,
      xkey: 'created_at',
      ykeys: ['amount'],
      labels: ['balance']
    });
 };



$('#merchant_chart').click(toggle);
$('#merchant_chart').click(cumulative_chart);
$('#merchant_trans').click(toggle_back);

});


