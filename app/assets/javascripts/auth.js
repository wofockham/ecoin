$(document).ready(function () {


$('#auth').hide();


var process_transaction = function (notification) {
  $('#phone').val('');
  $('#amount').val('');

  if (notification.status === 'verified') {

  $("#status")
  .html('&#10003;')
  .css('color','green').fadeOut(1600);

  }else if (notification.status === 'insufficient') {
    show_insufficient_message();

  }else if (notification.status === 'pending') {
    show_authorisation_form(notification.trans_id);
    $("#status").hide();
  }

};

var process_auth = function (notification) {

if (notification.status === 'verified') {
  $("#status_auth")
  .html('&#10003;')
  .css('color','green').fadeOut(1600);

} else if (notification.status === 'invalid') {
    alert('Invalid');
  };
};


var insufficient_message = function () {
  alert("Insufficient funds");
}

var show_authorisation_form = function (id) {
   $('#auth').show();
   $('#transaction_id').val(id);
};

var create_auth = function () {

    var auth_code = $('#auth_code').val();
    var trans_id = $('#transaction_id').val();


    $.ajax({
      dataType: 'json',
      type: 'POST',
      url: '/redeemtxt',
      data: {'auth_code':auth_code, 'trans_id':trans_id}
    }).done(process_auth);

    return false;
};


var create_trans = function () {

    var phone = $('#phone').val();
    var amount = $('#amount').val();


    $.ajax({
      dataType: 'json',
      type: 'POST',
      url: '/sendtxt',
      data: {'phone':phone, 'amount':amount}
    }).done(process_transaction);

    return false;
  };


var gravy = function () {
   $("#status")
  .html('&#10003;')
  .css('color','green');

}






$('#create_trans').click(create_trans);
$('#auth_trans').click(create_auth);


})