ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local nameShouldBe = 'codev_vehsystem'
local lockedVehs = {}
local vehTables = {}

RegisterServerEvent('vehicle_system:getVehInfo')
AddEventHandler('vehicle_system:getVehInfo', function(plate, curVeh)
    local src = source
    local vehPlate = plate
    local vehData = {}
    local curVehicle = curVeh
    local identifier = getIdentifier(src)
	MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE plate = @plate', {['@plate'] = vehPlate}, function(result)
        local found = false
        if result[1] and result[1].carplate ~= nil then
            local vehiclePlate = result[1].carplate
            if vehiclePlate == plate then
                if vehiclePlate == vehPlate then
                    vehData.ignition = result[1].ignition
                    vehData.engine = result[1].engine
                    vehData.lock = result[1].lock
                    vehData.km = result[1].km
                    vehData.engineCheck = result[1].engineCheck
                    vehData.startCheck = result[1].startCheck

                    local table = json.decode(result[1].owner)

                    if identifier == result[1].owner then
                        vehData.owned = true
                    elseif result[1].owner == 'no_owner' then
                        vehData.owned = true
                    else
                        vehData.owned = false
                    end
                    found = true

                end
            end
        end
        if found then
            TriggerClientEvent('vehicle_system:getVehInfoClient', src, vehData, curVehicle)
        else
            if not vehTables[vehPlate] then
                local randkm = math.random(583, 99999)
                vehData.plate = vehPlate
                vehData.ignition = 0
                vehData.engine = 0
                vehData.lock = 0
                vehData.km = randkm
                vehData.engineCheck = randkm
                vehData.startCheck = randkm
                vehData.owned = true
                vehTables[vehPlate] = vehData
            else
                vehData.ignition = vehTables[vehPlate].ignition
                vehData.engine = vehTables[vehPlate].engine
                vehData.km = vehTables[vehPlate].km
                vehData.lock = vehTables[vehPlate].lock
                vehData.engineCheck = vehTables[vehPlate].engineCheck
                vehData.startCheck = vehTables[vehPlate].startCheck
                vehData.owned = true
                vehTables[vehPlate] = vehData
            end

            TriggerClientEvent('vehicle_system:getVehInfoClient', src, vehData, curVehicle)
        end
    end)
end)

RegisterServerEvent('vehicle_system:updateVehInfo')
AddEventHandler('vehicle_system:updateVehInfo', function(plate, data)
    local src = source
    if not vehTables[plate] then
        MySQL.Async.execute('UPDATE owned_vehicles SET ignition=@ignition, engine=@engine, km=@km WHERE plate = @carplate',{['@ignition'] = data.ignition, ['@engine'] = data.engine, ['@km'] = data.km, ['@carplate'] = plate})
    else
        vehTables[plate].ignition = data.ignition
        vehTables[plate].engine = data.engine
        vehTables[plate].km = data.km
    end
end)

RegisterServerEvent('vehicle_system:fixEngineCheck')
AddEventHandler('vehicle_system:fixEngineCheck', function(plate)
    local src = source
    if not vehTables[plate] then
        MySQL.Async.execute('UPDATE owned_vehicles SET engineCheck = km WHERE plate = @carplate',{['@carplate'] = plate})
    else
        vehTables[plate].engineCheck = vehTables[plate].km
    end
end)


RegisterServerEvent('vehicle_system:fixStartCheck')
AddEventHandler('vehicle_system:fixStartCheck', function(plate)
    local src = source
    if not vehTables[plate] then
        MySQL.Async.execute('UPDATE owned_vehicles SET startCheck = km WHERE plate = @carplate',{['@carplate'] = plate})
    else
        vehTables[plate].startCheck = vehTables[plate].km
    end
end)


RegisterServerEvent('vehicle_system:setOwner')
AddEventHandler('vehicle_system:setOwner', function(source, plate)
    local src = source
    local identifier = getIdentifier(src)
    MySQL.Async.execute('UPDATE owned_vehicles SET owner = @identifier WHERE plate = @plate',{['@plate'] = plate, ['@identifier'] = identifier})
end)

RegisterServerEvent('vehicle_system:stopEngine')
AddEventHandler('vehicle_system:stopEngine', function(source, plate)
    local _plate = plate
    MySQL.Async.execute('UPDATE owned_vehicles SET engine = 0, ignition = 0 WHERE plate = @plate',{['@plate'] = plate})
end)

RegisterCommand('fixengine', function(source, args, rawCommand)
    if IsPlayerAceAllowed(source, "codev_vehsystem.fixengine") then
        TriggerClientEvent('vehicle_system:fixengine', source)
    end
end)

RegisterCommand('fixstart', function(source, args, rawCommand)
    if IsPlayerAceAllowed(source, "codev_vehsystem.fixstart") then
        TriggerClientEvent('vehicle_system:fixstart', source)
    end
end)

ESX.RegisterServerCallback('vehicle_system:getLock', function(source, cb, plate)
    if Config.useLockSystem then
        local xPlayer = ESX.GetPlayerFromId(source)
        if not vehTables[plate] then
            if plate ~= nil then
                MySQL.Async.fetchAll('SELECT `lock` FROM owned_vehicles WHERE carplate = @plate', {['@plate'] = plate}, function(result)
                    print(result)
                    if (result[1].lock == 1) then
                        cb(1)
                    else
                        cb(0)
                    end
                end)
            end
        else
            cb(0)
        end
    else
        cb(0)
    end
end)

ESX.RegisterServerCallback('vehicle_system:toggleLock', function(source, cb, plate, state)
    local xPlayer = ESX.GetPlayerFromId(source)
    MySQL.Async.execute('UPDATE owned_vehicles SET `lock` = @lock WHERE carplate = @carplate',{['@carplate'] = plate, ['@lock'] = bool_to_number(state)})
    cb(true)
end)


ESX.RegisterServerCallback('carlock:checkStatus', function(source, cb, plate)
	local xPlayer = ESX.GetPlayerFromId(source)
	local identifier = xPlayer.getIdentifier()
	local plt = plate

	if lockedVehs[tostring(plt)] then
		cb(true)
	else
		cb(false)
	end

end)

ESX.RegisterServerCallback('carlock:isVehicleOwner', function(source, cb, plate)
	local xPlayer = ESX.GetPlayerFromId(source)
	local identifier = xPlayer.getIdentifier()
	MySQL.Async.fetchAll('SELECT owner FROM owned_vehicles WHERE owner = @owner AND plate = @plate', {
		['@owner'] = identifier,
		['@plate'] = plate
	}, function(result)
		if result[1] then
			cb(result[1].owner == identifier)
		else
			cb(false)
		end
	end)
end)

-- Functions

function bool_to_number(value)
    return value == true and 1 or value == false and 0
end


function getIdentifier(src)
    local ident
    for i, idnt in ipairs(GetPlayerIdentifiers(src)) do
        if string.sub(idnt, 1, string.len(Config.ownerIdentifier)) == Config.ownerIdentifier then
            ident = idnt
        end
    end
    return ident
end