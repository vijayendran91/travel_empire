
function validate_form(){
  var totr=$('#inlineFormCustomSelect').val()
  
  // Choose Type of Trip    
  if(totr == 'ch'){
    alert('Choose a Type of Trip');
  }
  
  //Cannot start tomorrow and arrivew today - time validation  
  if(!(totr == 'ch' || totr == 'ow')){
    st = new Date($('#BookingTime').val());
    end = new Date($('#returnBookingTime').val());
    if((end - st) < 0){
      alert('Return time is before start time.');
    }
  } 
}


$(document).ready(function(){
  $('#bookRide').on('click', function(){
    validate_form();
  })  
});
