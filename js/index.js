$(document).ready(function() {
  $(".lets.go.button").on('click', function(event) {
    $('html, body').animate({
      scrollTop: $(".features").offset().top
    }, 1000);
    event.preventDefault();
  });

  $(".masthead .browser.window")
    .transition({
      animation: 'scale',
      duration: '2s'
    })
  ;

  $(".description.column").not(".code")
    .visibility({
      onBottomVisible: function(calculations) {
        $(this).transition({
          animation: 'fade right',
          duration: '2s'
        });
      }
    })
  ;
  $(".description.column.code")
    .visibility({
      onBottomVisible: function(calculations) {
        $(this).transition({
          animation: 'fade left',
          duration: '2s'
        });
      }
    })
  ;

  $(".feature.column").not(".code")
    .visibility({
      onTopVisible: function(calculations) {
        $(this).transition({
          animation: 'fade left',
          duration: '2s'
        });
      }
    })
  ;

  $(".feature.column.code")
    .visibility({
      onTopVisible: function(calculations) {
        $(this).transition({
          animation: 'fade right',
          duration: '2s'
        });
      }
    })
  ;

  $(".first.column")
    .visibility({
      onTopVisible: function(calculations) {
        $(this).transition({
          animation: 'fade down',
          duration: '2s',
          onComplete: function() {
            $(".second.column").transition({
              animation: 'fade down',
              duration: '2s',
              onComplete: function() {
                $(".third.column").transition({
                  animation: 'fade down',
                  duration: '2s'
                });
              }
            });
          }
        });
      }
    })
  ;

  $(".resources a").fadeTo(400, 0.6);
  $(".resources a").hover(function() {
    $(this).stop().fadeTo(400, 1);
  }, function() {
    $(this).stop().fadeTo(400, 0.6);
  });
});
