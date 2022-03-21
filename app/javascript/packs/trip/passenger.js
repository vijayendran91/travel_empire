function noOfPass(){
  return Number($('#adult').val())+Number($('#chldrn').val());
}

function processPass(){
  var value = noOfPass();
  if(value > 7){
    window.alert("Number of passengers cannot be more than 7.");
  }
  else if(value <= 0){
    window.alert("Number of passengers cannot be less than 0.");
  }
}

function showSeaterImages(value){
  if(value=='7 Seater'){
    $('#4seater').hide();
    $('#7seater').show();
  }
  else if(value=='4 Seater'){
    $('#7seater').hide();
    $('#4seater').show();
  }else if (value == 'ch') {
    window.alert("Choose a type of car you want.");
  }
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
  $('#str').on('change', function(){
    var value = $('#str').val();
    showSeaterImages(value)
  });
});
