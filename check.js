 $('[data-answer]').each(function(b) {
  var $b = $(this)
    , $alert = $('<div class="alert"></div>');

  $alert.insertAfter($b).hide();
  $b.on('click', function(event) {
    event.preventDefault();

    var $input = $b.parent().find('input'), value;
    if ($input.attr('type') === 'radio') {
      value = $b.parent().find('input[checked]').val();
    } else {
      value = $input.val();
    }

    console.log(value);

    $alert.show();
    if (value.toLowerCase() === $b.attr('data-answer').toLowerCase()) {
      $alert.removeClass('alert-danger');
      $alert.addClass('alert-success');
      $alert.html('Correct!');
    } else {
      $alert.addClass('alert-danger');
      $alert.removeClass('alert-success');
      $alert.html('Incorrect<br>The correct answer is ' + $b.attr('data-answer'));
    }
  });
});