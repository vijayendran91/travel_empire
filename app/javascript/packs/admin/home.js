$(document).ready(function(){
  var password = prompt("Enter admin password");
  let json_data = JSON.stringify(admin_password);
  let user_pwd = JSON.parse(json_data)["pwd"];
  
  if(password == user_pwd){
    $('#admin_container').show();
  }else{
    location.reload(); 
  }
});
