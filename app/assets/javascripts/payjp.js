$(document).on("DOMContentLoaded", function() {
  Payjp.setPublicKey('pk_test_60016bef2aecfbb50ebb65e4');
  $(document).on("click", "#token_submit", function(e) {
    e.preventDefault();
    let card = {
        number: $("#card_number").val(),
        cvc: $("#cvc").val(),
        exp_month: $("#exp_month").val(),
        exp_year: $("#exp_year").val(),
    };
    Payjp.createToken(card,function(status,response){
      if(status == 200){
        $("#card_number").removeAttr("name");
        $("#cvc").removeAttr("name");
        $("#exp_month").removeAttr("name");
        $("#exp_year").removeAttr("name");
        $("#card_token").append(
          $('<input type="hidden" name="payjp-token">').val(response.id));
        document.inputForm.submit();
        alert("登録が完了しました");
      }else{
        alert("カード情報が正しくありません。");
      }
    });
  });
});