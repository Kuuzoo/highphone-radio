// Paste this file into "html/js/radio.js"

$('#setFunk').hide();
$('#disableFunk').hide();

HR.Phone.functions.addButton("#setFunk", function(element, event) {
  if ($("#funkkanal").val()) {
    $.post(`https://${GetParentResourceName()}/SetFunk`, JSON.stringify({ channel: $('#funkkanal').val() }));
    HR.Phone.functions.sendNotification("fas fa-microphone", "#fff", "Radio", "Du hast den Funkkanal " + $('#funkkanal').val() + " MHz betreten", 3000)
    $('#setFunk').fadeOut();
    $('#disableFunk').fadeIn();
  }
})

HR.Phone.functions.addButton("#disableFunk", function(element, event) {
  $.post(`https://${GetParentResourceName()}/DisableFunk`, JSON.stringify({ channel: $('#funkkanal').val() }));
  HR.Phone.functions.sendNotification("fas fa-microphone", "#fff", "Radio", "Du hast den Funkkanal " + $('#funkkanal').val() + " MHz verlassen", 3000)
  $('#setFunk').fadeIn();
  $('#disableFunk').fadeOut();
})

$('#funkkanal').on('keyup', function () {
  if ($("#funkkanal").val()) {
    $('#setFunk').fadeIn();
  } else {
    $('#setFunk').fadeOut();
  }
});