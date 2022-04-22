let json_data = JSON.stringify(data);
let districts_data = JSON.parse(json_data)["districts"];
$(document).ready(function(){

  for(let i=0; i<districts_data.length;i++){
    $("#fromDistSelect").append('<option value="'+districts_data[i]+'">' + districts_data[i] + '</option>');
    $("#toDistSelect").append('<option value="'+districts_data[i]+'">' + districts_data[i] + '</option>');
  }
});
