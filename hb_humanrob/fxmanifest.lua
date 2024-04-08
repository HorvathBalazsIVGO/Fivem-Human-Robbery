fx_version 'cerulean'
games { 'gta5' }
author 'Horvath Balazs'
version '2.0'
lua54 'yes'
client_scripts {
'client.lua',
}

server_scripts {
'server.lua',
}

shared_script {
    '@es_extended/imports.lua',
    'config.lua'
}
