fx_version 'adamant'

game 'gta5'

description 'ESX Mechanic Job'

version '1.0.1'

client_scripts {
	'@es_extended/locale.lua',
	'locales/en.lua',
	'locales/nl.lua',
	'config.lua',
	'client/main.lua'
}

server_scripts {
	'@es_extended/locale.lua',
	'locales/en.lua',
	'locales/nl.lua',
	'config.lua',
	'@mysql-async/lib/MySQL.lua',
	'server/main.lua'
}

dependencies {
	'es_extended',
	'esx_society',
	'esx_billing'
}
exports { 'OpenMobileMechanicActionsMenu' }
