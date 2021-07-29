-----------------------------
------ By Sam - 0.01 ms -----
------- Rodéo Scripts -------
--- Vend Script pas chère ---
--- discord.gg/XeDSqUGcks ---
-----------------------------

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(5000)
	end
end)

--- FUNCTION KEYBOARD INPUT ---
function KeyboardInput(TextEntry, ExampleText, MaxStringLenght)
    AddTextEntry('FMMC_KEY_TIP1', TextEntry)
    blockinput = true
    DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", ExampleText, "", "", "", 10)
    while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do 
        Wait(0)
    end 
        
    if UpdateOnscreenKeyboard() ~= 2 then
        local result = GetOnscreenKeyboardResult()
        Wait(500)
        blockinput = false
        return result
    else
        Wait(500)
        blockinput = false
        return nil
    end
end

-- MENU --
local mainMenu = RageUI.CreateMenu("Blanchiment", "Rodeo Scripts")

function OpenMenu()
     if open then 
         open = false
         RageUI.Visible(mainMenu, false)
         return
     else
         open = true 
         RageUI.Visible(mainMenu, true)
         CreateThread(function()
         while open do 


            RageUI.IsVisible(mainMenu,function() 

                RageUI.Separator("~h~↓ ~b~Le Blanchisseur Pedro~s~ ↓")

				RageUI.Button("Blanchir de l'argent", "Pedro prend ~r~10% du blanchiment !", {RightLabel = "→→→"}, true , {
					onSelected = function()
						local argent = KeyboardInput("Combien d'argent(s) Sale(s) as-tu ?", '' , '', 8)
						TriggerServerEvent('rodeo:blanchiment', argent)	
					end
				})

            end)
          Wait(0)
         end
      end)
   end
end

--- OUVERTURE DU MENU ---

local position = {
	{x = -1150.61, y = -1567.59, z = 4.42},
}  

Citizen.CreateThread(function()
    while true do
        NearZone = false

        for k,v in pairs(position) do

				local interval = 1
            	local pos = GetEntityCoords(GetPlayerPed(-1), false)
            	local dest = vector3(v.x, v.y, v.z)
            	local distance = GetDistanceBetweenCoords(pos, dest, true)
            	if distance > 2 then
                	interval = 1
            	else
                	interval = 1

                	local dist = Vdist(pos.x, pos.y, pos.z, position[k].x, position[k].y, position[k].z)
                	NearZone = true 

                	if distance < 3 then
                    	if not InAction then 
						Visual.Subtitle("Appuyer sur ~g~[E]~s~ pour accéder au ~g~Menu", 0) 
                    end
                    if IsControlJustReleased(1,51) then
                        OpenMenu()
                    end
                end
                break
            end
        end
        if not NearZone then 
            Wait(500)
        else
            Wait(1)
        end
    end
end)

--- PED ---

Citizen.CreateThread(function()
    local hash = GetHashKey("g_m_y_mexgoon_02")
    while not HasModelLoaded(hash) do
    RequestModel(hash)
      Wait(20)
    end
    ped = CreatePed("PED_TYPE_CIVFEMALE", "g_m_y_mexgoon_02", -1150.61, -1567.59, 3.42, 42.00, false, true) -- remplacer x, y, z par coordonnés
    SetBlockingOfNonTemporaryEvents(ped, true)
    FreezeEntityPosition(ped, true)
end)