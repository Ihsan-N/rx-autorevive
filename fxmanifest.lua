fx_version 'adamant'

game 'gta5'
author 'Rwix'
description 'Auto Revive Script'
lua54 'yes'
version '1.0.0'

server_scripts {
    '@ox_lib/init.lua',
    'server.lua'
}

client_scripts {
    'client.lua'
}
dependencies {
    'es_extended',
    'ox_lib',
    'esx_ambulancejob'
}
