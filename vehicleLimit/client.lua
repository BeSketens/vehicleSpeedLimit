if Config.SpeedLimitActive then
    Citizen.CreateThread(function()
        local interval, ped
        local speedType = Config.SpeedType

        local vehicle, vehicleClass, limit, speed
        while true do
            vehicleClass = false
            interval = 300
            ped = PlayerPedId()

            if not IsPedInAnyVehicle(ped, false) then
                printDebug("Player on foot")
                goto next
            end

            interval = 20

            vehicle = GetVehiclePedIsIn(ped, false)

            if not (GetVehicleEngineHealth(vehicle) > 300) then
                printDebug("Vehicle engine is dead")
                goto next
            end

            if not Config.UsingCustomClasses then
                vehicleClass = GetVehicleClass(vehicle)
                limit = Config.ClassesLimit[vehicleClass]
            else
                vehicleClass, limit = GetCustomVehicleClass(vehicle)
            end

            if speedType == "kmh" then
                speed = math.ceil(GetEntitySpeed(vehicle) * 3.6)
            elseif speedType == "mph" then
                speed = math.ceil(GetEntitySpeed(vehicle) * 2.236936)
            else
                print("ERROR : wrong speed type > kmh or mph only") -- dont change it to printDebug
                goto next
            end

            -- goto added because with the custom classes some
            -- vehicles won't have a set speed limit
            if not vehicleClass then goto next end

            printDebug("Speed type : ", speedType)
            printDebug("Vehicle class : ", vehicleClass)
            printDebug("Speed : ", speed .. speedType)
            printDebug("Limit : ", limit .. speedType)

            if speed > limit then
                printDebug("----------")
                printDebug("- Vehicle engine killed -")
                printDebug("----------")
                SetVehicleEngineOn(vehicle, false, true, true)
                SetVehicleEngineHealth(vehicle, 0.00)
            end

            ::next::

            Wait(interval)
        end
    end)
end

function printDebug(...)
    if Config.Debug then
        print(...)
    end
end

function GetCustomVehicleClass(vehicle)
    for k, v in pairs(Config.CustomClasses) do
        for _, j in pairs(v.vehicles) do
            if (GetHashKey(j) == GetEntityModel(vehicle)) then
                return k, v.limit
            end
        end
    end
    return false
end
