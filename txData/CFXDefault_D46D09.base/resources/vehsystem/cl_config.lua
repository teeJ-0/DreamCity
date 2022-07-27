config = {
    key = 47, -- https://docs.fivem.net/docs/game-references/controls/
    lang = {
        turnOnEngine = "Turn on Engine with G", -- add the Control Name based on your key above, if the key is 47 your Control Name should be ~INPUT_DETONATE~.
        turnOnIgnition = "Start car by holding G", -- if the key is 38 your control name would be ~INPUT_PICKUP~.
        turnOffIgnition = "Stop car by holding G",
        openCar = "~g~Car is open.", -- car is open
        closeCar = "~r~Car is closed.", -- car is closed
        tooMuch = "~r~Estas pulsando demasiado deprisa, espera un segundo.", -- pressing too much the unlock/lock key
        youOpen = "Has ~g~abierto~s~ tu ~y~", -- you've opened your .. plate
        youClose = "Has ~r~cerrado~s~ tu ~y~" -- you've opened your .. plate
    },
    startCheck = { -- you can add here as many as you want
        {moreThan = 0.0, time = 0.5}, -- if the last start check is more than {moreThan} mileage the starting time will be {time} in seconds.
        {moreThan = 250.0, time = 3},
        {moreThan = 450.0, time = 4},
        {moreThan = 650.0, time = 7},
        {moreThan = 950.0, time = 9},
        {moreThan = 1250.0, time = 12},
        {moreThan = 1750.0, time = 15},
        {moreThan = 2350.0, time = 20},
        {moreThan = 2950.0, time = 25},
        {moreThan = 5050.0, time = 45}
    },
    engineCheck = { -- you can add here as many as you want
        {moreThan = 250.0, maxHealth = 950.0}, -- if the last engine check is more than {moreThan} mileage the maximum engine health will be {maxHealth}
        {moreThan = 450.0, maxHealth = 900.0},
        {moreThan = 850.0, maxHealth = 800.0},
        {moreThan = 1250.0, maxHealth = 700.0},
        {moreThan = 1850.0, maxHealth = 650.0},
        {moreThan = 2350.0, maxHealth = 550.0},
        {moreThan = 2750.0, maxHealth = 450.0},
        {moreThan = 3350.0, maxHealth = 350.0}
    },
    autoSaving = 30, -- this will autosave the current vehicle every {autoSaving} seconds.
    useLockSystem = false -- setting this to true will use the lock system to lock unlock cars with the L key
}