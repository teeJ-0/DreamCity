RegisterNetEvent("display")
AddEventHandler("display, function(argument)
    TriggerEvent("chat:addMessage","[database]", {0,0,255}, argument)
end)