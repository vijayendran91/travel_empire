$body = $("body");
$(document).on({
    ajaxStart: function() { $body.addClass("loading");    },
    ajaxStop: function() { $body.removeClass("loading"); }
});

function getGSTDetails(gst){
  $.ajax({
    type: 'GET',
    url: "https://appyflow.in/api/verifyGST",
    data: "key_secret=XYhitWS1lrhpoKhDvyNo48d7BZL2&gstNo="+gst,
    dataType: "json",
    contentType: "application/json",
    success: function(resultData){
              if(resultData["error"]){
                alert(resultData["message"])
              }
              else{
                showGSTModal(resultData);
              }
            },
    error: function(data){
            console.log("jqXhr error"+data.status);
          }
  });
}

function showGSTModal(gstData){
  var data = gstData["taxpayerInfo"];
  var addr = data["pradr"]["addr"];
  var legal_name = data["lgnm"];
  var full_addr =  addr["bno"]+" "+addr["flno"]+" "+addr["st"]+" "+addr["loc"]+" "+addr["dst"]+" "+addr["stcd"]+"-"+addr["pncd"]
  $('#gstModal').on('show.bs.modal', function(){
    var modal = $(this);
    var gstInfo = "<h5>"+data["tradeNam"]+"</h5>";
    gstInfo += "<br><b>"+data["lgnm"]+"</b><br>Address:<br>"+addr["bno"]+" "+addr["flno"]+" "+addr["st"]+"<br> "+addr["loc"]+" "+addr["dst"]+"<br> "+addr["stcd"]+"-"+addr["pncd"];
    modal.find('.modal-body-text').html(gstInfo);

    //Hidden Fields for GST
    modal.find('.gst_lg_nm').val(legal_name);
    modal.find('.gst_full_addr').val(full_addr);
  });
  $('#gstModal').modal('show');
}

$(document).ready(function(){
  $('#gst').on('change', function(e){
    var gst = $('#gst').val();
    var gst_data = "";
    if(gst.length == 15){
      getGSTDetails(gst);
    }
  });

});
