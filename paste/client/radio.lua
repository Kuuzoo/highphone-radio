ESX = exports['es_extended']:getSharedObject();

local funkTask = nil
local currentFunk = ""

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if funkTask ~= nil and currentFunk ~= "" then
            if funkTask == "volup" then
                local curVolume = exports['saltychat']:GetRadioVolume() + 0.1
                if curVolume > 1.6 or curVolume < 0.0 then
                    curVolume = curVolume - 0.1
                end
                ESX.ShowHelpNotification("Funklautstärke: " .. ESX.Math.Round(curVolume * 100) .. " %")
                exports['saltychat']:SetRadioVolume(curVolume)
            elseif funkTask == "voldown" then
                local curVolume = exports['saltychat']:GetRadioVolume() - 0.1
                if curVolume > 1.6 or curVolume < 0.0 then
                    curVolume = curVolume + 0.1
                end
                ESX.ShowHelpNotification("Funklautstärke: " .. ESX.Math.Round(curVolume * 100) .. " %")
                exports['saltychat']:SetRadioVolume(curVolume)
            elseif funkTask == "funkup" then
                currentFunk = (tostring(tonumber(currentFunk) + 0.1))
                currentFunk = currentFunk:gsub("%.0", "")
                ESX.ShowHelpNotification("Funkkanal: " .. currentFunk .. " MHz")
                exports['saltychat']:SetRadioChannel(currentFunk, true)
            elseif funkTask == "funkdown" then
                currentFunk = (tostring(tonumber(currentFunk) - 0.1))
                currentFunk = currentFunk:gsub("%.0", "")
                ESX.ShowHelpNotification("Funkkanal: " .. currentFunk .. " MHz")
                exports['saltychat']:SetRadioChannel(currentFunk, true)
            end
            funkTask = nil
        end
    end
end)

RegisterNUICallback('DisableFunk', function(data, cb)
    currentFunk = ""
    exports['saltychat']:SetRadioChannel("", true)
    TriggerServerEvent('High_phone:DisableFunk', data)
    cb('ok')
end)

RegisterNUICallback('SetFunk', function(data, cb)
    currentFunk = (tostring(tonumber(data.channel)))
    currentFunk = currentFunk:gsub("%.0", "")
    exports['saltychat']:SetRadioChannel(currentFunk, true)
    cb('ok')
end)

RegisterCommand('incfunk', function() funkTask = "funkup" end, false)
RegisterCommand('decfunk', function() funkTask = "funkdown" end, false)
RegisterCommand('volfunkup', function() funkTask = "volup" end, false)
RegisterCommand('volfunkdown', function() funkTask = "voldown" end, false)
RegisterKeyMapping("incfunk", "Funkkanal erhöhen (+0.1)", 'keyboard', 'ADD')
RegisterKeyMapping("decfunk", "Funkkanal senken (-0.1)", 'keyboard', 'SUBTRACT')
RegisterKeyMapping("volfunkup", "Funklautstärke erhöhen", 'keyboard', 'MULTIPLY')
RegisterKeyMapping("volfunkdown", "Funklautstärke senken", 'keyboard', 'DIVIDE')