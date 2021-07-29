ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


RegisterServerEvent('rodeo:blanchiment')
AddEventHandler('rodeo:blanchiment', function(argent)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	local taxe = 0.90    -- Le blanchisseur prend 35% (1-0.65 = 0.35)

	argent = ESX.Math.Round(tonumber(argent))
	pourcentage = argent * taxe
	Total = ESX.Math.Round(tonumber(pourcentage))

	if argent > 0 and xPlayer.getAccount('black_money').money >= argent then
		xPlayer.removeAccountMoney('black_money', argent)
		TriggerClientEvent('esx:showAdvancedNotification', xPlayer.source, 'Information', 'Blanchiment', 'Attend ~r~10 secondes', 'CHAR_ARTHUR', 8)
		Citizen.Wait(10000)
		
		TriggerClientEvent('esx:showAdvancedNotification', xPlayer.source, 'Information', 'Blanchiment', 'Tu as reçu : ' .. ESX.Math.GroupDigits(Total) .. ' ~g~$', 'CHAR_ARTHUR', 8)
		xPlayer.addMoney(Total)
	else
		TriggerClientEvent('esx:showAdvancedNotification', xPlayer.source, 'Information', 'Blanchiment', '~r~Montant invalide', 'CHAR_ARTHUR', 8)
	end	
end)
