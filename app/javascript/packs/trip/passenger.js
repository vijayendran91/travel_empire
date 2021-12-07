function noOfPass(){
  return Number($('#adult').val())+Number($('#chldrn').val());
}

function processPass(){
  var value = noOfPass();
  var returnval = "";
  if(value > 7){
    window.alert("Number of passengers cannot be more than 7");
  }
  else if(value <= 0){
    window.alert("Number of passengers cannot be less than 0");
  }
  else if(value > 4 && value <= 7){
    $('#4seater').hide();
    $('#7seater').show();
    $('#str').find('.str').val("7 Seater");
  }
  else if(value <=4 && value >0){
    $('#7seater').hide();
    $('#4seater').show();
    $('#str').find('.str').val("4 Seater");
  }
  return returnval;
}

function passValid(){
  var value = processPass();
  var returnvalue = false;
  if(value.length > 0){
    returnValue = true;
  }
  return ;
}

$(document).ready(function(){
  $('#adult,#chldrn').on('change', function(){
    var value = processPass();
  });
});
