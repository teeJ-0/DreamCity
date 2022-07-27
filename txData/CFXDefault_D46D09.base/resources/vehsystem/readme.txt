Installation instructions:

First you need to import db.sql into your database.
Second you need to copy this resource folder into your resources folder.
Add the following line to the server.cfg: start codev_vehsystem

If you want mechanics to be able to use /fixengine and /fixstart commands you'll have to add the following ace permissions in server.cfg

Where example would go the steam:hexid
#add_ace identifier.steam:example codev_vehsystem.fixengine allow
#add_ace identifier.steam:example codev_vehsystem.fixstart allow

If you want to allow all admins it would be like this:
#add_ace group.admin codev_vehsystem allow

Owned vehicles purchased through a vehicle shop, which store data in owned_vehicles, are the ones that will have the mileage stored in the data base, otherwise the data will be stored on the server until the server is restarted.

Cars will be locked through database and will allow car owners to have a more safe way of locking/unlocking the cars and also provide an ESX callback to return either the car is open or not, this can be used for things such as trunk.
This option can be disabled from cl_config.lua

Make sure to change the sv_config.lua setting for ownerIdentifier type, steam, license or fivem and also set if you want to use the key lock system.

Important information:

Do not rename the script.
Do not resell the script.

If you have an idea of a script you'd like to see for sale let us know on our discord: https://discord.gg/EmxJKp2W3g