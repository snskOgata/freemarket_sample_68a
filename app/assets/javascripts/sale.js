$(function () {

  // カテゴリ一覧を保持する変数
  var categories = []
  // 大中小カテゴリごとの順番を保持
  var first_num = 0
  var second_num = 0
  var third_num = 0

  // ページ遷移後にカテゴリ一覧を取得
  $.getJSON(
    '/category',
    function (data) {
      categories = data
      console.log(categories);

      for (var i = 0; i < categories.length; i++) {
        var op = document.createElement("option");
        op.value = categories[i].id;  //value値
        op.text = categories[i].name;   //テキスト値
        op.dataset.num = i
        $("#category-first").append(op);
      }
    }
  );

  // 大カテゴリに変更があれば発火
  $('#category-first').change(function () {

    var second = $('#category-second')
    var third = $('#category-third')
    second.children().remove();
    third.children().remove();
    // 選択した番号を
    first_num = $("#category-first option:selected").data("num");
    for (var i = 0; i < categories.length; i++) {
      var op = document.createElement("option");
      op.value = categories[first_num].sub[i].id;
      op.text = categories[first_num].sub[i].name;
      op.dataset.num = [i];
      second.append(op)
    }
    if (first_num !== 0) {
      second.show();
      third.hide();
    } else {
      second.hide();
      third.hide();
    }
  });

})