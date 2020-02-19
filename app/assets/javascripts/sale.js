$(function () {

  // カテゴリ一覧を保持する変数
  var categories = []
  // 大中小カテゴリごとの順番を保持
  var first_num = -1
  var second_num = -1
  var third_num = -1

  // 画像保存に用いる変数
  var dropzone = $('.dropzone-area');
  var dropzone2 = $('.dropzone-area2');
  var images = [];
  var inputs = [];
  var input_area = $('.input_area');
  var preview = $('#preview');
  var preview2 = $('#preview2');

  // ページ遷移後にカテゴリ一覧を取得
  $.getJSON(
    '/category',
    function (data) {
      categories = data
      for (var i = 0; i < categories.length; i++) {
        var op = document.createElement("option");
        op.value = categories[i].id;
        op.text = categories[i].name;
        op.dataset.num = i
        $("#category-first").append(op);
      }
    }
  );

  // 大カテゴリに変更があれば発火
  $('#category-first').change(function () {
    // 子要素・孫要素を削除
    second_num = -1;
    third_num = -1;
    var second = $('#category-second');
    var third = $('#category-third');
    second.children().remove();
    third.children().remove();
    // 選択した番号を保持
    first_num = $("#category-first option:selected").data("num");
    for (var i = 0; i < categories[first_num].sub.length; i++) {
      var op = document.createElement("option");
      op.value = categories[first_num].sub[i].id;
      op.text = categories[first_num].sub[i].name;
      op.dataset.num = [i];
      second.append(op);
    }
    if (first_num !== 0) {
      second.show();
      third.hide();
    } else {
      second.hide();
      third.hide();
    }
  });

  // 中カテゴリに変更があれば発火
  $('#category-second').change(function () {
    // 子要素を削除
    var third = $('#category-third')
    third.children().remove();
    // 選択した番号を保持
    second_num = $("#category-second option:selected").data("num");
    for (var i = 0; i < categories[first_num].sub[second_num].sub.length; i++) {
      var op = document.createElement("option");
      op.value = categories[first_num].sub[second_num].sub[i].id;
      op.text = categories[first_num].sub[second_num].sub[i].name;
      third.append(op);
    }
    if (second_num !== 0) {
      third.show();
    } else {
      third.hide();
    }
    third_num = -1;
  });

  // 小カテゴリに変更があれば発火
  $('#category-third').change(function () {
    // 選択した番号を保持
    third_num = $("#category-third option:selected").data("num");
  })

  // 出品ボタンを押した時に、カテゴリを選択していないと忠告する
  $('#submit-sale').on("click", function (e) {
    if ((first_num < 1) || (second_num < 1) || (third_num < 1)) {
      e.preventDefault();
      alert('カテゴリは全て入力してください')
    }
  })

  // 画像を選択したときのアクション
  $(document).on('change', 'input[type= "file"].upload-image', function (event) {
    var file = $(this).prop('files')[0];
    var reader = new FileReader();
    inputs.push($(this));
    var img = $(`<div class= "img_view"><img></div>`);
    reader.onload = function (e) {
      var btn_wrapper = $('<div class="btn_wrapper"><div class="btn edit">編集</div><div class="btn delete">削除</div></div>');
      img.append(btn_wrapper);
      img.find('img').attr({
        src: e.target.result
      })
    }
    reader.readAsDataURL(file);
    images.push(img);

    if (images.length >= 5) {
      dropzone2.css({
        'display': 'block'
      })
      dropzone.css({
        'display': 'none'
      })
      $.each(images, function (index, image) {
        image.attr('data-image', index);
        preview2.append(image);
        dropzone2.css({
          'width': `calc(100% - (135px * ${images.length - 5}))`
        })
      })
      if (images.length == 9) {
        dropzone2.find('p').replaceWith('<i class="fa fa-camera"></i>')
      }
    } else {
      $('#preview').empty();
      $.each(images, function (index, image) {
        image.attr('data-image', index);
        preview.append(image);
      })
      dropzone.css({
        'width': `calc(100% - (135px * ${images.length}))`
      })
    }
    if (images.length == 4) {
      dropzone.find('p').replaceWith('<i class="fa fa-camera"></i>')
    }
    if (images.length == 10) {
      dropzone2.css({
        'display': 'none'
      })
      return;
    }
    var new_image = $(`<input multiple= "multiple" name="sale_photos[image][]" class="upload-image" data-image= ${images.length} type="file" id="upload-image">`);
    input_area.prepend(new_image);
  });
  $(document).on('click', '.delete', function () {
    var target_image = $(this).parent().parent();
    $.each(inputs, function (index, input) {
      if ($(this).data('image') == target_image.data('image')) {
        $(this).remove();
        target_image.remove();
        var num = $(this).data('image');
        images.splice(num, 1);
        inputs.splice(num, 1);
        if (inputs.length == 0) {
          $('input[type= "file"].upload-image').attr({
            'data-image': 0
          })
        }
      }
    })
    $('input[type= "file"].upload-image:first').attr({
      'data-image': inputs.length
    })
    $.each(inputs, function (index, input) {
      var input = $(this)
      input.attr({
        'data-image': index
      })
      $('input[type= "file"].upload-image:first').after(input)
    })
    if (images.length >= 5) {
      dropzone2.css({
        'display': 'block'
      })
      $.each(images, function (index, image) {
        image.attr('data-image', index);
        preview2.append(image);
      })
      dropzone2.css({
        'width': `calc(100% - (135px * ${images.length - 5}))`
      })
      if (images.length == 9) {
        dropzone2.find('p').replaceWith('<i class="fa fa-camera"></i>')
      }
      if (images.length == 8) {
        dropzone2.find('i').replaceWith('<p>ココをクリックしてください</p>')
      }
    } else {
      dropzone.css({
        'display': 'block'
      })
      $.each(images, function (index, image) {
        image.attr('data-image', index);
        preview.append(image);
      })
      dropzone.css({
        'width': `calc(100% - (135px * ${images.length}))`
      })
    }
    if (images.length == 4) {
      dropzone2.css({
        'display': 'none'
      })
    }
    if (images.length == 3) {
      dropzone.find('i').replaceWith('<p>ココをクリックしてください</p>')
    }
  })
})