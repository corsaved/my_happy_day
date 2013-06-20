$(function () {
  $('#current_user_events').click(function () {
    $('.not_current_user').toggle();
  }); 
  
  $('#recurring_event').click(function () {
    $('.period').toggle();
  }); 
 
  $('#current_user_events').attr("autocomplete", "off");

  $('.date').datepicker({
    dateFormat: 'yy-mm-dd'
  });

  if($('#recurring_event').attr('checked')!='checked') {
    $('.period').hide(); 
  }
});
