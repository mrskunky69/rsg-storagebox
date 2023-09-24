local RSGCore = exports['rsg-core']:GetCoreObject()



RegisterNetEvent('storagebox:Client:MenuAmbulanceBag', function()
    local playerPed = PlayerPedId()
    if IsEntityDead(playerPed) then return Notify("You cannot Open Bag while dead", "error") end
    if IsPedSwimming(playerPed) then return Notify("You cannot Open Bag in the water.", "error") end
    if IsPedSittingInAnyVehicle(playerPed) then return Notify("You cannot Open Bag inside a vehicle", "error") end
    local job = RSGCore.Functions.GetPlayerData().job.name
    if Config.Bag.NeedJob == true then
        if job ~= Config.Bag.Job then
            Notify("You dont have permissions to Open The Bag")
            return false
        end
    end
    exports['rsg-menu']:openMenu({
        { header = "Storage Box", txt = "", isMenuHeader = true },
        { header = "Open storage",  params = { event = "storagebox:Client:StorageAmbulanceBag" } },

        -- You can add more menus with your's personal events...
        { header = "", txt = "❌ Close", params = { event = "rsg-menu:closeMenu" } },
    })
end)

