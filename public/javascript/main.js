DiffChecker = {
  initialize: function() {
    DiffChecker.left_result = $("#left_result");
    DiffChecker.right_result = $("#right_result");
    DiffChecker.left_text_area = $("#left_text_area");
    DiffChecker.right_text_area = $("#right_text_area");
    DiffChecker.diff = $("#diff");
    DiffChecker.edit = $("#edit");

    DiffChecker.showTextAreas();
    DiffChecker.diff.click(DiffChecker.postText);
    DiffChecker.edit.click(DiffChecker.showTextAreas)
  },

  showTextAreas: function() {
    DiffChecker.left_result.hide();
    DiffChecker.right_result.hide();
    DiffChecker.left_text_area.show();
    DiffChecker.right_text_area.show();
    DiffChecker.diff.show();
    DiffChecker.edit.hide();
  },

  hideTextAreas: function() {
    DiffChecker.left_result.show();
    DiffChecker.right_result.show();
    DiffChecker.left_text_area.hide();
    DiffChecker.right_text_area.hide();
    DiffChecker.diff.hide();
    DiffChecker.edit.show();
  },

  postText: function() {
    $.post("/", {
      left: DiffChecker.left_text_area.val(),
      right: DiffChecker.right_text_area.val()
    }, function(data) {
      var dataObject = eval(data);
      DiffChecker.left_result.html(dataObject.left);
      DiffChecker.right_result.html(dataObject.right);
      DiffChecker.hideTextAreas();
    },
      "json"
    );
  }
};

$(document).ready(DiffChecker.initialize);