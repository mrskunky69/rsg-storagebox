local RSGCore = exports['rsg-core']:GetCoreObject()

local ObjectList = {}

RegisterNetEvent('storagebox:Client:SpawnAmbulanceBag', function(objectId, type, player)
    local coords = GetEntityCoords(GetPlayerPed(GetPlayerFromServerId(player)))
    local heading = GetEntityHeading(GetPlayerPed(GetPlayerFromServerId(player)))
    local forward = GetEntityForwardVector(PlayerPedId())
    local x, y, z = table.unpack(coords + forward * 1.5)
    local spawnedObj = CreateObject(Config.Bag.AmbulanceBag[type].model, x, y, coords.z-1, true, false, false)
    PlaceObjectOnGroundProperly(spawnedObj)
    SetEntityHeading(spawnedObj, heading)
    FreezeEntityPosition(spawnedObj, Config.Bag.AmbulanceBag[type].freeze)
    ObjectList[objectId] = {
        id = objectId,
        object = spawnedObj,
        coords = vector3(x, y, z - 0.3),
    }
    TriggerServerEvent("storagebox:Server:RemoveItem","storagebox",1)
end)

RegisterNetEvent('storagebox:Client:spawnbag', function()
    local playerPed = PlayerPedId()
    TaskStartScenarioInPlace(PlayerPedId(), GetHashKey("WORLD_HUMAN_CROUCH_INSPECT"), -1, true, "StartScenario", 0, false)
    progressBar("Putting the box down...")
    Wait(2500)
    TriggerServerEvent("storagebox:Server:SpawnAmbulanceBag", "storagebox")
end)

RegisterNetEvent('storagebox:Client:GuardarAmbulanceBag')
AddEventHandler("storagebox:Client:GuardarAmbulanceBag", function()
    local x, y, z = table.unpack(GetEntityCoords(PlayerPedId(), true))
    local playerPedPos = GetEntityCoords(PlayerPedId(), true)
    local AmbulanceBag = GetClosestObjectOfType(playerPedPos, 10.0, GetHashKey("p_ammoboxlancaster02x"), false, false, false)
    local playerPed = PlayerPedId()
    TaskStartScenarioInPlace(PlayerPedId(), GetHashKey("WORLD_HUMAN_CROUCH_INSPECT"), -1, true, "StartScenario", 0, false)
    progressBar("Taking Back The box...")
    Wait(2500)
    Notify("Box Taken Back with success.")
    SetEntityAsMissionEntity(AmbulanceBag, 1, 1)
    DeleteObject(AmbulanceBag)
    TriggerServerEvent("storagebox:Server:AddItem","storagebox",1)
end)

local citizenid = nil
AddEventHandler("storagebox:Client:StorageAmbulanceBag", function()
    local charinfo = RSGCore.Functions.GetPlayerData().charinfo
    citizenid = RSGCore.Functions.GetPlayerData().citizenid
    TriggerEvent("inventory:client:SetCurrentStash", "storagebox",citizenid)
    TriggerServerEvent("inventory:server:OpenInventory", "stash", "storagebox",citizenid, {
        maxweight = 40000,
        slots = 48,
    })
end)

local AmbulanceBags = {
    `p_ammoboxlancaster02x`,
}

exports['rsg-target']:AddTargetModel(AmbulanceBags, {
    options = {{event   = "storagebox:Client:MenuAmbulanceBag",icon    = "fa-solid fa-box",label   = "storage"},
    {event   = "storagebox:Client:GuardarAmbulanceBag",icon    = "fa-solid fa-box",label   = "Take Back Box"},},distance = 2.0 })
