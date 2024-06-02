local isDead = false

AddEventHandler('esx:onPlayerDeath', function(data)
    if not isDead then
        isDead = true
        TriggerServerEvent('autoRevive:checkPlayerDeath')
    end
end)

AddEventHandler('esx:onPlayerSpawn', function()
    isDead = false
end)
