version = "3.0"
pName = player.name

-- Saying hello
windower.add_to_chat(8,'----- Welcome back to your GEO.lua, '..pName..' -----')

runspeedslot = 'feet'

--------------------------------------------------------------------------------------------------------------
-- HUD STUFF
--------------------------------------------------------------------------------------------------------------
meleeing = M('AUTO', 'OFF', 'ON')
lock = M('OFF', 'ON')
mBurst = M(false)
runspeed = M('OFF', 'ON')
oldElement = elements.current
mBurstOldValue = mBurst.value
matchsc = M('AUTO', 'OFF', 'ON')
MB_Window = 0   
time_start = 0

luopanMode = 'me'         -- me or pan (me = no luopan, pan = luopan is out)

setupTextWindow()
 
function precast(spell)
    if meleeing.value == "AUTO" then
        if player.tp >= lockWeaponTP then
            lock:set('ON')
        else
            lock:set('OFF')
        end
        lockMainHand(lock.value, pet)
    end
    -- Auto use Echo Drops if you are trying to cast while silenced --    
    if spell.action_type == 'Magic' and buffactive['Silence'] then 
        cancel_spell()
        send_command('input /item "Echo Drops" <me>')     
        add_to_chat(123, '****** ['..spell.name..' CANCELED - Using Echo Drops] ******')        
    end   

    if spell.type == 'WhiteMagic' or spell.type == 'BlackMagic' or  spell.type == 'Geomancy' then
     
        -- Stoneskin Precast
        if spell.name == 'Stoneskin' then
         
            windower.ffxi.cancel_buff(37)--[[Cancels stoneskin, not delayed incase you get a Quick Cast]]
            equip(sets.precast.stoneskin)
             
        -- Cure Precast
        elseif spell.name:match('Cure') or spell.name:match('Cura') then
         
            equip(sets.precast.cure)
             
        -- Enhancing Magic
        elseif spell.skill == 'Magic' then
         
            equip(sets.precast.enhancing)
             
            if spell.name == 'Sneak' then
                windower.ffxi.cancel_buff(71)--[[Cancels Sneak]]
            end
        elseif spell.type == 'Geomancy' then
            equip(sets.precast.geomancy)
        else
            -- For everything else we go with max fastcast
            equip(sets.precast.casting)
             
        end
    end 
    -- Job Abilities
    -- We use a catch all here, if the set exists for an ability, use it
    -- This way we don't need to write a load of different code for different abilities, just make a set
     
    if sets.precast[spell.name] then
        equip(sets.precast[spell.name])
    end
     
end
 
function midcast(spell)
    -- Get the spell mapping, since we'll be passing it to various functions and checks.
    local spellMap = get_spell_map(spell)    
    -- No need to annotate all this, it's fairly logical. Just equips the relevant sets for the relevant magic
    if spell.name:match('Cure') or spell.name:match('Cura') then
        if spell.element == world.weather_element or spell.element == world.day_element then
            equip(sets.midcast.cure.weather)
        else
            equip(sets.midcast.cure.normal)
        end
    elseif spell.skill == 'Enhancing Magic' then
        equip(sets.midcast.enhancing)
        if spell.name:match('Protect') or spell.name:match('Shell') then
            equip({rring="Sheltered Ring"})
        elseif spell.name:match('Refresh') then
            equip(sets.midcast.refresh)
        elseif spell.name:match('Regen') then
            equip(sets.midcast.regen)
        elseif spell.name:match('Aquaveil') then
            equip(sets.midcast.aquaveil)
        end
    elseif spell.skill == 'Enfeebling Magic' and spell.type == 'BlackMagic' then -- to do: better rule for this.
        equip(sets.midcast.IntEnfeebling)
    elseif spell.skill == 'Enfeebling Magic' and spell.type == 'WhiteMagic' then -- to do: better rule for this.
        equip(sets.midcast.MndEnfeebling)
    elseif spell.type == 'BlackMagic' then
        if mBurst.value == true then
            equip(sets.midcast.MB[nukeModes.current])
        else
            equip(sets.midcast.nuking[nukeModes.current])
        end
    -- casting is basically enfeeble set.
    elseif spell.name:match('Geo') then
        equip(sets.midcast.geo)
    elseif spell.name:match('Indi') then
		-- check for entrust
		if buffactive['Entrust'] then
			equip(sets.midcast.entrust)
		else
			equip(sets.midcast.indi)
		end
    else
        equip(sets.midcast.casting)
    end
    -- And our catch all, if a set exists for this spell name, use it
    if sets.midcast[spell.name] then
        equip(sets.midcast[spell.name])
    -- Catch all for tiered spells (use mapping), basically if no set for spell name, check set for spell mapping. AKA Drain works for all Drain tiers.
    elseif sets.midcast[spellMap] then
        equip(sets.midcast[spellMap])
    -- Remember those WS Sets we defined? :) sets.me["Insert Weaponskill"] are basically how I define any non-magic spells sets, aka, WS, JA, Idles, etc.
    elseif sets.me[spell.name] then
        equip(sets.me[spell.name])
    end
    
    -- Obi up for matching weather / day
    if spell.element == world.weather_element and spellMap ~= 'Helix'then
        equip(sets.midcast.Obi)
    end
    if spell.element == world.day_element and spellMap ~= 'Helix'then
        equip(sets.midcast.Obi)
    end
    -- This needs to be here for if you cast stoneskin on earthsday if doesnt swap to obi --___--;
    if spell.name:match('Stoneskin') then
            equip(sets.midcast.stoneskin)
    end
end
 
function aftercast(spell)
     -- Then initiate idle function to check which set should be equipped
    idle(pet)
end

function pet_change(pet, gain)
    -- When we cast a luopan
    idle(pet)
end

function idle(pet)
 
    -- This function is called after every action, and handles which set to equip depending on what we're doing
    -- We check if we're meleeing because we don't want to idle in melee gear when we're only engaged for trusts
    if pet.isvalid then 
        luopanMode = 'pan'
    else
        luopanMode = 'me'         
    end
    
    if ( meleeing.value == 'ON' or meleeing.value == 'AUTO' ) and player.status=='Engaged' then
        -- We're both 'engaged' and 'meleeing' is not off
        equip(sets[luopanMode].melee) 
    else
        -- We're not meleeing
        equip(sets[luopanMode].idle[idleModes.value])     
    end
    validateTextInformation()
end
 
function status_change(new,old)
    if new == 'Engaged' then
     
        -- If we engage check our meleeing status
        idle(pet)
         
    elseif new=='Resting' then
     
        -- We're resting
        equip(sets.me.resting)
    else
        idle(pet)
    end
end
 
 
function self_command(command)
    hud_command(command) 
    local commandArgs = command
     
    if #commandArgs:split(' ') >= 2 then
        commandArgs = T(commandArgs:split(' '))
        
        if commandArgs[1] == 'toggle' then
            if commandArgs[2] == 'melee' then
                -- //gs c toggle melee will toggle melee mode on and off.
                -- This basically locks the slots that will cause you to lose TP if changing them,
                -- As well as equip your melee set if you're engaged
                meleeing:cycle()
                lockMainHand(meleeing.value, pet)

            elseif commandArgs[2] == 'mb' then
                -- //gs c toggle mb will toggle mb mode on and off.
                -- You need to toggle prioritisation yourself
                mBurst:toggle()
                updateMB(mBurst.value)
            elseif commandArgs[2] == 'runspeed' then
                runspeed:cycle()
                updateRunspeedGear(runspeed.value, runspeedslot, pet)
            elseif commandArgs[2] == 'idlemode' then
                idleModes:cycle()
                idle(pet)
            elseif commandArgs[2] == 'regenmode' then
                regenModes:cycle()
            elseif commandArgs[2] == 'nukemode' then
                nukeModes:cycle()                               
            elseif commandArgs[2] == 'matchsc' then
                matchsc:cycle()                                
            end
			validateTextInformation()
        end

        if commandArgs[1]:lower() == 'nuke' then
            if not commandArgs[2] then
                windower.add_to_chat(123,'No element type given.')
                return
            end
            
            local nuke = commandArgs[2]:lower()
            if (nuke == 'cycle' or nuke == 'cycledown') then
                if nuke == 'cycle' then
                    elements:cycle()
                    oldElement = elements.current
                elseif nuke == 'cycledown' then 
                    elements:cycleback() 
                    oldElement = elements.current
                end                          
                validateTextInformation()
            elseif (nuke == 'air' or nuke == 'ice' or nuke == 'fire' or nuke == 'water' or nuke == 'lightning' or nuke == 'earth' or nuke == 'light' or nuke == 'dark') then
                local newType = commandArgs[2]
                elements:set(newType)
                validateTextInformation()

            elseif not nukes[nuke] then
                windower.add_to_chat(123,'Unknown element type: '..tostring(commandArgs[2]))
                return    
            else        
                -- Leave out target; let Shortcuts auto-determine it.
                send_command('@input /ma "'..nukes[nuke][elements.current]..'"')     
            end
        end

        if commandArgs[1]:lower() == 'geo' then
            if not commandArgs[2] then
                windower.add_to_chat(123,'No element type given.')
                return
            end
            
            local geo = commandArgs[2]:lower()
            if (geo == 'geocycle' or geo == 'geocycledown') then
                if geo == 'geocycle' then
                    geomancy:cycle()
                elseif geo == 'geocycledown' then 
                    geomancy:cycleback() 
                end                        
                validateTextInformation()

            elseif geo == 'indicycle' or geo == 'indicycledown' then
                if geo == 'indicycle' then
                    indicolure:cycle()
                elseif geo == 'indicycledown' then 
                    indicolure:cycleback() 
                end                          
                validateTextInformation() 

            elseif geo == 'entrustcycle' or geo == 'entrustcledown' then
                if geo == 'entrustcycle' then
                    entrustindi:cycle()
                elseif geo == 'entrustcledown' then 
                    entrustindi:cycleback() 
                end                          
                validateTextInformation() 

            else
                if geo == 'geo' then
                    -- Leave out target; let Shortcuts auto-determine it.
                    send_command('@input /ma "'..geomancy.current..'"')
                elseif geo == 'indi' then
					-- If Entrust is used then it'll use from the entrust list instead.
					if buffactive['Entrust'] then
						-- Leave out target; let Shortcuts auto-determine it.
						send_command('@input /ma "'..entrustindi.current..'"')   
					else
						-- Leave out target; let Shortcuts auto-determine it.
						send_command('@input /ma "'..indicolure.current..'"')    
					end
				end
            end
        end     
    end
end
