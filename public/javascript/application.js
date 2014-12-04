$(document).ready(function() {
  $('.alert').delay(2000).fadeIn(300);

  $('.fa-times-circle').click(function(){
   $(this).parent('.alert').fadeOut(300);
  });

  $('.switch').click(function(){
     $(this).children('i').toggleClass('fa-pencil');
     $('.login').animate({height: "toggle", opacity: "toggle"}, "slow");
     $('.register').animate({height: "toggle", opacity: "toggle"}, "slow");
  });
  // See: http://docs.jquery.com/Tutorials:Introducing_$(document).ready()
});

