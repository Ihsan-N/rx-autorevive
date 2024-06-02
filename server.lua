local ESX = exports['es_extended']:getSharedObject()

local reviveTimer = 60 -- 1 minutes in seconds change the time here

local function isAmbulanceJobOnline()
    local players = ESX.GetPlayers()
    for i = 1, #players, 1 do
        local xPlayer = ESX.GetPlayerFromId(players[i])
        if xPlayer.job.name == 'ambulance' then
            return true
        end
    end
    return false
end

RegisterNetEvent('autoRevive:checkPlayerDeath')
AddEventHandler('autoRevive:checkPlayerDeath', function()
    local playerId = source
    local xPlayer = ESX.GetPlayerFromId(playerId)

    -- Notify the player about the auto-revive timer
    TriggerClientEvent('ox_lib:notify', playerId, {
        type = 'info',
        description = 'You will be automatically revived in 3 minutes if no EMS is available.',
        duration = 5000
    })

    -- Set a timer to revive the player if no EMS is online
    Citizen.SetTimeout(reviveTimer * 1000, function()
        if not isAmbulanceJobOnline() then
            TriggerClientEvent('esx_ambulancejob:revive', playerId)
            TriggerClientEvent('ox_lib:notify', playerId, {
                type = 'success',
                description = 'You have been automatically revived.',
                duration = 5000
            })
        else
            TriggerClientEvent('ox_lib:notify', playerId, {
                type = 'info',
                description = 'EMS is available. Please wait for assistance.',
                duration = 5000
            })
        end
    end)
end)

-- Command to force check and revive (for testing purpose)
--[[RegisterCommand('checkrevive', function(source)
    local playerId = source
    if not isAmbulanceJobOnline() then
        TriggerClientEvent('esx_ambulancejob:revive', playerId)
        TriggerClientEvent('ox_lib:notify', playerId, {
            type = 'success',
            description = 'You have been automatically revived.',
            duration = 5000
        })
    else
        TriggerClientEvent('ox_lib:notify', playerId, {
            type = 'info',
            description = 'EMS is available. Please wait for assistance.',
            duration = 5000
        })
    end
end, false)
]]--
