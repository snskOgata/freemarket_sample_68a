$(function () {

  if ((/\/sales\/\d+\/edit/).test(location.pathname)) {
    // 商品情報を入れる
    sale_id = location.pathname.replace(/[^0-9]/g, '');
    sale_photos = []
    sale_categories = []

    // カテゴリ一覧を保持する変数
    var categories = []
    // 大中小カテゴリごとの順番を保持
    var first_num = -1
    var second_num = -1
    var third_num = -1

    // 画像編集・保存に用いる変数
    var dropzone = $('.dropzone-area');
    var dropzone2 = $('.dropzone-area2');
    var images = []; //画像ひとつひとつを表示するためのdiv要素を保持
    var inputs = [];
    var input_area = $('.input_area');
    var preview = $('#preview');
    var preview2 = $('#preview2');

    // 商品情報を取得
    $.getJSON(
      `/sales/${sale_id}`,
      function (data) {
        sale_photos = data.photos
        // 画像表示と各種操作のための準備
        $.each(sale_photos, function (i, photo) {
          // 表示用の要素を追加
          var img = $(`<div class= "img_view" data-image= ${i}><div class="img_box"><img></div></div>`);
          var btn_wrapper = $('<div class="btn_wrapper"><div class="delete-img-btn">削除</div></div>');
          img.append(btn_wrapper)
          img.find('img').attr({
            src: photo.image.url
          })
          images.push(img)
          // 送信データ用の要素を追加
          var input = `<input name="sale[photos_attributes][${i}][image]" class="upload-image" data-image="${i}" type="file" id="sale_photos_attributes_${i}_image" >`
          var checkbox = `<input type="checkbox" name="product[images_attributes][${i}][_destroy]" class="hidden-destroy" data-image="${i}" type="hidden">`
          input_area.append(input)
          input_area.append(checkbox)
        })
        sale_categories = data.categories
        $("#loading").hide()
        $(".please_click").show()
        redrawImages()

        // 新しいインプットフィールドを追加
        var new_image = $(`<input name="sale[photos_attributes][${images.length}][image]" class="upload-image" data-image= ${images.length} type="file" id="sale_photos_attributes_${images.length}_image">`);
        input_area.append(new_image);
        $.each($(".dropzone-box"), function (index, elem) {
          elem.htmlFor = `sale_photos_attributes_${images.length}_image`
        })
      }
    )
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

        // 対象の大カテゴリを選択、中カテゴリを作成
        $.each($("#category-first").children(), function (i, opt) {
          if (opt.value == sale_categories[0].id) {
            opt.selected = true
          }
        })
        first_num = $("#category-first option:selected").data("num");
        for (var i = 0; i < categories[first_num].sub.length; i++) {
          var op = document.createElement("option");
          op.value = categories[first_num].sub[i].id;
          op.text = categories[first_num].sub[i].name;
          op.dataset.num = [i];
          $('#category-second').append(op);
        }

        $.each($("#category-second").children(), function (i, opt) {
          if (opt.value == sale_categories[1].id) {
            opt.selected = true
          }
        })
        second_num = $("#category-second option:selected").data("num");
        for (var i = 0; i < categories[first_num].sub[second_num].sub.length; i++) {
          var op = document.createElement("option");
          op.value = categories[first_num].sub[second_num].sub[i].id;
          op.text = categories[first_num].sub[second_num].sub[i].name;
          $('#category-third').append(op);
        }

        $.each($("#category-third").children(), function (i, opt) {
          if (opt.value == sale_categories[2].id) {
            opt.selected = true
          }
        })
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
      // 子要素のカテゴリをセット
      for (var i = 0; i < categories[first_num].sub.length; i++) {
        var op = document.createElement("option");
        op.value = categories[first_num].sub[i].id;
        op.text = categories[first_num].sub[i].name;
        op.dataset.num = [i];
        second.append(op);
      }
      // 中小カテゴリの表示・非表示
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
      third_num = -1;
      var third = $('#category-third')
      third.children().remove();
      // 選択した番号を保持
      second_num = $("#category-second option:selected").data("num");
      // 子要素のカテゴリをセット
      for (var i = 0; i < categories[first_num].sub[second_num].sub.length; i++) {
        var op = document.createElement("option");
        op.value = categories[first_num].sub[second_num].sub[i].id;
        op.text = categories[first_num].sub[second_num].sub[i].name;
        third.append(op);
      }
      // 小カテゴリの表示・非表示
      if (second_num !== 0) {
        third.show();
      } else {
        third.hide();
      }
    });

    // 小カテゴリに変更があれば発火
    $('#category-third').change(function () {
      // 選択した番号を保持
      third_num = $("#category-third option:selected").data("num");
    })


    // 画像用のinputを生成する関数
    function buildFileField(num) {
      const html =
        `<div class="js-file_group" data-index="${num}">
        <input class="js-file" type="file" name="sale[photos_attributes][${num}][src]" id="sale_photos_attributes_${num}_src">
        <div class="js-edit">編集</div>
        <div class="js-remove">削除</div>
      </div>`;

      return html;
    }
    // プレビュー用のimgタグを生成する関数
    function buildImg(index, url) {
      const html = `<img data-index="${index}" width="100" height="100" src="${url}" />`;
      return html;
    }

    let fileIndex = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
    lastIndex = $('.js-file_group:last').data('index');

    fileIndex.splice(0, lastIndex);

    $('.hidden-destroy').hide();

    $('.image-box').on('change', '.js-file', function (e) {
      const targetIndex = $(this).parent().data('index');
      const file = e.target.files[0];
      const blobUrl = window.URL.createObjectURL(file);

      // 該当indexを持つimgがあれば取得して変数imgに入れる(画像変更の処理)
      if (img = $(`img[data-index="${targetIndex}"]`)[0]) {
        img.setAttribute('src', blobUrl);

      } else {  // 新規画像追加の処理
        const html = buildImg(targetIndex, blobUrl)
        $('.previews').append(html);

        // fileIndexの先頭の数字を使ってinputを作る
        const inputHTML = buildFileField(fileIndex[0])
        $('.dropzone-box')[0].htmlFor = `sale_photos_attributes_${fileIndex[0]}_src`
        $('.image-box').append(inputHTML);
        fileIndex.shift();
        // 末尾の数に1足した数を追加する
        fileIndex.push(fileIndex[fileIndex.length - 1] + 1);
      }
    });

    $('.image-box').on('click', '.js-remove', function () {
      const targetIndex = $(this).parent().data('index');
      // 該当indexを振られているチェックボックスを取得する
      const hiddenCheck = $(`input[data-index="${targetIndex}"].hidden-destroy`);
      // もしチェックボックスが存在すればチェックを入れる
      if (hiddenCheck) {
        hiddenCheck.prop('checked', true);
      }
      // 条件分岐が必要 該当イメージがある場合のみ消す
      isExistImage = $(`img[data-index="${targetIndex}"]`).length;
      if (isExistImage == 1) {
        $(this).parent().remove();
        $(`img[data-index="${targetIndex}"]`).remove();
      }

      // 画像入力欄が0個にならないようにしておく
      if ($('.js-file').length == 0) $('.image-box').append(buildFileField(fileIndex[0]));
    });

    // 投稿画像たちを再描画するメソッド
    function redrawImages() {
      if (images.length <= 4) {
        $('#preview').empty();
        $.each(images, function (index, image) {
          image.data('image', index);
          preview.append(image);
        })
        dropzone.css({
          display: "block",
          width: `calc(100% - (20% * ${images.length}))`

        })
        dropzone2.css({
          display: "none"
        });
        // 画像が５枚のとき１段目の枠を消し、２段目の枠を出す
      } else if (images.length == 5) {
        $("#preview").empty();
        $.each(images, function (index, image) {
          image.data("image", index);
          preview.append(image);
        });
        dropzone2.css({
          display: "block",
          width: '100%'
        });
        dropzone.css({
          display: "none"
        });
        preview2.empty();

        // 画像が６枚以上のとき
      } else if (images.length >= 6) {
        // １〜５枚目の画像を抽出
        var pickup_images1 = images.slice(0, 5);

        // １〜５枚目を１段目に表示
        $('#preview').empty();
        $.each(pickup_images1, function (index, image) {
          image.data('image', index);
          preview.append(image);
        })

        // ６枚目以降の画像を抽出
        var pickup_images2 = images.slice(5);

        // ６枚目以降を２段目に表示
        $.each(pickup_images2, function (index, image) {
          image.data('image', index + 5);
          preview2.append(image);
        })

        dropzone.css({
          'display': 'none'
        })
        dropzone2.css({
          'display': 'block',
          'width': `calc(100% - (20% * ${images.length - 5}))`
        })

        // 画像が１０枚になったら枠を消す
        if (images.length == 10) {
          dropzone2.css({
            display: "none"
          });
        }
      }
    }
  }
});
