
function validate_form(){
  var totr=$('#inlineFormCustomSelect').val()
  
  if(totr == 'ch'){
    alert('Choose a Type of Trip');
  }else if(!(totr == 'ch' || totr == 'ow')){
    
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
