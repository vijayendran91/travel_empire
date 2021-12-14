import {setOneWayMinTime} from './date_time.js'
import {setRoundTripDT} from './date_time.js'
import {setReturnTripDT} from './date_time.js'
import {setMultiCityDT} from './date_time.js'
import {setHourlyDT} from './date_time.js'
let tor = "";
let json_data = JSON.stringify(data);
let modal_texts = JSON.parse(json_data)["modaltexts"];
$(document).ready(function(){

  $( "#inlineFormCustomSelect" ).change(function() {
    typeOfTrip(true);
  });

});


export function typeOfTrip(showModal){
  tor =  $('#inlineFormCustomSelect').val();
  switch(tor){
    case "ow":
      prepOneWay(tor, showModal);
      break;
    case "rtt":
      prepReturnTrip(tor, showModal);
      break;
    case "rt":
      prepRoundTrip(tor, showModal);
      break;
    case "my":
      prepMultiCity(tor, showModal);
      break;
    case "hy":
      prepHourly(tor, showModal);
      break;
  }
}

 function prepOneWay(tor, modal){
    setOneWayMinTime();
    if(modal){
      showModal(tor);
    }
    $('#addLocation').hide();
    $('#toDistSelect').show();
    $('#locationSwap').show();
    $('#toAreaLabel').show();
    $('#toDistLabel').show();
    $('#toArea').show();
    $('.locations').hide();
    $('#roundtripDest').hide();
    $('#returnDateTime').hide();
  }

  function prepReturnTrip(tor, modal){
   if(modal){
      showModal(tor);
    }
    setReturnTripDT();
    $('#addLocation').hide();
    $('#toDistSelect').show();
    $('#toAreaLabel').show();
    $('#locationSwap').show();
    $('.locations').hide();
    $('#toDistLabel').show();
    $('#toArea').show();
    $('#returnDateTime').show();
    $('#roundtripDest').hide();
  }

  function prepRoundTrip(tor, modal){
    if(modal){
      showModal(tor);
    }
    setRoundTripDT();
    $('.locations').show();
    $('#addLocation').show();
    $('#locationSwap').hide();
    $('#toDistSelect').hide();
    $('#toAreaLabel').hide();
    $('#toDistLabel').hide();
    $('#returnDateTime').show();
    $('#toArea').hide();
    $('#roundtripDest').show();
  }

  function prepMultiCity(tor, modal){
    if(modal){
      showModal(tor);
    }
    setMultiCityDT();
    $('.locations').show();
    $('#addLocation').show();
    $('#locationSwap').hide();
    $('#toDistSelect').hide();
    $('#toAreaLabel').hide();
    $('#toDistLabel').hide();
    $('#returnDateTime').show();
    $('#toArea').hide();
    $('#roundtripDest').hide();
  }

  function prepHourly(tor, modal){
    if(modal){
      showModal(tor);
    }
    setHourlyDT();
    $('.locations').hide();
    $('#addLocation').hide();
    $('#locationSwap').hide();
    $('#toDistSelect').hide();
    $('#toAreaLabel').hide();
    $('#toDistLabel').hide();
    $('#toArea').hide();
    $('#returnDateTime').show();
    $('#roundtripDest').hide();
  }


  function showModal(tor){
    $('#totModal').on('show.bs.modal', function(event){
      var modal = $(this);
      var list_string = "<ul>";
      console.log(tor);
      modal.find('.modal-title').text(modal_texts[tor]['title']);
      for(var item in modal_texts[tor]){
      if(item != "title"){
          if(item == 'red'){
              list_string += "<li class='modal-list-red'>"+modal_texts[tor][item]+"</li>"
            }
            else{
              list_string += "<li>"+modal_texts[tor][item]+"</li>"
            }
        }
      }
      list_string+="</ul>"
      modal.find('.modal-body-text').html(list_string);
      modal.find('.modal-body-image').html("<img src='/assets/"+tor+".png' class='modal-image'/>")
    });
    $('#totModal').modal('show');
  }
