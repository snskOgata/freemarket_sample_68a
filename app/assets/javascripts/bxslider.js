$(function() {
  // サムネイルのサイズ
  var thumbWidth = 60;
  var thumbHeight = 60;

  // サムネイルの作成
  var insert = '';
  for (var i = 0; i < $('.bxslider li').length; i++) {
      insert += '<a data-slide-index="' + i + '" href="#"><img src="' + $('.bxslider li').eq(i).children('img').attr('src') + '" width="' + thumbWidth + '" height="' + thumbHeight + '" /></a>';
  };
  $('.custom-thumb').append(insert);

  $('.bxslider').bxSlider({
      pagerCustom: '.custom-thumb',
  });
});

