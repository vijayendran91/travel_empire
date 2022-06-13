import {typeOfTrip} from './trip/trip_tot.js'
let locs = 0;
$(document).ready(function(){
  $('#totModal').hide();
  $('.perOrBus').hide();
  $('#addLocation').hide();
  $('#flightTicket').hide();
  $('#returnDateTime').hide();
  $('#roundtripDest').hide();
  $('#hourlyHours').hide();
  $('#errorModal').hide();
  $('#previeBookingModal').hide();
  $("#new_trip").on("submit", function(){
    $("body").addClass("loading");
  });

  $('#bookCab').on('click', function(){
      $('#bookCab').hide();
      $('#makePayment').hide();
      $('.perOrBus').show();
      $('.perOrBus').attr('style', 'display:inline-flex');
    // $('.cabBookingForm').show();
  });



  $('#personalRadio').on('click',function(){
    $('#gst').hide();
    $('#gstLabel').hide();
    $('.cabBookingForm').show();
    $('#email').attr('required', false);
  });


  $('#businessRadio').on('click',function(){
    $('#gst').show();
    $('#gstLabel').show();
    $('.cabBookingForm').show();
    $('#email').attr('required', true);
  });


  $('#fromDistSelect').on('change', function(){
    var tot = $('#inlineFormCustomSelect').val();
    if(tot == 'rt'){
      $('#roundtripDestText').attr('placeholder', $('#fromDistSelect').val());
    }
  });


  $('#locationSwap').on('click', function(){
    //Source & Destination Swap
    var temp = $('#fromDistSelect').val();
    $('#fromDistSelect').val($('#toDistSelect').val());
    $('#toDistSelect').val(temp);

    //Area Swap
    temp = $('.pua').val();
    $('.pua').val($('.dra').val());
    $('.dra').val(temp);

    //time swap
    //temp = $('#BookingTime').val();
    //$('#BookingTime').val($('#returnBookingTime').val());
    //$('#returnBookingTime').val(temp);

  });


  $('#addLocation').on('click',function(){
    locs++;
    var tot = $('#inlineFormCustomSelect').val();
    var parElem = document.getElementById('multiLocations');
    var input = document.createElement("input");
    if(locs<5){
      // var input = "<%=f.text_field :loc"+locs+", :class=>'form-control', :id=>'loc"+locs+"', :placeholder=>'Location "+locs+"'%>"
      input.setAttribute('type','text');
      input.setAttribute('class',"form-control mb-3 locations");
      input.setAttribute('id',''+locs+'');
      input.setAttribute('name', 'trip[locs'+locs+']')
      input.setAttribute('placeholder', "Location"+locs);
      // console.log(input);
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


  // $('#gst, #firstName, #lastName, #fromArea, #toArea').keydown(function(){
  //   debugger;
  //   this.value = this.value.toUpperCase();
  // });

  $('.close-modal').on('click', function(){
    $('.modal').hide();
  });


  $('#bookNow, #advanceBooking, #tentativeBooking').on('change', function(){
    typeOfTrip(false);
  });
});
