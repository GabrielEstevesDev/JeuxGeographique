$(document).ready(init);
var btnAccepter;
var btnRefuser;
var btnSupprimer;
var inputMail;
var confirmMail;
var inputMdp;
var confirmMdp;
var fid;

function init() {
  btnAccepter = $(".reqAccepter");
  btnRefuser = $(".reqRefuser");
  btnSupprimer = $(".supprimer");
  inputMail = $("#mail");
  confirmMail = $("#mailc");
  inputMdp = $("#nmdp");
  confirmMdp = $("#mdpc");

  $(btnAccepter).on('click', accepter);
  $(btnRefuser).on('click', decliner);
  $(btnSupprimer).on('click', supprimer);

  $(inputMail).keyup(memeMail);
  $(confirmMail).keyup(memeMail);

  $(inputMdp).keyup(memeMdp);
  $(confirmMdp).keyup(memeMdp);
}

function accepter() {
  id = $(this).attr("name");
  url = "php/acceptFriend.php";
  $.ajax({
    async: false,
    type: "POST",
    url: url,
    data: {'fid': id},
    success: function (retour) {
      fid = retour;
    },
    error: function () {
      alert("PB avec l'URL");
    },
  });
  $("#req"+fid).hide();
  location.reload(true);
}

function decliner() {
  id = $(this).attr("name");
  url = "php/rejectFriend.php";
  $.ajax({
    async: false,
    type: "POST",
    url: url,
    data: {'fid': id},
    success: function (retour) {
      fid = retour;
    },
    error: function () {
      alert("PB avec l'URL");
    },
  });
  $("#req"+fid).hide();
  location.reload(true);
}

function supprimer() {
  id = $(this).attr("name");
  url = "php/removeFriend.php";
  $.ajax({
    async: false,
    type: "POST",
    url: url,
    data: {'fid': id},
    success: function (retour) {
      fid = retour;
    },
    error: function () {
      alert("PB avec l'URL");
    },
  });
  $("#ami"+fid).hide();
  location.reload(true);
}

function memeMail() {
  if(confirmMail.val() != inputMail.val()) {
      $("#msgMailc").show();
      $("#msgMailc").text("Les mails ne correspondent pas");
      $("#submitMail").prop("disabled", true);
    } else {
      $("#msgMailc").text("");
      $("#submitMail").prop("disabled", false);
    }
}

function memeMdp() {
  if(confirmMdp.val() != inputMdp.val()) {
      $("#msgMdpc").show();
      $("#msgMdpc").text("Les mot de passe ne correspondent pas");
      $("#submitMdp").prop("disabled", true);
    } else {
      $("#msgMdpc").hide();
      $("#submitMdp").prop("disabled", false);
    }
}