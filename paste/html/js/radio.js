$('#setFunk').hide();
$('#disableFunk').hide();

ESX.Phone.functions.addButton("#setFunk", function(element, event) {
  if ($("#funkkanal").val()) {
    $.post(`https://${GetParentResourceName()}/SetFunk`, JSON.stringify({ channel: $('#funkkanal').val() }));
    addverlauf($('#funkkanal').val())
    ESX.Phone.functions.sendNotification("fas fa-microphone", "#fff", "Radio", "Du hast den Funkkanal "+$('#funkkanal').val()+" MHz betreten", 3000)
    $('#setFunk').fadeOut();
    $('#disableFunk').fadeIn();
  }
})

ESX.Phone.functions.addButton("#disableFunk", function(element, event) {
  $.post(`https://${GetParentResourceName()}/DisableFunk`, JSON.stringify({ channel: $('#funkkanal').val() }));
  addverlauf($('#funkkanal').val())
  ESX.Phone.functions.sendNotification("fas fa-microphone", "#fff", "Radio", "Du hast den Funkkanal "+$('#funkkanal').val()+" MHz verlassen", 3000)
  $('#setFunk').fadeIn();
  $('#disableFunk').fadeOut();
})

$('#funkkanal').on('keyup', function() {
  if ($("#funkkanal").val()) {
    $('#setFunk').fadeIn();
  } else {
    $('#setFunk').fadeOut();
  }
});

function connect(channel) {
  $.post(`https://${GetParentResourceName()}/SetFunk`, JSON.stringify({ channel: channel }));
}

function addverlauf(channel) {
  $('.scroll__container').prepend
  (`
  <div class="scroll__item" onclick="connect2('`+ channel +`')">
      <i class="fas fa-wifi"></i>
      <p><span>ID:</span> `+ channel +`</p>
  </div>
  `);
}