
function validate_form(){
  var totr=$('#inlineFormCustomSelect').val()
  var todist=$('#fromDistSelect').val();
  var fromdist = $('#toDistSelect').val();
  var str = $('#str').val();
  var error_msgs = [];
  // Choose Type of Trip

  if(totr == 'ch'){
    msg = 'Choose a Type of Trip';
    error_msgs.push(msg);
  }

  if(str == 'ch'){
    msg = 'Choose a type of car';
    error_msgs.push(msg);
  }

  //Cannot start tomorrow and arrivew today - time validation
  if (totr != 'hy'){
    if(!(totr == 'ch' || totr == 'ow')){
      st = new Date($('#BookingTime').val());
      end = new Date($('#returnBookingTime').val());
      if((end - st) < 0){
        msg = "Return time is before start time";
        error_msgs.push(msg);
      }
    }
  }

  if(totr == 'ch'){
    msg = 'Choose a Type of Trip';
    error_msgs.push(msg);
  }

  if(todist == 'sd' || fromdist == 'sd'){
    msg = "Please select a proper district";
    error_msgs.push(msg);
  }
  return error_msgs
}

function fillErrorsInModal(error_msgs){
  $('#errorMsgsList').empty();
  for(let i=0; i<error_msgs.length;i++){
    $('#errorMsgsList').append("<li> "+error_msgs[i]+"</li>");
  }
}



$(document).ready(function(){
  $('#bookRide').on('click', function(){
    debugger;
    error_msgs = validate_form();
    if(error_msgs.length > 0){
      debugger;
      fillErrorsInModal(error_msgs);
      $('#errorModal').show();
      window.scrollTo(0, 0);
      event.preventDefault();
    }
  })
});
