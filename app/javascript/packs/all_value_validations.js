
function validate_form(){
  var totr=$('#inlineFormCustomSelect').val()
  var todist=$('#fromDistSelect').val();
  var fromdist = $('#toDistSelect').val();
  var str = $('#str').val();
  // Choose Type of Trip

  if(totr == 'ch'){
    alert('Choose a Type of Trip');
    event.preventDefault;
  }

  if(str == 'ch'){
    alert('Choose a type of car');
    event.preventDefault;
  }

  //Cannot start tomorrow and arrivew today - time validation
  if(!(totr == 'ch' || totr == 'ow')){
    st = new Date($('#BookingTime').val());
    end = new Date($('#returnBookingTime').val());
    if((end - st) < 0){
      alert('Return time is before start time.');
      event.preventDefault;
    }
  }

  if(totr == 'ch'){
    alert('Choose a Type of Trip');
    event.preventDefault;
  }

  if(todist == 'sd' || fromdist == 'sd'){
    alert("Please select a proper district");
    event.preventDefault;
  }
  validate_phone($('#phone').val())
  // if($("#aadhaarFront").val() == ""){
  //   alert("Please Upload Photo Proof");
  // }

}


function validate_phone(phone){
  result = true;
  if(phone.length != 10)
  {
    result = false;
  }

  if(result == false){
    // $('#errorsModal').modal('show');
    window.alert("Please enter a valid 10 digit Phone number");
    event.preventDefault;
  }
}

$(document).ready(function(){
  $('#bookRide').on('click', function(){
    validate_form();
  })
  $('#phone').on('change',function(event){
    validate_phone($('#phone').val());
  })
});
