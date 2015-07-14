$(function(){
  $('.rating_star').click(function(){
    var rating = $(this);
    var form_id = $(this).attr('data-form-id');
    var ratings = $(this).attr('data-rating');

    for(i=1; i<=5; i++){
      if(i <= ratings){
        $('#' + form_id + '_' +i).addClass('on');
      }else{
        $('#' + form_id + '_' +i).removeClass('on');
      }
    }

    $('#' + form_id).val(ratings)
  });
});

$(document).on("click", "#create-review", function(){
  $("#review-form").show();
})
