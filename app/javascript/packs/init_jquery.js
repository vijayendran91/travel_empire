let locs = 0;
$(document).ready(function(){
  $('#totModal').hide();
  $('.perOrBus').hide();
  $('#addLocation').hide();
  $('#flightTicket').hide();
  $('#returnDateTime').hide();
  $('#roundtripDest').hide();
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


  $('#fromDistSelect').on('change', function(){
    var tot = $('#inlineFormCustomSelect').val();
    if(tot == 'rt'){
      $('#roundtripDestText').attr('placeholder', $('#fromDistSelect').val());
    }
  });

  $('#addLocation').on('click',function(){
    locs++;
    var tot = $('#inlineFormCustomSelect').val();
    var parElem = document.getElementById('multiLocations');
    var input = document.createElement("input");
    if(locs<5){
      input.setAttribute('type','text');
      input.setAttribute('class',"form-control mb-3 locations");
      input.setAttribute('id',''+locs+'');
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

  
  $('#gst').keyup(function(){
    this.value = this.value.toUpperCase();
  });
 
});
