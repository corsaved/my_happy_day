$(function () {
  $('#current_user_events').click(function () {
    $('.not_current_user').toggle();
  }); 
  $('#current_user_events').attr("autocomplete", "off"); 
});
