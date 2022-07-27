ESX              = nil
local PlayerData = {}

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
  PlayerData = xPlayer   
end)

-- Vars or locals
local isInVeh = false

local lastVeh
local lastModel
local lastPlate
local wasRunning
local nextUpdate = 0
local isVehicle = false

local starting = false

local vehData = {}

vehData.ignition = 0
vehData.engine = 0
vehData.lock = 0
vehData.km = 0
vehData.engineCheck = 0
vehData.startCheck = 0
vehData.owned = false


local timeStart = 0.5

distance = 0
showKM = 0

-- Events
RegisterNetEvent('vehicle_system:fixengine')
AddEventHandler('vehicle_system:fixengine', function(plt)
    local ped = PlayerPedId()
    if IsPedInAnyVehicle(PlayerPedId(), false) then
        local vehicle = GetVehiclePedIsIn(ped, false)
        local plate
        if plt ~= nil then
            plate = plt
        else
            plate = GetVehicleNumberPlateText(vehicle)
        end
        
        updateKms(plate)
        Citizen.Wait(500)
        TriggerServerEvent('vehicle_system:fixEngineCheck', plate)
        Citizen.Wait(500)
        SetVehicleFixed(vehicle)
        TriggerServerEvent('vehicle_system:getVehInfo', plate, vehicle)
        checkEngineKms(vehicle)
    end
end)

RegisterNetEvent('vehicle_system:fixstart')
AddEventHandler('vehicle_system:fixstart', function(plt)
    local ped = PlayerPedId()
    if IsPedInAnyVehicle(PlayerPedId(), false) then
        local vehicle = GetVehiclePedIsIn(ped, false)
        local plate
        
        if plt ~= nil then
            plate = plt
        else
            plate = GetVehicleNumberPlateText(vehicle)
        end

        updateKms(plate)
        Citizen.Wait(500)
        TriggerServerEvent('vehicle_system:fixStartCheck', plate)
        Citizen.Wait(500)
        TriggerServerEvent('vehicle_system:getVehInfo', plate, vehicle)
        checkEngineKms(vehicle)
    end
end)

RegisterNetEvent('vehicle_system:getVehInfoClient')
AddEventHandler('vehicle_system:getVehInfoClient', function(data, curCar)
    vehData = data
    updateVehicle(curCar)
    checkEngineKms(curCar)

    SendNUIMessage({
        value = round(vehData.km, 2),
        action = "showMessage"
    })

    isInVeh = true

end)

-- Functions
function round(num, numDecimalPlaces)
    local mult = 10^(numDecimalPlaces or 0)
    return math.floor(num * mult + 0.5) / mult
  end

function ShowHelpNotification(name, msg)
	if not IsHelpMessageOnScreen() then
        AddTextEntry(name, msg)
		BeginTextCommandDisplayHelp(name)
		EndTextCommandDisplayHelp(0, false, true, -1)
	end
end

function checkClass()

    local veh = GetVehiclePedIsIn(PlayerPedId(), false)
    local class = GetVehicleClass(veh)
    local isBad

    if class == 13 or 
        class == 14 or
        class == 15 or
        class == 16 or
        class == 17 or
        class == 21 then
        isBad = false
    else
        isBad = true
    end

    return isBad

end

function checkEngineKms(vehUsing)
    local lastEngineCheck = vehData.km - vehData.engineCheck
    local lastStartCheck = vehData.km - vehData.startCheck
    local actualEngineDamage = GetVehicleEngineHealth(vehUsing)
    local newDamage = actualEngineDamage

    timeStart = 0.5
    for i, startCheck in ipairs(config.startCheck) do
        if lastStartCheck >= (startCheck.moreThan * 100) then
            timeStart = startCheck.time
        end
    end

    for i, engineCheck in ipairs(config.engineCheck) do
        if lastEngineCheck >= (engineCheck.moreThan * 100) then
            if actualEngineDamage > engineCheck.maxHealth then
                newDamage = engineCheck.maxHealth
                SetVehicleEngineHealth(vehUsing, newDamage)
            end
        end
    end

    
    if timeStart < 0.5 then
        timeStart = 0.5
    end
end

function updateVehicle(vehUsing)
    
    if vehData.ignition == 1 then
        if vehData.engine == 1 then
            SetVehicleEngineOn(vehUsing, true, true, true)
            SetVehicleLights(vehUsing, 0)
            SetVehicleLightsMode(vehUsing, 0)

        else
            SetVehicleEngineOn(vehUsing, false, true, true)
            SetVehicleLights(vehUsing, 2)
            SetVehicleLightsMode(vehUsing, 2)
        end
    elseif vehData.ignition == 0 then
        SetVehicleLights(vehUsing, 0)
        SetVehicleLightsMode(vehUsing, 0)
        SetVehicleEngineOn(vehUsing, false, true, true)
    end
end

function setIgnition(vehUsing)
    if vehData.ignition == 0 and vehData.owned then
        vehData.ignition = 1
        SetVehicleLights(vehUsing, 2)
        SetVehicleLightsMode(vehUsing, 2)
        SetVehicleEngineOn(vehUsing, false, true, true)
    else
        vehData.ignition = 0
        SetVehicleLights(vehUsing, 0)
        SetVehicleLightsMode(vehUsing, 0)
        SetVehicleEngineOn(vehUsing, false, true, true)
    end
end

function setEngine(vehUsing)
    checkEngineKms(curCar)

    if vehData.engine == 0 and vehData.owned then
        vehData.engine = 1
        SetVehicleLights(vehUsing, 0)
        SetVehicleLightsMode(vehUsing, 0)
        SetVehicleEngineOn(vehUsing, true, false, true)
        SetVehicleEngineCanDegrade(vehUsing, true)
    else
        vehData.engine = 0
        SetVehicleEngineOn(vehUsing, false, true, true)
        local vehSpeed = GetEntitySpeed(vehUsing)
    end
end

function updateKms(vehUsing)
    TriggerServerEvent('vehicle_system:updateVehInfo', vehUsing, vehData)
end


Citizen.CreateThread(function()
    while true do
        local ped = PlayerPedId()
        
        if IsPedInAnyVehicle(ped, true) then
            local currentVehicle = GetVehiclePedIsUsing(ped)
            local currentModel = GetEntityModel(currentVehicle)
            local currentPlate = GetVehicleNumberPlateText(currentVehicle)
            if not isInVeh then
                if GetPedInVehicleSeat(currentVehicle, -1) == ped then
                    local plate = GetVehicleNumberPlateText(currentVehicle)
                    lastVeh = currentVehicle
                    lastModel = currentModel
                    lastPlate = plate
                    TriggerServerEvent('vehicle_system:getVehInfo', plate, currentVehicle)
                end
            end
            if isInVeh and (currentVehicle ~= lastVeh or currentModel ~= lastModel or currentPlate ~= lastPlate) then
                updateKms(lastPlate)
                isInVeh = false
            end
        elseif not IsPedInAnyVehicle(ped, true) and isInVeh then
            updateKms(lastPlate)
            SetVehicleEngineOn(lastVeh, wasRunning, true, false)
            vehData.ignition = 0
            vehData.engine = 0
            vehData.lock = 0
            vehData.km = 0
            vehData.engineCheck = 0
            vehData.startCheck = 0
            vehData.owned = false
            isInVeh = false
            lastVeh = nil
            lastModel = nil
            lastPlate = nil
            wasRunning = nil

            SendNUIMessage({
                action = "hideMessage"
            })

        elseif not IsPedInAnyVehicle(ped, true) and not isInVeh then
            SendNUIMessage({
                action = "hideMessage"
            })
        end
        Citizen.Wait(500)
    end
end)

Citizen.CreateThread(function()
    while true do
        Wait(1000)
        if IsPedInAnyVehicle(PlayerPedId(), false) then
            isVehicle = checkClass()
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if notif and vehData.engine == 0 and not starting and isInVeh and isVehicle then
            local ped = PlayerPedId()
            local crVeh = GetVehiclePedIsUsing(ped)
            if DoesEntityExist(crVeh) then
                if GetIsVehicleEngineRunning(crVeh) or IsVehicleEngineStarting(crVeh) then
                    SetVehicleEngineOn(crVeh, false, true, true)
                end
            end
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        local ped = PlayerPedId()

        if IsPedInAnyVehicle(ped, false) and isInVeh and next(vehData) and isVehicle then
            local crVeh = GetVehiclePedIsUsing(ped)
            if GetPedInVehicleSeat(crVeh, -1) == ped then

                if vehData.engine == 0 and vehData.ignition == 1 then
                    notif = config.lang.turnOnEngine .. "\n" .. config.lang.turnOffIgnition
                elseif vehData.ignition == 0 then
                    notif = config.lang.turnOnIgnition
                else
                    notif = nil
                end

                if notif and vehData.owned then
                    ShowHelpNotification("vehicle_system", notif)
                end

                if IsControlJustPressed(0, config.key) then
                    if vehData.engine == 0 and vehData.ignition == 1 then
                        timer = GetGameTimer()
                        time = -1
                        newtime = 250
                        status = true

                        while IsControlPressed(0, config.key) do
                            starting = true
                            time = GetGameTimer() - timer
                            if GetIsVehicleEngineRunning(crVeh) then
                                SetVehicleEngineOn(crVeh, false, true, true)
                            end
                            if newtime < time then
                                status = not status
                                SetVehicleEngineOn(crVeh, status, false, true)
                                newtime = time + 250
                            end
                            if time > timeStart*1000 then
                                SetVehicleEngineOn(crVeh, false, true, true)
                                setEngine(crVeh)
                                timer = nil
                                time = nil
                                newtime = nil
                                starting = false
                                break
                            end
                            Citizen.Wait(0)
                        end
                        while not IsControlPressed(0, config.key) do
                            if time ~= -1 and time < 1*1000 then
                                setIgnition(crVeh)
                                timer = nil
                                time = nil
                                newtime = nil
                                starting = false
                                break
                            else
                                starting = false
                            end
                            Citizen.Wait(0)
                        end
                    elseif vehData.engine == 0 and vehData.ignition == 0 then
                            setIgnition(crVeh)
                    elseif vehData.engine == 1 and vehData.ignition == 1 then
                        setEngine(crVeh)
                        setIgnition(crVeh)
                    end
                end
                if IsControlJustPressed(0, 75) then
                    wasRunning = GetIsVehicleEngineRunning(crVeh)
                end
            end
        end
        Citizen.Wait(0)
    end
end)

Citizen.CreateThread(function()
    while true do
        if IsPedInAnyVehicle(PlayerPedId(), false) and isVehicle then
            local veh = GetVehiclePedIsIn(PlayerPedId(), false)
            local driver = GetPedInVehicleSeat(veh, -1)

                vehPlate = GetVehicleNumberPlateText(veh)

                local oldPos = GetEntityCoords(PlayerPedId())

                Citizen.Wait(1000)
                local curPos = GetEntityCoords(PlayerPedId())

                if IsVehicleOnAllWheels(veh) then
                    dist = GetDistanceBetweenCoords(oldPos.x, oldPos.y, oldPos.z, curPos.x, curPos.y, curPos.z, true)
                else
                    dist = 0
                end

                vehData.km = vehData.km + dist
                SendNUIMessage({
                    value = round(vehData.km, 2),
                    action = "showMessage"
                })
          end
          Citizen.Wait(500)
      end
  end)

  Citizen.CreateThread(function()
    while true do
        local ped = PlayerPedId()
        if IsPedInAnyVehicle(PlayerPedId(), false) and vehData.engine == 1 then
            local GameTimer = GetGameTimer()
            if nextUpdate == nil or GameTimer >= nextUpdate then
                nextUpdate = GameTimer + (config.autoSaving*1000)
                local crVeh = GetVehiclePedIsUsing(ped)
                updateKms(GetVehicleNumberPlateText(crVeh))
                checkEngineKms(crVeh)
            end
        end
        Citizen.Wait(800)
    end
end)

local alreadyTried = {}

if config.useLockSystem then
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(0)
            if not IsPedInAnyVehicle(PlayerPedId(), true) then
                if GetIsTaskActive(PlayerPedId(), 160) and GetVehicleClass(GetVehiclePedIsTryingToEnter(PlayerPedId()) ~= 13) then
                    local veh = GetVehiclePedIsEntering(PlayerPedId())
                    local plate = GetVehicleNumberPlateText(veh)
                    if alreadyTried[plate] == nil then
                        alreadyTried[plate] = {}
                        alreadyTried[plate].timeout = (GetGameTimer() + 1000)
                        ESX.TriggerServerCallback('vehicle_system:getLock', function(state)
                            alreadyTried[plate].value = state
                            if state == 1 then
                                ClearPedTasks(PlayerPedId())
                                ESX.ShowNotification(config.lang.openCar)
                            end
                        end, plate)
                    else
                        while alreadyTried[plate].value == nil do
                            Citizen.Wait(50)
                        end
                        if alreadyTried[plate].value == 1 then
                            ClearPedTasks(PlayerPedId())
                            ESX.ShowNotification(config.lang.closeCar)
                        end
                    end
                end
            end
        end
    end)

    Citizen.CreateThread(function()
        while true do
            if next(alreadyTried) then
                local gameTime = GetGameTimer()
                for k,v in pairs(alreadyTried) do
                    if v.timeout < gameTime then
                        alreadyTried[k] = nil
                    end
                end
            end
            Citizen.Wait(3500)
        end     
    end)

    local lockingVeh = false

    function getVehicleInDirection()
        local veh = ESX.Game.GetClosestVehicle()
        if DoesEntityExist(veh) then
            return veh
        else
            return 'NOMATR'
        end
    end

    local alreadyPressed = false

    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(3000)
            if alreadyPressed then
                alreadyPressed = false
            end
        end
    end)


    Citizen.CreateThread(function()
        local dict = "anim@mp_player_intmenu@key_fob@"
        RequestAnimDict(dict)
        while not HasAnimDictLoaded(dict) do
            Citizen.Wait(0)
        end
        while true do
        Citizen.Wait(0)
        if IsControlJustReleased(0, 182) and IsInputDisabled(0) or IsControlJustReleased(0, 173) and not IsInputDisabled(0) and not lockingVeh then
            local targetVehicle = getVehicleInDirection()
            local plate = GetVehicleNumberPlateText(targetVehicle)
            
            if alreadyPressed then
                ESX.ShowNotification(config.lang.tooMuch, false, true, 90)
            else
                alreadyPressed = true
                ESX.TriggerServerCallback('carlock:isVehicleOwner', function(owner)
                    if owner then
                        ESX.TriggerServerCallback('vehicle_system:getLock', function(lockStatus)
                            if lockStatus == 1 then
                                ESX.TriggerServerCallback('vehicle_system:toggleLock', function(state)
                                    if state then
                                        if not IsPedInAnyVehicle(PlayerPedId(), true) then
                                            TaskPlayAnim(PlayerPedId(), dict, "fob_click_fp", 8.0, 8.0, -1, 48, 1, false, false, false)
                                        end
                                        SetVehicleDoorsLocked(targetVehicle, 1)
                                        PlayVehicleDoorCloseSound(targetVehicle, 1)
                                        SetVehicleLights(targetVehicle, 2)
                                        Citizen.Wait(150)
                                        SetVehicleLights(targetVehicle, 0)
                                        Citizen.Wait(150)
                                        SetVehicleLights(targetVehicle, 2)
                                        Citizen.Wait(150)
                                        SetVehicleLights(targetVehicle, 0)
                                        ESX.ShowNotification(config.lang.youOpen .. plate..'~s~.')
                                    end
                                end, plate, false)
                            elseif lockStatus == 0 then
                                ESX.TriggerServerCallback('vehicle_system:toggleLock', function(state)
                                    if state then
                                        if not IsPedInAnyVehicle(PlayerPedId(), true) then
                                            TaskPlayAnim(PlayerPedId(), dict, "fob_click_fp", 8.0, 8.0, -1, 48, 1, false, false, false)
                                        end
                                        SetVehicleDoorShut(targetVehicle, 0, false)
                                        SetVehicleDoorShut(targetVehicle, 1, false)
                                        SetVehicleDoorShut(targetVehicle, 2, false)
                                        SetVehicleDoorShut(targetVehicle, 3, false)
                                        SetVehicleDoorShut(targetVehicle, 4, false)
                                        SetVehicleDoorShut(targetVehicle, 5, false)
                                        SetVehicleDoorsLocked(targetVehicle, 2)
                                        PlayVehicleDoorCloseSound(targetVehicle, 1)
                                        SetVehicleLights(targetVehicle, 2)
                                        Citizen.Wait(150)
                                        SetVehicleLights(targetVehicle, 0)
                                        Citizen.Wait(150)
                                        SetVehicleLights(targetVehicle, 2)
                                        Citizen.Wait(150)
                                        SetVehicleLights(targetVehicle, 0)
                                        ESX.ShowNotification(config.lang.youClose ..plate..'~s~.')
                                    end
                                end, plate, true)
                            end
                        end, plate)
                    end
                end, plate)    
                end
            end
        end
    end)
end