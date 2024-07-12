Config = {}

Config.SpeedLimitActive = true -- true | false >> turns on/off the script

Config.Debug = false

------------------------------------------------------
----- Shutdown settings
------------------------------------------------------

Config.UseDelay = true -- true | false --> if set to false, once the vehicle reaches the speed limit it will immediatly be shut down

-- warning delay before shutting down vehicle
Config.Delay = 3000

-- sends a notification to the player as warning before
-- shutting down the vehicle after the set delay
Config.Warn = function(text)
    SetNotificationTextEntry("STRING")
    AddTextComponentString("You are over the speed limit ! Vehicle will be disabled in 3 seconds unless you slow down !")
    DrawNotification(false, false)
    PlaySoundFrontend(-1, "TIMER_STOP", "HUD_MINI_GAME_SOUNDSET", 1)
end

------------------------------------------------------
----- Default GTA vehicle classes
------------------------------------------------------

-- kmh or mph
Config.SpeedType = "kmh"

-- speed per class | write the speed limit based on the chosen SpeedType 100kmh is not equal to 100mph
Config.ClassesLimit = {
    [0] = 100,  -- Compacts
    [1] = 100,  -- Sedans
    [2] = 100,  -- SUVs
    [3] = 100,  -- Coupes
    [4] = 100,  -- Muscle
    [5] = 100,  -- Sports Classics
    [6] = 100,  -- Sports
    [7] = 100,  -- Super
    [8] = 100,  -- Motorcycles
    [9] = 100,  -- Off-road
    [10] = 100, -- Industrial
    [11] = 100, -- Utility
    [12] = 100, -- Vans
    [13] = 100, -- Cycles
    [14] = 100, -- Boats
    [15] = 100, -- Helicopters
    [16] = 100, -- Planes
    [17] = 100, -- Service
    [18] = 100, -- Emergency
    [19] = 100, -- Military
    [20] = 100, -- Commercial
    [21] = 100, -- Trains
}

------------------------------------------------------
----- Custom vehicle classes
------------------------------------------------------

Config.UsingCustomClasses = true -- true | false >> will override the default classes above

--[[
    to create a custom class simply copy this :

    ["SET_THE_CLASS_NAME_HERE"] = {
        limit = 0, -- set the limit ( a number ! )
        vehicles = {
            -- write the names of the vehicles ( example : "panto" )
        }
    },

    and add it inside the array below

]]
Config.CustomClasses = {
    ["alpha"] = {
        limit = 70,
        vehicles = {
            "panto"
        }
    },
    ["beta"] = {
        limit = 150,
        vehicles = {
            "t20"
        }
    },
    ["gamma"] = {
        limit = 110,
        vehicles = {
            "primo"
        }
    }
}
