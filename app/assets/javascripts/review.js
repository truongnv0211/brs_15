var set_ratings = function(form_id, ratings){
  for(i=1; i<=5; i++){
    if(i <= ratings){
      $('#' + form_id + '_' +i).addClass('on');
    }else{
      $('#' + form_id + '_' +i).removeClass('on');
    }
  }
}

$(function(){
  $('.rating_star').click(function(){
    var rating = $(this);
    var form_id = $(this).attr('data-form-id');
    var ratings = $(this).attr('data-rating');

    set_ratings(form_id, ratings);

    $('#' + form_id).val(ratings);
  });
});

$(document).on("click", "#create-review", function(){
  $("#review-form").show();
})

$(document).ready(function(){

  $(document).bind('ajaxError', 'form#edit_review', function(event, jqxhr, settings, exception){
    $(event.data).render_form_errors( $.parseJSON(jqxhr.responseText) );
  });
});

(function($) {
  $.fn.modal_success = function(){
    this.modal('hide');
    this.find('form input[type="text"]').val('');
    this.clear_previous_errors();
  };

  $.fn.render_form_errors = function(errors){
    $form = this;
    this.clear_previous_errors();
    model = this.data('model');
    $.each(errors, function(field, messages){
      $input = $('input[name="' + model + '[' + field + ']"]');
      $input.closest('.form-group').addClass('has-error').find('.help-block').html( messages.join(' & ') );
    });

  };

  $.fn.clear_previous_errors = function(){
    $('.form-group.has-error', this).each(function(){
      $('.help-block', $(this)).html('');
      $(this).removeClass('has-error');
    });
  }

}(jQuery));
