let json_data = JSON.stringify(data);
let cc_data = JSON.parse(json_data)['codes'];
$(document).ready(function(){
  for(let i=0; i<cc_data.length;i++){
    console.log(cc_data[i])
    $("#countryCode").append('<option value="'+cc_data[i]['dial_code']+'">'+cc_data[i]['dial_code']+"\t\t\t\t"+cc_data[i]['flag']+"  "+cc_data[i]['name']+"</option>");
  }
  $("#countryCode option[value='+91']").attr("selected","selected");
});
