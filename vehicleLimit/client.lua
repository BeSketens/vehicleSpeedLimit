if Config.SpeedLimitActive then
    Citizen.CreateThread(function()
        local interval, ped
        local speedType = Config.SpeedType

        local multiplier

        if speedType == "kmh" then
            multiplier = 3.6
        elseif speedType == "mph" then
            multiplier = 2.236936
        else
            print("[ERROR] : Wrong speed type chosen - Script stopped")
            return
        end

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

            speed = math.ceil(GetEntitySpeed(vehicle) * multiplier)

            -- goto added because with the custom classes some
            -- vehicles won't have a set speed limit
            if not vehicleClass then goto next end

            printDebug("Speed type : ", speedType)
            printDebug("Vehicle class : ", vehicleClass)
            printDebug("Speed : ", speed .. speedType)
            printDebug("Limit : ", limit .. speedType)

            if speed > limit then
                if Config.UseDelay then
                    Config.Warn()

                    Wait(Config.Delay)

                    speed = math.ceil(GetEntitySpeed(vehicle) * multiplier)

                    if speed > limit then
                        killVehicle(vehicle)
                    end
                else
                    killVehicle(vehicle)
                end
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

function killVehicle(veh)
    printDebug("----------")
    printDebug("- Vehicle engine killed -")
    printDebug("----------")
    SetVehicleEngineOn(veh, false, true, true)
    SetVehicleEngineHealth(veh, 0.00)
end
