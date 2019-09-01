local Keys = {
  ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
  ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
  ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
  ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
  ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
  ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
  ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
  ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
  ["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

local PlayerData = {}
local HasAlreadyEnteredMarker = false
local LastStation, LastPart, LastPartNum, LastEntity
local CurrentAction = nil
local CurrentActionMsg  = ''
local CurrentActionData = {}
local IsHandcuffed = false
local HandcuffTimer = {}
local DragStatus = {}
DragStatus.IsDragged = false
local hasAlreadyJoined = false
local blipsCops = {}
local isDead = false
local CurrentTask = {}
local playerInService = false
local spawnedVehicles, isInShopMenu = {}, false

ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end
	PlayerData = ESX.GetPlayerData()
end)

function cleanPlayer(playerPed)
	SetPedArmour(playerPed, 0)
	ClearPedBloodDamage(playerPed)
	ResetPedVisibleDamage(playerPed)
	ClearPedLastWeaponDamage(playerPed)
	ResetPedMovementClipset(playerPed, 0)
end

function setUniform(job, playerPed)
	TriggerEvent('skinchanger:getSkin', function(skin)
		if skin.sex == 0 then
			if Config.Uniforms[job].male ~= nil then
				TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms[job].male)
			else
				ESX.ShowNotification(_U('no_outfit'))
			end
			if job == 'Balistic_Vest' then
				SetPedArmour(playerPed, 100)
			end
		else
			if Config.Uniforms[job].female ~= nil then
				TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms[job].female)
			else
				ESX.ShowNotification(_U('no_outfit'))
			end
			if job == 'Balistic_Vest' then
				SetPedArmour(playerPed, 100)
			end
		end
	end)
end

function OpenCloakroomMenu()

	local playerPed = PlayerPedId()
	local grade = PlayerData.job.grade_name

	local elements = {
		{ label = "Get Out Of Uniform", value = 'citizen_wear' },
		{ label = "Balistic Vest", value = 'Balistic_Vest' },
		{ label = "Duty Belt (1)", value = 'Duty_belt_1' },
		{ label = "Duty Belt (2)", value = 'Duty_belt_2' },
		{ label = "Duty Belt (3)", value = 'Duty_belt_3' },
		{ label = "Duty Belt (4)", value = 'Duty_belt_4' },
		{ label = "Remove Bag", value = 'Remove_Bag' },
		{ label = "Remove Vest", value = 'remove_vest' },
		{ label = "Tactical Top (Black)", value = 'Tactical_Top_SWAT' },
		{ label = "Tactical Top (Green)", value = 'Tactical_Top_SERT' },
		{ label = "Tactical Top (Grey)", value = 'Tactical_Top_SESU' },
		{ label = "Police Top", value = 'Police_Shirt' },
		{ label = "Police Pants", value = 'Suit_Pants' },
		{ label = "Tactical Pants", value = 'Tactical_Pants' },
		{ label = "Police Shoes", value = 'Suit_Shoes' },
		{ label = "Police Boots", value = 'Posh_Work_Shoes' },
		{ label = "Tactical Boots", value = 'Tactical_Shoes' },
		{ label = "Police ID (1)", value = 'Police_ID_1' },
		{ label = "Police ID (2)", value = 'Police_ID_2' },
		{ label = "Remove Helmet", value = 'remove_helmet' },
		{ label = "Basic Helmet", value = 'Basic_Helmet' },
		{ label = "Police Hat", value = 'Police_Hat' },
		{ label = "Black Cap", value = 'Black_Cap' },
		{ label = "Enhanced Helmet", value = 'Enhanced_Helmet' },
		{ label = "Riot Helmet", value = 'Riot_Helmet' },
		{ label = "Black Beanie", value = 'Black_Beanie' }
	}
--[[
	table.insert(elements, {label = 'State Police Uniform', value = 'freemode_ped', maleModel = 's_m_y_hwaycop_01', femaleModel = 's_m_y_hwaycop_01'})
	table.insert(elements, {label = 'SWAT Uniform (3)', value = 'freemode_ped', maleModel = 's_m_y_swat_01', femaleModel = 's_m_y_swat_01'})
--]]
	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'cloakroom',
	{
		title    = _U('cloakroom'),
		align    = 'top-left',
		elements = elements
	}, function(data, menu)

		cleanPlayer(playerPed)

		if data.current.value == 'citizen_wear' then
			
			if Config.EnableNonFreemodePeds then
				ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
					local isMale = skin.sex == 0

					TriggerEvent('skinchanger:loadDefaultModel', isMale, function()
						ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
							TriggerEvent('skinchanger:loadSkin', skin)
							TriggerEvent('esx:restoreLoadout')
						end)
					end)

				end)
			else
				ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
					TriggerEvent('skinchanger:loadSkin', skin)
				end)
			end
		end
		if
			
			data.current.value == 'Balistic_Vest' or
			data.current.value == 'Remove_Bag' or
			data.current.value == 'Duty_belt_1' or
			data.current.value == 'Duty_belt_2' or
			data.current.value == 'Duty_belt_3' or
			data.current.value == 'Duty_belt_4' or
			data.current.value == 'remove_vest' or
			data.current.value == 'Tactical_Top_SWAT' or
			data.current.value == 'Tactical_Top_SERT' or
			data.current.value == 'Tactical_Top_SESU' or
			data.current.value == 'Police_Shirt' or
			data.current.value == 'Suit_Pants' or
			data.current.value == 'Tactical_Pants' or
			data.current.value == 'Suit_Shoes' or
			data.current.value == 'Posh_Work_Shoes' or
			data.current.value == 'Tactical_Shoes' or
			data.current.value == 'Police_ID_1' or
			data.current.value == 'Police_ID_2' or
			data.current.value == 'remove_helmet' or
			data.current.value == 'Basic_Helmet' or
			data.current.value == 'Police_Hat' or
			data.current.value == 'Black_Cap' or
			data.current.value == 'Enhanced_Helmet' or
			data.current.value == 'Riot_Helmet' or
			data.current.value == 'Black_Beanie'		
		then
			setUniform(data.current.value, playerPed)
		end

		if data.current.value == 'freemode_ped' then
			local modelHash = ''

			ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
				if skin.sex == 0 then
					modelHash = GetHashKey(data.current.maleModel)
				else
					modelHash = GetHashKey(data.current.femaleModel)
				end

				ESX.Streaming.RequestModel(modelHash, function()
					SetPlayerModel(PlayerId(), modelHash)
					SetModelAsNoLongerNeeded(modelHash)

					TriggerEvent('esx:restoreLoadout')
				end)
			end)

		end

	end, function(data, menu)
		menu.close()
		CurrentAction     = 'menu_cloakroom'
		CurrentActionMsg  = _U('open_cloackroom')
		CurrentActionData = {}
	end)
end

AddEventHandler('esx_policejob:hasEnteredMarker', function(station, part, partNum)
	if part == 'Cloakroom' then
		CurrentAction     = 'menu_cloakroom'
		CurrentActionMsg  = _U('open_cloackroom')
		CurrentActionData = {}
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if PlayerData.job ~= nil and PlayerData.job.name == 'police' then
			local playerPed = PlayerPedId()
			local coords    = GetEntityCoords(playerPed)
			local pedX, pedY, pedZ = table.unpack(GetEntityCoords(GetPlayerPed(-1), true))
			local isInMarker, hasExited, letSleep = false, false, true
			local currentStation, currentPart, currentPartNum

			local cloakroomsTable = {
			    {X = 452.6,Y = -992.8,Z = 30.6},
			    {X = -3257.45,Y = 1225.79,Z = 2.64},
			    {X = -450.2878112793,Y = 6016.482421875,Z = 31.716369628906},
			    {X = 1857.2354736328,Y = 3689.8408203125,Z = 34.26708984375}
			}

			for k, _ in pairs(cloakroomsTable) do
				local distance = Vdist(pedX, pedY, pedZ, cloakroomsTable[k].X, cloakroomsTable[k].Y, cloakroomsTable[k].Z)
				if distance < 6.0 then
					DrawMarker(20, cloakroomsTable[k].X, cloakroomsTable[k].Y, cloakroomsTable[k].Z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.0, 1.0, 1.0, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, true, false, false, false)
					letSleep = false
					SetNotificationTextEntry("STRING")
                    AddTextComponentString("<b>Press E To Open The Cloakroom</b>")
                    DrawNotification(true, false)
					if IsControlJustReleased(0, Keys['E']) then
						OpenCloakroomMenu()
						CurrentAction = nil
					end
				end
			end
		end
	end
end)