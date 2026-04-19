-- Variabili per tracciare l'ultimo veicolo guidato e il suo stato
local trackedVehicle = nil
local wasLocked = false

Citizen.CreateThread(function()
    while true do
        -- Attendiamo 500ms per ciclo per non pesare sulle prestazioni
        Citizen.Wait(500) 
        
        local ped = PlayerPedId()
        local currentVeh = GetVehiclePedIsIn(ped, false)
        
        -- Aggiorniamo il veicolo da tenere sotto controllo
        if currentVeh ~= 0 then
            trackedVehicle = currentVeh
            -- Se siamo dentro, tracciamo lo stato attuale per evitare chiusure accidentali appena scendiamo
            wasLocked = (GetVehicleDoorLockStatus(currentVeh) >= 2)
        elseif trackedVehicle == nil then
            -- Prende l'ultimo veicolo in cui è stato il giocatore
            trackedVehicle = GetVehiclePedIsIn(ped, true) 
        end
        
        -- Controlliamo se abbiamo un veicolo, se esiste e se il giocatore è sceso (currentVeh == 0)
        if trackedVehicle ~= nil and currentVeh == 0 and DoesEntityExist(trackedVehicle) then
            
            -- Otteniamo lo stato della serratura
            local lockStatus = GetVehicleDoorLockStatus(trackedVehicle)
            local isLocked = (lockStatus >= 2) 
            
            -- Se il veicolo è appena stato chiuso a chiave e prima non lo era
            if isLocked and not wasLocked then
                -- Impostiamo una State Bag sul veicolo.
                -- "true" alla fine dice a FiveM di replicare (sincronizzare) questo dato per tutti i client.
                -- Usiamo GetGameTimer() per avere un valore sempre diverso a ogni singola chiusura.
                Entity(trackedVehicle).state:set('roofAutoCloseTrigger', GetGameTimer(), true)
            end
            
            -- Aggiorniamo lo stato precedente per il prossimo ciclo
            wasLocked = isLocked
        end
    end
end)

-- Ascoltatore per la State Bag, si attiva per TUTTI i client quando la State Bag viene aggiornata
AddStateBagChangeHandler('roofAutoCloseTrigger', nil, function(bagName, key, value, _reserved, replicated)
    if not value then return end
    
    local entity = GetEntityFromStateBagName(bagName)
    
    -- Se l'entità non esiste (o non esiste ANCORA per questo client), ci fermiamo
    if not entity or entity == 0 or not DoesEntityExist(entity) then return end
    
    -- Essendo un'operazione visiva, la facciamo eseguire localmente dal motore grafico
    if IsVehicleAConvertible(entity, false) then
        RaiseConvertibleRoof(entity, false)
    end
    
    RollUpWindow(entity, 0)
    RollUpWindow(entity, 1)
    RollUpWindow(entity, 2)
    RollUpWindow(entity, 3)
end)