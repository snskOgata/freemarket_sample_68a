$(function () {

  // カテゴリ一覧を保持する変数
  var categories = []
  // 大中小カテゴリごとの順番を保持
  var first_num = -1
  var second_num = -1
  var third_num = -1

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
});
