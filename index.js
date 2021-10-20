
let porb = "";
  let tor = "";
  let locs = 0;
  $(document).ready(function(){
    $('.perOrBus').hide();
    $('#addLocation').hide();
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

    $('#inlineFormCustomSelect').on('click', function()
    {
        tor =  $('#inlineFormCustomSelect :selected').text()
        switch(tor){
            case "One Way":
                $('#addLocation').hide();
                $('#toLocation').show();
                $('#locationSwap').show();
                $('.locations').hide();
                break;
            case "Return Trip":
                $('#addLocation').hide();
                $('#locationSwap').show();
                $('.locations').hide();
                break;
            case "Round Trip":
                $('.locations').show(); 
                $('#addLocation').show();
                $('#locationSwap').hide();
                $('#toLocation').hide();
                break;
            case "Multi Way":
                $('.locations').show(); 
                $('#addLocation').show();
                $('#locationSwap').hide();
                $('#toLocation').hide();
                break;
            case "Hourly":
                $('.locations').hide();                
                $('#addLocation').hide();
                $('#locationSwap').hide();
                $('#toLocation').hide();
                break;
        }
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
  });
