ESX = exports["es_extended"]:getSharedObject()

local robberyStarted = false

local robberyTimer = nil

local startRobberyBlip = function(pro)
    if pro == true then
    local blip = AddBlipForCoord(3627.86, 3765.84, 28.52)
    SetBlipSprite(blip, 1)
    SetBlipDisplay(blip, 176)
    SetBlipScale  (blip, 1.2)
	SetBlipColour (blip, 1)
	SetBlipAsShortRange(blip, true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString('Rablas')
	EndTextCommandSetBlipName(blip)
    else
    end
end

local timer = function(robberyTime)
    if robberyTimer ~= nil then
        Citizen.Wait(1000) -- Ha már van szöveg a képernyőn, várjunk egy másodpercet, mielőtt újra rajzolnánk
    end
    robberyTimer = robberyTime
    Citizen.CreateThread(function()
        while robberyTimer > 0 do
            Wait(0)
            print("Rablás: " .. robberyTimer .. " másodperc")
            robberyTimer = robberyTimer - 1
        end
        robberyTimer = nil
        startRobberyBlip(false)
    end)
end




Citizen.CreateThread(function()
    while true do
    Citizen.Wait(0)
    local startCoords = vector3(3627.86, 3765.84, 28.52)
    local player = GetPlayerPed(-1)
    local playerPos = GetEntityCoords(player)
    local dist = #(playerPos - startCoords)
    DrawMarker(21, startCoords.x, startCoords.y, startCoords.z, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 1.0, 1.0, 1.0, 255, 128, 0, 50, false, true, 2, nil, nil, false)
    if robberyStarted == false then
        if dist < 2.5 then
            DrawText3D(startCoords.x, startCoords.y, startCoords.z, "~g~Nyomj E-t a rablás elkezdéséhez")
            if IsControlJustPressed(0, 38) then
                --TriggerClientEvent('okokNotify:Alert', source, 'Human Rablas', 'Rablas Megkezdve!', 30000, 'Succes', true)
                StartRobbery()
                notifyPolice()
                timer(30000)
            end
        end
    end
end
end)

local robOP = false


function StartRobbery()
    robberyStarted = true
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local startCoords = vector3(3627.86, 3765.84, 28.52)
        local player = GetPlayerPed(-1)
        local playerPos = GetEntityCoords(player)
        local dist = #(playerPos - startCoords)
        if dist >= 200 then
            robberyStarted = false
            timer(0)
            startRobberyBlip(false)
        end
    end
end)


Citizen.CreateThread(function()
    while true do
    Citizen.Wait(0)
    local startCoords = vector3(3627.86, 3765.84, 28.52)
    local player = GetPlayerPed(-1)
    local playerPos = GetEntityCoords(player)
    local dist = #(playerPos - startCoords)
    if dist <= 100 then
        TriggerEvent('chat:addMessage', {
            color = { 255, 0, 0},
            multiline = true,
            args = {"[Server]", "Beleptel a human zonabol!"}
          })
    elseif dist >= 101 then
        TriggerEvent('chat:addMessage', {
            color = { 255, 0, 0},
            multiline = true,
            args = {"[Server]", "Kileptel a human zonabol!"}
          })
    end
    end
end)


Citizen.CreateThread(function()
    while true do
    Citizen.Wait(0)
    local hack1 = vector3(3628.17, 3759.89, 28.52)
    local rob = vector3(3625.49, 3761.47, 28.52)
    local dist = #(GetEntityCoords(GetPlayerPed(-1)) - hack1)
    local dist2 = #(GetEntityCoords(GetPlayerPed(-1)) - rob)
    if robberyStarted == true then
        DrawMarker(21, hack1.x, hack1.y, hack1.z, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 1.0, 1.0, 1.0, 255, 0, 0, 50, false, true, 2, nil, nil, false)
        if dist <= 2.5 then
            DrawText3D(hack1.x, hack1.y, hack1.z, "~g~Nyomj E-t a Hackeles elkezdéséhez")
            if IsControlJustPressed(0, 38) then
                exports['progressBars']:startUI(25000, "Hacking...")
                hackComplete()
            end
        end
        if robOP == true then
            DrawMarker(21, rob.x, rob.y, rob.z, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 1.0, 1.0, 1.0, 255, 0, 0, 50, false, true, 2, nil, nil, false)
            if dist2 <= 2.5 then
                DrawText3D(rob.x, rob.y, rob.z, "~g~Nyomj E-t a Szef Kirablasahoz")
                if IsControlJustPressed(0, 38) then
                    exports['progressBars']:startUI(25000, "Feltores...")
                    Wait(25000)
                    stopCrackSafe()
                    TriggerServerEvent('payout', source)
                end
            end
        end
    end
    end
end)

function notifyPolice()
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if ESX.PlayerData.job.name == "police" then
            if robberyStarted == true then
                startRobberyBlip(true)
                TriggerEvent('chat:addMessage', {
                    color = { 255, 0, 0},
                    multiline = true,
                    args = {"[Police Alert]", "Rablas Kezdodott Humanban!"}
                  })
                  Wait(10 ^ 10)
            end
        else
            return print(false);
        end
    end
end)
end

function hackComplete()
    robOP = true
    --TriggerClientEvent('okokNotify:Alert', source, 'Hackeles', 'Hackeles Sikeres!', 30000, 'Succes', true)
end

function stopCrackSafe()
    robOP = false
end

Citizen.CreateThread(function()
    local blip = AddBlipForCoord(3627.86, 3765.84, 28.52)
    local blip2 = AddBlipForRadius(3627.86, 3765.84, 28.52, 100.0) -- need to have .0
    SetBlipColour(blip2, 1)
    SetBlipAlpha(blip2, 128)
    SetBlipSprite(blip, 110)
    SetBlipDisplay(blip, 176)
    SetBlipScale  (blip, 1.0)
	SetBlipColour (blip, 1)
	SetBlipAsShortRange(blip, true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString('Human Rablas')
	EndTextCommandSetBlipName(blip)
	end)

function DrawText3D(x, y, z, text)
    local onScreen,_x,_y=World3dToScreen2d(x, y, z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 68)
end




