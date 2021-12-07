let locs = 0;
$(document).ready(function(){
  $('#totModal').hide();
  $('.perOrBus').hide();
  $('#addLocation').hide();
  $('#flightTicket').hide();
  $('#returnDateTime').hide();

  $('#bookCab').on('click', function(){
      $('#bookCab').hide();
      $('#makePayment').hide();
      $('.perOrBus').show();
    // $('.cabBookingForm').show();
  });

  $('#personalRadio').on('click',function(){
    $('#gst').hide();
    $('#gstLabel').hide();
    $('.cabBookingForm').show();
  });

  $('#businessRadio').on('click',function(){
    $('#gst').show();
    $('#gstLabel').show();
    $('.cabBookingForm').show();
  });


  $('#addLocation').on('click',function(){
    locs++;
    if(locs<5){
      parElem = document.getElementById('multiLocations');
      input = document.createElement("input");
      input.setAttribute('type','text');
      input.setAttribute('class',"form-control mb-3 locations");
      parElem.appendChild(input);
    }else{
      window.alert("You can add only maximum of 4 locations");
    }
  });

  $('#flight').on('change', function(){
      if($('#flight').prop("checked")==true){
        $('#aadhaars').hide();
        $('#flightTicket').show();
      }
      else if($('#flight').prop("checked")==false){
        $('#aadhaars').show();
        $('#flightTicket').hide();
      }
  });


});
