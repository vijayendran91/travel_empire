
function validate_form(){
  var totr=$('#inlineFormCustomSelect').val()
  var todist=$('#fromDistSelect').val();
  var fromdist = $('#toDistSelect').val();
  var str = $('#str').val();
  // Choose Type of Trip
  if(totr == 'ch'){
    alert('Choose a Type of Trip');
  }

  if(str == 'ch'){
    alert('Choose a type of car')
  }

  //Cannot start tomorrow and arrivew today - time validation
  if(!(totr == 'ch' || totr == 'ow')){
    st = new Date($('#BookingTime').val());
    end = new Date($('#returnBookingTime').val());
    if((end - st) < 0){
      alert('Return time is before start time.');
    }
  }

  if(totr == 'ch'){
    alert('Choose a Type of Trip');
  }

  if(todist == 'sd' || fromdist == 'sd'){
    alert("Please select a proper district");
  }

  // if($("#aadhaarFront").val() == ""){
  //   alert("Please Upload Photo Proof");
  // }

}


function validate_phone(phone){
  result = false;
  if(phone.length == 13)
  {
    temp = phone.substring(1)
    if(temp.length == 12 && /^-?\d+$/.test(temp)){
      result = true
    }else{
      result = false;
    }
  }
  else if (phone.length == 12 && /^-?\d+$/.test(phone)) {
    result = true;
  }else if (phone.length == 10 && /^-?\d+$/.test(phone)){
    result = true;
  }else{
    result = false;
  }



  if(result == false){
    // $('#errorsModal').modal('show');
    window.alert("Please enter a valid Phone number with country code");
  }
}

$(document).ready(function(){
  $('#bookRide').on('click', function(){
    validate_form();
  })
  // $('#phone').on('change',function(){
  //   validate_phone($('#phone').val());
  // })
});
