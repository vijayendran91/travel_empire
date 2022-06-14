export function loadPreviewTripTable(){
  $('.previewTableRows').empty();
  $('.previewTableRows').append("<thead><th>Trip Details</th></thead>");
  var per_or_bus = document.querySelector('input[name="trip[perbus]"]:checked').value;
  if(per_or_bus == 'per'){
    previewRowTable("Personal or Business", "Personal");
  }else{
    previewRowTable("Personal or Business", "Business");
  }

  var type_of_trip = $('#inlineFormCustomSelect').val();
  var pickDate = new Date($('#BookingTime').val());
  var dropDate = new Date($('#returnBookingTime').val());

  switch (type_of_trip) {
    case 'rtt':
      previewRowTable("Type of Trip", "Return Trip");
      previewRowTable("Pickup Location", $('#fromDistSelect').val()+" - "+$('.pua').val());
      previewRowTable("Pickup Date and Time", pickDate.getDate()+"/"+pickDate.getMonth()+"/"+pickDate.getYear()+" - "+pickDate.getHours()+":"+pickDate.getMinutes());
      previewRowTable("Drop Location", $('#fromDistSelect').val()+" - "+$('.dra').val());
      previewRowTable("Drop Date and Time", dropDate.getDate()+"/"+dropDate.getMonth()+"/"+dropDate.getYear()+" - "+dropDate.getHours()+":"+dropDate.getMinutes());
      break;
    case 'ow':
      previewRowTable("Type of Trip", "One Way");
      previewRowTable("Pickup Location", $('#fromDistSelect').val()+" - "+$('.pua').val());
      previewRowTable("Pickup Date and Time", pickDate.getDate()+"/"+pickDate.getMonth()+"/"+pickDate.getYear()+" - "+pickDate.getHours()+":"+pickDate.getMinutes());
      previewRowTable("Drop Location", $('#fromDistSelect').val()+" - "+$('.dra').val());
      break;
    case 'rt':
      previewRowTable("Type of Trip", "Round Trip");
      previewRowTable("Pickup Location", $('#fromDistSelect').val()+" - "+$('.pua').val());
      previewRowTable("Pickup Date and Time", pickDate.getDate()+"/"+pickDate.getMonth()+"/"+pickDate.getYear()+" - "+pickDate.getHours()+":"+pickDate.getMinutes());
      previewRowTable("Drop Location", $('#fromDistSelect').val()+" - "+$('.dra').val());
      previewRowTable("Drop Date and Time", dropDate.getDate()+"/"+dropDate.getMonth()+"/"+dropDate.getYear()+" - "+dropDate.getHours()+":"+dropDate.getMinutes());
      break;
    case 'my':
      var temp = "";
      $('.locations').each(function(){
        temp = $(this).val()+" , "+temp;
      });
      previewRowTable("Type of Trip", "Multi Way");
      previewRowTable("Pickup Location", $('#fromDistSelect').val()+" - "+$('.pua').val());
      previewRowTable("Pickup Date and Time", pickDate.getDate()+"/"+pickDate.getMonth()+"/"+pickDate.getYear()+" - "+pickDate.getHours()+":"+pickDate.getMinutes());
      previewRowTable("Drop Location", $('#fromDistSelect').val()+" - "+temp);
      previewRowTable("Drop Date and Time", dropDate.getDate()+"/"+dropDate.getMonth()+"/"+dropDate.getYear()+" - "+dropDate.getHours()+":"+dropDate.getMinutes());
      break;
    case 'hy':
      previewRowTable("Pickup Location", $('#fromDistSelect').val()+" - "+$('.pua').val());
      previewRowTable("Pickup Date and Time", pickDate.getDate()+"/"+pickDate.getMonth()+"/"+pickDate.getYear()+" - "+pickDate.getHours()+":"+pickDate.getMinutes());
      previewRowTable("Drop Location", $('#fromDistSelect').val()+" - "+$('#fromArea').val());
      previewRowTable("Type of Trip", "Hourly");
      previewRowTable("Drop Date and Time", dropDate.getDate()+"/"+dropDate.getMonth()+"/"+dropDate.getYear()+" - "+dropDate.getHours()+":"+dropDate.getMinutes());
      break;
    default:
      previewRowTable("Type of Trip", "One Way");
    }


  previewRowTable("No. of Passengers", "Adult : "+$('#adult').val()+" Children : "+$('#adult').val());
  previewRowTable("Car Type",$('#str').val());
  $('.previewTableRows').append("<thead><th>Passenger Details</th></thead>");
  previewRowTable("Passenger Full Name", $('#firstName').val()+" "+$('#lastName').val());
  previewRowTable("Passenger Phone", $('#countryCode').val()+" "+$('#phone').val());
  previewRowTable("Passenger Email", $('#email').val());
  previewRowTable("Photoproof Front", $('#aadhaarFront').val());
  previewRowTable("Photoproof Rear", $('#aadhaarRear').val())
  previewRowTable("Message", $('#msg').val())
}

function previewRowTable(heading, value){
  $('.previewTableRows').append("<tr><th>"+heading+"</th><td>"+value+"</td></tr>");
}
