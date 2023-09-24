local RSGCore = exports['rsg-core']:GetCoreObject()

local Objects = {}

local function CreateObjectId()
    if Objects then
        local objectId = math.random(10000, 99999)
        while Objects[objectId] do
            objectId = math.random(10000, 99999)
        end
        return objectId
    else
        local objectId = math.random(10000, 99999)
        return objectId
    end
end

RSGCore.Functions.CreateUseableItem('storagebox', function(source, item)TriggerClientEvent("storagebox:Client:spawnbag", source)end)

RegisterNetEvent('storagebox:Server:SpawnAmbulanceBag', function(type)
    local src = source
    local objectId = CreateObjectId()
    Objects[objectId] = type
    TriggerClientEvent("storagebox:Client:SpawnAmbulanceBag", src, objectId, type, src)
end)

RegisterNetEvent('storagebox:Server:RemoveItem', function(item, amount)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    Player.Functions.RemoveItem(item, amount)
end)

RegisterNetEvent('storagebox:Server:AddItem', function(item, amount)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    Player.Functions.AddItem(item, amount)
end)


