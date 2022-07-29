ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

isrobbing = {}

ESX.RegisterServerCallback('esx_robcashregister:countpolice', function(source, cb)

	local xPlayers = ESX.GetPlayers()
 	local pcountPolice = 0

    for i=1, #xPlayers, 1 do
        local Player = ESX.GetPlayerFromId(xPlayers[i])
        if Player.job.name == 'police' then
           pcountPolice = pcountPolice + 1
        end
    end

	cb(pcountPolice)
end)

RegisterServerEvent('esx_robcashregister:startsteal')
AddEventHandler('esx_robcashregister:startsteal', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	
	if xPlayer.getInventoryItem('lockpick').count >= 1 then
		isrobbing[source] = {
			true
		}
		TriggerClientEvent('esx_robcashregister:startstealcash', _source)

	else
		TriggerClientEvent('mythic_notify:client:SendAlert', source , { type = 'error', text = 'First open the cash register.'})
	end
end)

RegisterServerEvent('esx_robcashregister:stealInProgress')
AddEventHandler('esx_robcashregister:stealInProgress', function(streetName, playerGender)
	if playerGender == 0 then
		playerGender = 'Female'
	else
		playerGender = 'Male'
	end
    local data = {displayCode = '10-13', description = 'Robbery in progress', isImportant = 0, recipientList = {'police'}, length = '5000', infoM = 'fa-info-circle', info = ('A %s has been reported in a robbery'):format(playerGender)}
    local dispatchData = {dispatchData = data, caller = 'Local', street = streetName, coords = GetEntityCoords(GetPlayerPed(source))}
    TriggerEvent('wf-alerts:svNotify', dispatchData)
end)

RegisterServerEvent('esx_robcashregister:givemoney')
AddEventHandler('esx_robcashregister:givemoney', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	local money = math.random(350, 1850)
	if isrobbing[source] then
		xPlayer.addAccountMoney('black_money', money)
		TriggerClientEvent('mythic_notify:client:SendAlert', source , { type = 'inform', text = 'You steal  $' ..money })
		isrobbing[source] = nil
	else
		print("Cheater: " .. GetPlayerName(source))
	end
end)

AddEventHandler("playerDropped", function(source)
	local source = source
    if isrobbing[source] then
        isrobbing[source] = nil
    end
end)

RegisterServerEvent("esx_robcashregister:cancelled")
AddEventHandler("esx_robcashregister:cancelled", function()
	local source = source
    if isrobbing[source] then
        isrobbing[source] = nil
    end
end)

