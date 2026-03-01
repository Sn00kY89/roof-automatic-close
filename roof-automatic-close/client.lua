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
                
                -- Verifica nativa se il veicolo ha un tetto apribile (tasto H)
                if IsVehicleAConvertible(trackedVehicle, false) then
                    
                    -- FIX PER AUTO MODDATE: Rimosso il controllo dello "stato" del tetto.
                    -- Spesso le auto add-on dicono al gioco di essere "chiuse" anche quando sono aperte.
                    -- Chiamando direttamente RaiseConvertibleRoof forziamo l'animazione di chiusura in ogni caso.
                    RaiseConvertibleRoof(trackedVehicle, false)
                    
                end
                
                -- CHICCA EXTRA: De-commenta le righe qui sotto (togliendo i due trattini --) 
                -- se vuoi che anche i finestrini si chiudano da soli quando chiudi la macchina!
                RollUpWindow(trackedVehicle, 0)
                RollUpWindow(trackedVehicle, 1)
                RollUpWindow(trackedVehicle, 2)
                RollUpWindow(trackedVehicle, 3)
            end
            
            -- Aggiorniamo lo stato precedente per il prossimo ciclo
            wasLocked = isLocked
        end
    end
end)