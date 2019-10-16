
include('Liz-Mappings.lua')
                
hud_padding = 10

pName = player.name

-- Saying hello
windower.add_to_chat(8,'----- Welcome back to your GEO.lua, '..pName..' -----')

runspeedslot = 'feet'

--------------------------------------------------------------------------------------------------------------
-- HUD STUFF
--------------------------------------------------------------------------------------------------------------

textHideMode = M(false)
textHideOptions = M(false)
textHideJob = M(false)
textHideBattle = M(false)
textHideHUB = M(false)
useLightMode = M(false)
hud_bottom = false
useLightMode = M(false)
meleeing = M('AUTO', 'OFF', 'ON')
lock = M('OFF', 'ON')
mBurst = M(false)
runspeed = M('OFF', 'ON')
keybinds = M(false)
oldElement = elements.current
mBurstOldValue = mBurst.value
matchsc = M('AUTO', 'OFF', 'ON')

hud_x_pos_og = hud_x_pos
hud_y_pos_og = hud_y_pos
hud_font_size_og = hud_font_size
hud_padding_og = hud_padding
hud_transparency_og = hud_transparency

MB_Window = 0
time_start = 0

-- Standard Mode
hub_mode_std = [[ \cs(255, 115, 0)Modes: \cr              
\cs(255, 255, 64)${key_bind_idle} \cs(200, 200, 200)Idle:\cr \cs(125,125,255)${player_current_idle|Refresh}
\cs(255, 255, 64)${key_bind_casting} \cs(200, 200, 200)Casting:\cr \cs(125,125,255)${player_current_casting|Normal}
]]

hub_options_std = [[ \cs(255, 115, 0)Options: \cr             
\cs(255, 255, 64)${key_bind_matchsc}\cs(200, 200, 200)Match SC Element:\cr ${player_match_sc}
\cs(255, 255, 64)${key_bind_lock_weapon} \cs(200, 200, 200)Lock Weapon:\cr ${toggle_lock_weapon}
\cs(255, 255, 64)${key_bind_movespeed_lock}\cs(200, 200, 200)MoveSpeed Lock:\cr ${toggle_movespeed_lock}
]]

hub_job_std = [[ \cs(255, 115, 0)${player_job}: \cr             
\cs(255, 255, 64)${key_bind_element_cycle} \cs(200, 200, 200)Element:\cr ${element_color|\\cs(0, 204, 204)}${toggle_element_cycle|Ice} \cr           
\cs(255, 255, 64)${key_bind_geo_cycle} \cs(200, 200, 200)Geo-Spell:\cr \cs(125,125,255)${toggle_geo_cycle|Unset} \cr    
\cs(255, 255, 64)${key_bind_indi_cycle} \cs(200, 200, 200)Indi-Spell:\cr \cs(125,125,255)${toggle_indi_cycle|Unset} \cr   
\cs(255, 255, 64)${key_bind_entrust_cycle} \cs(200, 200, 200)Entrust-Spell:\cr \cs(125,125,255)${toggle_entrust_cycle|Unset} \cr   
]]

hub_battle_std = [[ \cs(255, 115, 0)Battle: \cr             
        \cs(200, 200, 200)Last SC:\cr ${last_sc_element_color}${last_sc|No SC yet} \cr           
        \cs(200, 200, 200)Burst Window:\cr ${last_sc_element_color}${burst_window|0} \cr
        \cs(200, 200, 200)Magic Burst:\cr ${player_current_mb}  \cr
        \cs(200, 200, 200)Cardinal Chant:\cr ${card_chant_color}${card_chant|No Target} \cr      
]]

-- LITE Mode
hub_mode_lte = [[ \cs(255, 115, 0)     == Modes: \cr     \cs(255, 255, 64)${key_bind_idle} \cs(200, 200, 200)Idle:\cr \cs(125,125,255)${player_current_idle|Refresh}      \cs(255, 255, 64)${key_bind_casting} \cs(200, 200, 200)Casting:\cr \cs(125,125,255)${player_current_casting|Normal} ]]
hub_options_lte = [[ \cs(255, 115, 0)      == Options: \cr   \cs(255, 255, 64)${key_bind_mburst} \cs(200, 200, 200)Magic Burst:\cr ${player_current_mb}   \cs(255, 255, 64)${key_bind_matchsc}\cs(200, 200, 200)Match SC Element:\cr ${player_match_sc}    \cs(255, 255, 64)${key_bind_lock_weapon} \cs(200, 200, 200)Lock Weapon:\cr ${toggle_lock_weapon}     \cs(255, 255, 64)${key_bind_movespeed_lock}\cs(200, 200, 200)MoveSpeed Lock:\cr ${toggle_movespeed_lock} ]]
hub_job_lte = [[ \cs(255, 115, 0)      == ${player_job}: \cr     \cs(255, 255, 64)${key_bind_element_cycle} \cs(200, 200, 200)Element:\cr ${element_color|\\cs(0, 204, 204)}${toggle_element_cycle|Ice} \cr   \cs(255, 255, 64)${key_bind_geo_cycle} \cs(200, 200, 200)Geo-Spell:\cr \cs(125,125,255)${toggle_geo_cycle|Ice} \cr   \cs(255, 255, 64)${key_bind_indi_cycle} \cs(200, 200, 200)Indi-Spell:\cr \cs(125,125,255)${toggle_indi_cycle|Ice}   \cs(255, 255, 64)${key_bind_entrust_cycle} \cs(200, 200, 200)Indi-Spell:\cr \cs(125,125,255)${toggle_entrust_cycle|Ice} \cr ]]
hub_battle_lte = [[ \cs(255, 115, 0)       == Battle: \cr     \cs(200, 200, 200)Last SC:\cr ${last_sc_element_color}${last_sc|No SC yet} \cr  \cs(200, 200, 200)Burst Window:\cr ${last_sc_element_color}${burst_window|0} \cr      \cs(200, 200, 200)Cardinal Chant:\cr ${card_chant_color}${card_chant|No Target} \cr ]]

-- init style
hub_mode = hub_mode_std
hub_options = hub_options_std
hub_job = hub_job_std
hub_battle = hub_battle_std
--[[
    This gets passed in when the Keybinds are turned off.
    For not it simply sets the variable to an empty string
    (Researching better way to handle this)
]]
keybinds_off = {}
keybinds_off['key_bind_idle'] = '       '
keybinds_off['key_bind_casting'] = '       '
keybinds_off['key_bind_mburst'] = '       '

keybinds_off['key_bind_element_cycle'] = '       '
keybinds_off['key_bind_geo_cycle'] = '       '
keybinds_off['key_bind_indi_cycle'] = '       '
keybinds_off['key_bind_entrust_cycle'] = '       '
keybinds_off['key_bind_sc_level'] = '       '
keybinds_off['key_bind_lock_weapon'] = '       '
keybinds_off['key_bind_movespeed_lock'] = '        '
keybinds_off['key_bind_matchsc'] = '        '

function validateTextInformation()

    --Mode Information
    if mode = 'pan' then
        main_text_hub.player_current_idle = tostring(idleModes.current..' + \\cs(32, 255, 32)luopan\\cr')
    else
        main_text_hub.player_current_idle = idleModes.current
    end
    main_text_hub.player_current_casting = nukeModes.current
    main_text_hub.toggle_element_cycle = elements.current
    main_text_hub.toggle_geo_cycle = geomancy.current
    main_text_hub.toggle_indi_cycle = indicolure.current
    main_text_hub.toggle_entrust_cycle = entrustindi.current
    main_text_hub.toggle_sc_level = wantedSc
    main_text_hub.player_job = player.job
    main_text_hub.card_chant = cChant
    main_text_hub.card_chant_color = ccColor
    
    if last_skillchain ~= nil then
        main_text_hub.last_sc = last_skillchain.english
        main_text_hub.burst_window = tostring(MB_Window)
        main_text_hub.last_sc_element_color = Colors[last_skillchain.elements[1]]
    end
    
    if mBurst.value then
        main_text_hub.player_current_mb = const_on
    else
        main_text_hub.player_current_mb = const_off
    end
    if matchsc.value == 'OFF' then
        main_text_hub.player_match_sc = const_off
    elseif matchsc.value == 'ON' then
        main_text_hub.player_match_sc = const_on
	else
        if mBurst.value then
            main_text_hub.player_match_sc = const_autoOn
        else
            main_text_hub.player_match_sc = const_autoOff
        end
    end
    if meleeing.value == 'OFF' then
        main_text_hub.toggle_lock_weapon = const_off
    elseif meleeing.value == 'ON' then
        main_text_hub.toggle_lock_weapon = const_on
    else
        if player.tp >= lockWeaponTP then
            main_text_hub.toggle_lock_weapon = const_autoOn
        else
            main_text_hub.toggle_lock_weapon = const_autoOff
        end
    end

    if runspeed.value == 'ON' then
		if autorunspeed then
			main_text_hub.toggle_movespeed_lock =  const_autoOn
		else
			main_text_hub.toggle_movespeed_lock =  const_on
		end
    elseif runspeed.value == 'OFF' then
		if autorunspeed then
			main_text_hub.toggle_movespeed_lock =  const_autoOff
		else
			main_text_hub.toggle_movespeed_lock =  const_off
		end
    end
    
    if keybinds.value then
        texts.update(main_text_hub, keybinds_on)
    else 
        texts.update(main_text_hub, keybinds_off)
    end
    main_text_hub.element_color = Colors[elements.current]
end

--Default To Set Up the Text Window
function setupTextWindow()

    local default_settings = {}
    default_settings.pos = {}
    default_settings.pos.x = hud_x_pos
    default_settings.pos.y = hud_y_pos
    default_settings.bg = {}

    default_settings.bg.alpha = hud_transparency
    default_settings.bg.red = 40
    default_settings.bg.green = 40
    default_settings.bg.blue = 55
    default_settings.bg.visible = true
    default_settings.flags = {}
    default_settings.flags.right = false
    default_settings.flags.bottom = false
    default_settings.flags.bold = true
    default_settings.flags.draggable = hud_draggable
    default_settings.flags.italic = false
    default_settings.padding = hud_padding
    default_settings.text = {}
    default_settings.text.size = hud_font_size
    default_settings.text.font = hud_font
    default_settings.text.fonts = {}
    default_settings.text.alpha = 255
    default_settings.text.red = 147
    default_settings.text.green = 161
    default_settings.text.blue = 161
    default_settings.text.stroke = {}
    default_settings.text.stroke.width = 1
    default_settings.text.stroke.alpha = 255
    default_settings.text.stroke.red = 0
    default_settings.text.stroke.green = 0
    default_settings.text.stroke.blue = 0

    --Creates the initial Text Object will use to create the different sections in
    if not (main_text_hub == nil) then
        texts.destroy(main_text_hub)
    end
    main_text_hub = texts.new('', default_settings, default_settings)

    --Appends the different sections to the main_text_hub
    texts.append(main_text_hub, hub_mode)
    texts.append(main_text_hub, hub_options)
    texts.append(main_text_hub, hub_job)
    texts.append(main_text_hub, hub_battle)
    --We then do a quick validation
    validateTextInformation()

    --Finally we show this to the user
    main_text_hub:show()
    
end
--[[
    This handles hiding the different sections
]]
function hideTextSections()

    --For now when hiding a section its easier to recreate the entire window
    texts.clear(main_text_hub)
    
    --Below we check to make sure this is true by default these are false
    if not textHideMode.value then
        texts.append(main_text_hub, hub_mode)

    end
    if not textHideOptions.value then
        texts.append(main_text_hub, hub_options)
    end
    if not textHideJob.value then
        texts.append(main_text_hub, hub_job)
    end
    if not textHideBattle.value then
        texts.append(main_text_hub, hub_battle)
    end
    validateTextInformation()

end

function toggleHudStyle( useLightMode )
    texts.clear(main_text_hub)
    if useLightMode then
        hud_x_pos = 0
        hud_y_pos = 0
        hud_font_size = 8
        hud_padding = 2
        hud_transparency = 0
        hud_strokewidth = 2
        hub_options = hub_options_lte
        hub_mode = hub_mode_lte
        hub_job = hub_job_lte
        hub_battle = hub_battle_lte
    else
        hud_x_pos = hud_x_pos_og
        hud_y_pos = hud_y_pos_og
        hud_font_size = hud_font_size_og
        hud_padding = hud_padding_og
        hud_transparency = hud_transparency_og
        hud_strokewidth = 1
        hub_options = hub_options_std
        hub_mode = hub_mode_std
        hub_battle = hub_battle_std
        hub_job = hub_job_std
    end
    texts.pos(main_text_hub, hud_x_pos, hud_y_pos)
    texts.size(main_text_hub, hud_font_size)
    texts.pad(main_text_hub, hud_padding)
    texts.bg_alpha(main_text_hub, hud_transparency)
    texts.stroke_width(main_text_hub, hud_strokewidth)      
    hideTextSections()
end

function hud_command(command)
 
    local commandArgs = command
    
    if #commandArgs:split(' ') >= 2 then
        commandArgs = T(commandArgs:split(' '))
        
        if commandArgs[1]:lower() == "hud" then --First variable is hide lets find out what

            if commandArgs[2]:lower() == "hide" then -- Hides/Shows the HUB
                textHideHUB:toggle()

                if textHideHUB.value == true then
                    texts.hide(main_text_hub)
                else 
                    texts.show(main_text_hub)
                end

                hideTextSections()
            elseif commandArgs[2]:lower() == "keybinds" then --Hides/Show Keybinds
                keybinds:toggle()

                if keybinds.value then
                    texts.update(main_text_hub, keybinds_on) --If ON then we pass in Table for keybinds to update the variables
                else 
                    texts.update(main_text_hub, keybinds_off) --Otherwise we set them to blank
                end

                hideTextSections()
            elseif commandArgs[2]:lower() == "hidemodes" then --Hides the Mode
                textHideMode:toggle()
                hideTextSections()
            elseif commandArgs[2]:lower() == "hideoptions" then --Hides/Show Scholar sectio
                textHideOptions:toggle()
                hideTextSections()
            elseif commandArgs[2]:lower() == "hidejob" then --Hides/Show Battle section
                textHideJob:toggle()
                hideTextSections()
            elseif commandArgs[2]:lower() == "hidebattle" then --Hides/Show Battle section
                textHideBattle:toggle()
                hideTextSections()
            elseif commandArgs[2]:lower() == "lite" then --Hides/Show Options
                useLightMode:toggle()
                toggleHudStyle(useLightMode.value)
            
            end
        end
    end
end

--------------------------------------------------------------------------------------------------------------
include('Liz-HelperFunctions.lua')
--------------------------------------------------------------------------------------------------------------

mode = 'me'         -- me or pan (me = no luopan, pan = luopan is out)

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
        mode = 'pan'
    else
        mode = 'me'         
    end
    
    if ( meleeing.value == 'ON' or meleeing.value == 'AUTO' ) and player.status=='Engaged' then
        -- We're both 'engaged' and 'meleeing' is not off
        equip(sets[mode].melee) 
    else
        -- We're not meleeing
        equip(sets[mode].idle[idleModes.value])     
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
                if use_UI == true then                    
                    validateTextInformation()
                else
                    windower.add_to_chat(211,'Nuke now set to element type: '..tostring(elements.current))
                end   

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