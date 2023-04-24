local vehiclesToRemove = { "futo", "adder", "banshee" } -- lista de modelos de vehículos a eliminar

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        -- Estas funciones nativas deben ser llamadas en cada frame
        SetVehicleDensityMultiplierThisFrame(0.0) -- establecer la densidad de tráfico a 0 
        SetPedDensityMultiplierThisFrame(0.0) -- establecer la densidad de npc/ai peds a 0
        SetRandomVehicleDensityMultiplierThisFrame(0.0) -- establecer la densidad de vehículos aleatorios (escenarios de coches / coches que salen de un aparcamiento, etc.) a 0
        SetParkedVehicleDensityMultiplierThisFrame(0.0) -- establecer la densidad de vehículos aparcados aleatorios (escenarios de coches aparcados) a 0
        SetScenarioPedDensityMultiplierThisFrame(0.0, 0.0) -- establecer la densidad de npc/ai peds o scenario peds a 0
        SetGarbageTrucks(false) -- detener que los camiones de basura se generen aleatoriamente
        SetRandomBoats(false) -- detener que los barcos se generen aleatoriamente en el agua
        SetCreateRandomCops(false) -- deshabilitar que los policías aparezcan caminando/manejando por el mapa
        SetCreateRandomCopsNotOnScenarios(false) -- detener que los policías se generen aleatoriamente (no en un escenario)
        SetCreateRandomCopsOnScenarios(false) -- detener que los policías se generen aleatoriamente (en un escenario)
        
        local playerPed = PlayerPedId()
        local x, y, z = GetEntityCoords(playerPed)

        -- Eliminar vehículos en la lista específica
        for _, vehicleName in ipairs(vehiclesToRemove) do
            local vehicles = ESX.Game.GetVehicles()
            for i = 1, #vehicles do
                local vehicle = vehicles[i]
                local model = GetEntityModel(vehicle)
                if GetDistanceBetweenCoords(GetEntityCoords(vehicle), x, y, z, true) < 1000.0 and GetVehicleEngineHealth(vehicle) ~= false and GetPedInVehicleSeat(vehicle, -1) == 0 and IsEntityAVehicle(vehicle) and GetVehicleDoorLockStatus(vehicle) ~= 2 and GetEntitySpeed(vehicle) < 1.0 and GetVehicleNumberPlateText(vehicle) ~= nil and string.lower(GetDisplayNameFromVehicleModel(model)) == vehicleName then
                    SetEntityAsMissionEntity(vehicle, true, true)
                    DeleteVehicle(vehicle)
                end
            end
        end
    end
end)
