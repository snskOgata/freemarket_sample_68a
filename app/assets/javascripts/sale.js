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
    if (first_num !== 0) {
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

})