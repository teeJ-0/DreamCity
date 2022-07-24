Citizen.CreateThread(function()
    while true do
        Citzen.Wait(0) -- Do this every tick

        -- Traffic and ped density mangagement
        SetTrafficDensity(0.2)
        SetPedDensity(0.2)
    end
end)

function SetTrafficDensity(density)
    SetParkedVehicleDensityMultiplierThisFrame(density)
    SetVehicleDensityMultiplierThisFrame(density)
    SetRandomVehicleDensityMultiplierThisFrame(density)
end

function SetPedDensity(density)
    SetPedDensityMultiplierThisFrame(density)
    SetScenarioPedDensityMultiplierThisFrame(density)
end 