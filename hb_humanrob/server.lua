ESX = exports["es_extended"]:getSharedObject()

RegisterServerEvent('payout')
AddEventHandler('payout', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local money = math.random(1000, 10000)
    xPlayer.addMoney(money)
end)

