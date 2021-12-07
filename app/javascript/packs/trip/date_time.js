let ist = null;

export function setOneWayMinTime(){
  var ist = getIST();
  var dist = new Date(ist);
  var owmt = stringTime(dist);
  var tob = typeOfBooking();
  var start_min_time = null;
  var start_max_time = null;  
  switch(tob){
    case "bn":
         start_min_time = addHoursToCT(owmt, 1);
         start_max_time = addHoursToCT(start_min_time, 8)
         $('#BookingTime').attr('min',stringTime(start_min_time));
         $('#BookingTime').attr('max',stringTime(start_max_time));
         break;
     case "ab":
         start_min_time = addHoursToCT(owmt, 1);
         $('#BookingTime').attr('min',stringTime(start_min_time));
         $('#BookingTime').attr('max',"");
         break;
     case "tb":
         start_min_time = addHoursToCT(owmt, 1);
         start_max_time = addDaysToCD(start_min_time, 7)
         $('#BookingTime').attr('min',stringTime(start_min_time));
         $('#BookingTime').attr('max',stringTime(start_max_time));
         break;
  }   

}

function getIST(){
  var d1 = new Date(stringUTCTime(new Date()));
  d1.setHours(d1.getHours()+5);
  d1.setMinutes(d1.getMinutes()+30);
  ist = stringTime(new Date(d1));
  return ist
}

function getUTCTime(d){
  var year = d.getUTCFullYear()
  var month = (d.getUTCMonth()+1) < 10 ? "0"+(d.getUTCMonth()+1) : (d.getUTCMonth()+1);
  var day = d.getUTCDate() < 10 ? "0"+d.getUTCDate() : d.getUTCDate();
  var hour = d.getUTCHours() < 10 ? "0"+d.getUTCHours() : d.getUTCHours();
  var min = d.getUTCMinutes() < 10 ? "0"+d.getUTCMinutes() : d.getUTCMinutes();
  return [year, month, day, hour, min];
}

function getTime(d){
  var year = d.getFullYear()
  var month = (d.getMonth()+1) < 10 ? "0"+(d.getMonth()+1) : (d.getMonth()+1);
  var day = d.getDate() < 10 ? "0"+d.getDate() : d.getDate();
  var hour = d.getHours() < 10 ? "0"+d.getHours() : d.getHours();
  var min = d.getMinutes() < 10 ? "0"+d.getMinutes() : d.getMinutes();
  return [year, month, day, hour, min];
}


//returns UTC time in YY:MM::DDThh:mm format for html
function stringUTCTime(d){
  var date_time_arr = getUTCTime(d);
  return stringifyTime(date_time_arr[0],date_time_arr[1],date_time_arr[2],date_time_arr[3],date_time_arr[4]);
}



function stringTime(d){
  var date_time_arr = getTime(d);
  return stringifyTime(date_time_arr[0],date_time_arr[1],date_time_arr[2],date_time_arr[3],date_time_arr[4]);
}

function stringifyTime(year, month, day, hour, min){
  return year+"-"+month+"-"+day+"T"+hour+":"+min;
}

function typeOfBooking(){
  var returnVal = "";
  if($('#bookNow').is(':checked')){
    returnVal = "bn"
  }else if($('#advanceBooking').is(':checked')){
    returnVal = "ab"
  }else if($('#tentativeBooking').is(':checked')){
    returnVal = "tb"
  }
  return returnVal;
}


function addHoursToCT(time, hours){
  var temp = new Date(time);
  temp = temp.setHours(temp.getHours()+hours);
  return (new Date(temp));
}

function addDaysToCD(time, days){
  var temp = new Date(time);
  temp = temp.setDate(temp.getDate()+days);
  return (new Date(temp));
}


$(document).ready(function(){
  setIST();
  function setIST(){
    $('#returnBookingTime, #BookingTime').val(getIST());
  }
<<<<<<< HEAD

  $('#BookingTime').on('change', function(e){
    
  });

=======
>>>>>>> 5fb2ab8ee573e5aa548cc55d5a464288bc04e074
});
