$(document).on('ready page:load', function (){
  jQuery(function($){
    setFieldMasks();
  });
});

function setFieldMasks() {
  $('input[id*="date"]').mask("99/99/9999");
  $('input[id*="value"]').priceFormat({ prefix: '', centsSeparator: ',', thousandsSeparator: '.',centsLimit:2});    
}