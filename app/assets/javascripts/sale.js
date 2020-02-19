$(function () {
  var categories = []
  var first_num = -1
  var second_num = -1
  var third_num = -1
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
        document.getElementById("category-first").appendChild(op);
      }
    }
  );
})