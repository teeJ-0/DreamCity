RegisterNetEvent("radialmenu:doors", function(doorId)
    local vehicle = GetVehiclePedIsIn(PlayerPedId(),false)
    if GetVehicleDoorAngleRatio(vehicle, tonumber(doorId)) > 0.1 then
        SetVehicleDoorShut(vehicle, tonumber(doorId), false)
    else
        SetVehicleDoorOpen(vehicle, tonumber(doorId), false, false)
    end
end)