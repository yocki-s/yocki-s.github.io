$(function () {
  // Sandbox URL
  Veritrans.url = "https://api.sandbox.veritrans.co.id/v2/token";
  // TODO: Change with your client key.
  Veritrans.client_key = "572d0483-1f8f-4b91-81fb-e215b856a087";
  var card = function () {
    return {
      "card_number": $(".card-number").val(),
      "card_exp_month": $(".card-expiry-month").val(),
      "card_exp_year": $(".card-expiry-year").val(),
      "card_cvv": $(".card-cvv").val(),
      "secure": false,
      "gross_amount": 200000
    }
  };

  function callback(response) {
    console.log(response.token_id);
    $("#token_result").html(response.token_id);

    console.log(response);
    if (response.redirect_url) {
      console.log("3D SECURE");
      // 3D Secure transaction, please open this popup
      openDialog(response.redirect_url);

    }
    else if (response.status_code == "200") {
      console.log("NOT 3-D SECURE");
      // Success 3-D Secure or success normal
      closeDialog();
      // Submit form
      $("#token_id").val(response.token_id);
      // $("#payment-form").submit();
    }
    else {
      // Failed request token
      console.log(response.status_code);
      alert(response.status_message);
    }
  }

  function openDialog(url) {
    $.fancybox.open({
      href: url,
      type: "iframe",
      autoSize: false,
      width: 700,
      height: 500,
      closeBtn: false,
      modal: true
    });
  }

  function closeDialog() {
    $.fancybox.close();
  }

  $(".submit-button").click(function (event) {
    console.log("SUBMIT");
    event.preventDefault();
    Veritrans.token(card, callback);
    return false;
  });
});
