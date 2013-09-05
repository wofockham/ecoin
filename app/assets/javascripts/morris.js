
var show_chart = function () {
    var phone = $('#phone').val();

    $.ajax({
      dataType: 'json',
      type: 'get',
      url: '/merchants/chart/' + phone
    }).done(chart_balance);
  };

var chart_balance = function (transactions) {

   new Morris.Line({
      element: 'chart',
      data: transactions,
      xkey: 'created_at',
      ykeys: ['amount'],
      preUnits: '$',
      dateFormat: function (x) { return new Date(x).toString('dddd, MMMM Do YYYY, h:mm'); },
      labels: ['balance']
    });

};

