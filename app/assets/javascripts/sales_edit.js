$(function () {
  // 画像用のinputを生成する関数
  function buildFileField(num){
    const html = 
    `<div class="js-file_group" data-index="${num}">
      <input class="js-file" type="file" name="sale[photos_attributes][${num}][src]" id="sale_photos_attributes_${num}_src">
     </div>`;

    return html;
  }
  // プレビュー用のimgタグを生成する関数
  function buildImg(index, url){
    const html = `<img data-index="${index}" width="100" height="100" src="${url}" />`;
    return html;
  }

  let fileIndex = [1,2,3,4,5,6,7,8,9,10];
  lastIndex = $('.js-file_group:last').data('index');

  fileIndex.splice(0, lastIndex);

  $('.hidden-destroy').hide();

  $('.image-box').on('change', '.js-file', function(e) {
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

  $('.image-box').on('click', '.js-remove', function() {
    const targetIndex = $(this).parent().data('index');
    // 該当indexを振られているチェックボックスを取得する
    const hiddenCheck = $(`input[data-index="${targetIndex}"].hidden-destroy`);
    // もしチェックボックスが存在すればチェックを入れる
    if (hiddenCheck) hiddenCheck.prop('checked', true);

    $(this).parent().remove();
    $(`img[data-index="${targetIndex}"]`).remove();

    // 画像入力欄が0個にならないようにしておく
    if ($('.js-file').length == 0) $('.image-box').append(buildFileField(fileIndex[0]));
  });
});
