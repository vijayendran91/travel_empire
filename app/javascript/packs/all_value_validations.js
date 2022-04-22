
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


$(document).ready(function(){
  $('#bookRide').on('click', function(){
    validate_form();
  })
});
