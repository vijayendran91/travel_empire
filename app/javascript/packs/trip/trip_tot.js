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
    tor =  $(this).val();
    console.log(tor+" 1");
    switch(tor){
        case "ow":
            prepOneWay(tor);
            break;
        case "rtt":
            prepReturnTrip();
            break;
        case "rt":
            prepRoundTrip();
            break;
        case "my":
            prepMultiCity();
            break;
        case "hy":
            prepHourly();
            break;
      location.reload();
    }
  });

  function prepOneWay(tor){
    setOneWayMinTime();
    showModal(tor);
    $('#addLocation').hide();
    $('#toDistSelect').show();
    $('#locationSwap').show();
    $('#toAreaLabel').show();
    $('#toDistLabel').show();
    $('#toArea').show();
    $('.locations').hide();
    $('#totModal').show();

  }

  function prepReturnTrip(){
    showModal(tor);
    setReturnTripDT();
    $('#addLocation').hide();
    $('#toDistSelect').show();
    $('#toAreaLabel').show();
    $('#locationSwap').show();
    $('.locations').hide();
    $('#toDistLabel').show();
    $('#toArea').show();
    $('#returnDateTime').show();

  }

  function prepRoundTrip(){
    showModal(tor);
    setRoundTripDT();
    $('#addLocation').hide();
    $('#toDistSelect').show();
    $('#toAreaLabel').show();
    $('#locationSwap').show();
    $('.locations').hide();
    $('#toDistLabel').show();
    $('#toArea').show();
    $('#returnDateTime').show();
  }

  function prepMultiCity(){
    showModal(tor);
    setMultiCityDT();
    $('.locations').show();
    $('#addLocation').show();
    $('#locationSwap').hide();
    $('#toDistSelect').hide();
    $('#toAreaLabel').hide();
    $('#toDistLabel').hide();
    $('#returnDateTime').show();
    $('#toArea').hide();
  }

  function prepHourly(){
    showModal(tor);
    setHourlyDT();
    $('.locations').hide();
    $('#addLocation').hide();
    $('#locationSwap').hide();
    $('#toDistSelect').hide();
    $('#toAreaLabel').hide();
    $('#toDistLabel').hide();
    $('#toArea').hide();
    $('#returnDateTime').show();
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

});
