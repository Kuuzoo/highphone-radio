RegisterNetEvent('High_phone:DisableFunk')
AddEventHandler('High_phone:DisableFunk', function(data)
    exports['saltychat']:RemovePlayerRadioChannel(source, data.channel)
end)