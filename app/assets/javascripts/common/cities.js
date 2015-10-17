$(document).ready(function(){
  //LOAD CITIES BY STATE
  bindLoadCity();
});

function bindLoadCity() {
  $("#states-select").change(function(){
    loadCities($(this).val(), null);
  });
}


function loadCities(state,city_id) {
  var option = "";
  $('#cities-select').empty();
  $.getJSON("/user/states/" + state + '/cities.json',function(data){
    $('#cities-select').append('<option></option>');
    $.each(data,function(i,item){
      $('#cities-select').append('<option value="' + item.id + '">' + item.name + '</option>');  
    });
    if (city_id != null) {
      $("option[value='" + city_id + "']").attr('selected', 'selected');
    }
  });
}