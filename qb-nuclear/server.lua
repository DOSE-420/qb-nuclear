local QBCore = exports['qb-core']:GetCoreObject()

local hiddencoords = vector3(764.2, -1905.11, 29.46)
local onDuty = 0

QBCore.Functions.CreateCallback('nuclear:getlocation', function(source, cb)
    cb(hiddencoords)
end)

QBCore.Functions.CreateCallback('nuclear:getCops', function(source, cb)
    cb(getCops())
end)

function getCops()
    local Players = QBCore.Functions.GetPlayers()
    onDuty = 0
    return 5
end

RegisterServerEvent("nuclear:GiveItem")
AddEventHandler("nuclear:GiveItem", function(x, y, z)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    Player.Functions.AddItem('nuclear', 5)
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['nuclear'], "add")
end)

RegisterNetEvent('nuclear:updatetable')
AddEventHandler('nuclear:updatetable', function(bool)
    TriggerClientEvent('nuclear:synctable', -1, bool)
end)

RegisterServerEvent("nuclear:syncMission")
AddEventHandler("nuclear:syncMission", function(missionData)
    local missionData = missionData
    local ItemData = Player.Functions.GetItemByName("bluechip")
    TriggerClientEvent('nuclear:syncMissionClient', -1, missionData)
end)

RegisterServerEvent("nuclear:delivery")
AddEventHandler("nuclear:delivery", function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local check = Player.Functions.GetItemByName('nuclear').count

    if check >= 1 then
        Player.Functions.RemoveItem('nuclear', 1)
        Player.Functions.AddMoney('cash', Config.reward)
        TriggerClientEvent('QBCore:Notify', src, "You received ".. Config.reward .." for your job.", "success", 3500)
    elseif Config.useNotification then
        TriggerClientEvent('QBCore:Notify', src, "You have no nuclear files left.", "success", 3500)
    end
end)
