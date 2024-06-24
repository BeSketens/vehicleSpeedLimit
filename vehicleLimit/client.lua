Citizen.CreateThread(function()
    local interval, ped
    local speedType = Config.SpeedType

    local vehicle, vehicleClass, limit, speed
    while true do
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

        vehicleClass = GetVehicleClass(vehicle)
        limit = Config.ClassesLimit[vehicleClass]

        if speedType == "kmh" then
            speed = math.ceil(GetEntitySpeed(vehicle) * 3.6)
        elseif speedType == "mph" then
            speed = math.ceil(GetEntitySpeed(vehicle) * 2.236936)
        else
            print("ERROR : wrong speed type > kmh or mph only")
            goto next
        end

        printDebug("Speed type : ", speedType)
        printDebug("Vehicle class : ", vehicleClass)
        printDebug("Speed : ", speed .. speedType)
        printDebug("Limit : ", limit .. speedType)


        if speed > limit then
            printDebug("----------")
            printDebug("- Vehicle engine killed -")
            printDebug("----------")
            SetVehicleEngineOn(vehicle, false, false, true)
            SetVehicleEngineHealth(vehicle, -100.00)
        end

        ::next::

        Wait(interval)
    end
end)

function printDebug(...)
    if Config.Debug then
        print(...)
    end
end
