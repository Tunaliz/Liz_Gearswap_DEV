version = "3.0"
--[[
        Custom commands:
        Shorthand versions for each strategem type that uses the version appropriate for
        the current Arts.
                                        Light Arts              Dark Arts
        gs c scholar light              Light Arts/Addendum
        gs c scholar dark                                       Dark Arts/Addendum
        gs c scholar cost               Penury                  Parsimony
        gs c scholar speed              Celerity                Alacrity
        gs c scholar aoe                Accession               Manifestation
        gs c scholar power              Rapture                 Ebullience
        gs c scholar duration           Perpetuance
        gs c scholar accuracy           Altruism                Focalization
        gs c scholar enmity             Tranquility             Equanimity
        gs c scholar skillchain                                 Immanence
        gs c scholar addendum           Addendum: White         Addendum: Black
    
        Toggle Function: 
        gs c toggle melee               Toggle Melee mode on / off and locking of weapons
        gs c toggle mb                  Toggles Magic Burst Mode on / off.
        gs c toggle runspeed            Toggles locking on / off Herald's Gaiters
        gs c toggle idlemode            Toggles between Refresh and DT idle mode. Activating Sublimation JA will auto replace refresh set for sublimation set. DT set will superceed both.        
        gs c toggle regenmode           Toggles between Hybrid, Duration and Potency mode for regen set  
        gs c toggle nukemode            Toggles between Normal and Accuracy mode for midcast Nuking sets (MB included)  
        gs c toggle matchsc             Toggles auto swapping element to match the last SC that just happenned.
                
        Casting functions:
        these are to set fewer macros (1 cycle, 5 cast) to save macro space when playing lazily with controler
        
        gs c nuke cycle                 Cycles element type for nuking & SC
        gs c nuke cycledown             Cycles element type for nuking & SC in reverse order    
        gs c nuke t1                    Cast tier 1 nuke of saved element 
        gs c nuke t2                    Cast tier 2 nuke of saved element 
        gs c nuke t3                    Cast tier 3 nuke of saved element 
        gs c nuke t4                    Cast tier 4 nuke of saved element 
        gs c nuke t5                    Cast tier 5 nuke of saved element 
        gs c nuke helix                 Cast helix2 nuke of saved element 
        gs c nuke storm                 Cast Storm II buff of saved element  
                    
        gs c sc tier                    Cycles SC Tier (1 & 2)
        gs c sc castsc                  Cast All the stuff to create a SC burstable by the nuke element set with '/console gs c nuke element'.

        HUD Functions:
        gs c hud hide                   Toggles the Hud entirely on or off
        gs c hud hidemode               Toggles the Modes section of the HUD on or off
        gs c hud hidejob                Toggles the job section of the HUD on or off
        gs c hud hidebattle             Toggles the Battle section of the HUD on or off
        gs c hud lite                   Toggles the HUD in lightweight style for less screen estate usage. Also on ALT-END
        gs c hud keybinds               Toggles Display of the HUD keybindings (my defaults) You can change just under the binds in the Gearsets file.
        gs c hud setcolor sections      Cycles colors for sections
        gs c hud setcolor options       Cycles colors for options
        gs c hud setcolor keybinds      Cycles colors for keybinds
        gs c hud setcolor selection     Cycles colors for selection

        Alternatively you can also add the color after those command like: //gs c hud setcolor options blue
        
        // OPTIONAL IF YOU WANT / NEED to skip the cycles...  
        gs c nuke Ice                   Set Element Type to Ice DO NOTE the Element needs a Capital letter. 
        gs c nuke Air                   Set Element Type to Air DO NOTE the Element needs a Capital letter. 
        gs c nuke Dark                  Set Element Type to Dark DO NOTE the Element needs a Capital letter. 
        gs c nuke Light                 Set Element Type to Light DO NOTE the Element needs a Capital letter. 
        gs c nuke Earth                 Set Element Type to Earth DO NOTE the Element needs a Capital letter. 
        gs c nuke Lightning             Set Element Type to Lightning DO NOTE the Element needs a Capital letter. 
        gs c nuke Water                 Set Element Type to Water DO NOTE the Element needs a Capital letter. 
        gs c nuke Fire                  Set Element Type to Fire DO NOTE the Element needs a Capital letter. 
--]]

--------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------
--              ______                   _                  
--             / _____)        _     _  (_)                 
--            ( (____  _____ _| |_ _| |_ _ ____   ____  ___ 
--             \____ \| ___ (_   _|_   _) |  _ \ / _  |/___)
--             _____) ) ____| | |_  | |_| | | | ( (_| |___ |
--            (______/|_____)  \__)  \__)_|_| |_|\___ (___/ 
--                                              (_____|    
--------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------
-- Set this to true and as soon as you move you swap into movespeed set, and revert when stationary
-- Set it to false and the movespeed toggle is manual. 
autorunspeed = true
auto_CP_Cape = false
--------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------
-- HUD Initial setup and Positioning
--------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------
hud_x_pos = 1400    --important to update these if you have a smaller screen
hud_y_pos = 200     --important to update these if you have a smaller screen
hud_draggable = true
hud_font_size = 10
hud_transparency = 225 -- a value of 0 (invisible) to 255 (no transparency at all)
hud_font = 'Impact'
hud_padding = 10
--------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------
include('Liz-Includes.lua')
--------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------
-- Customize HUD looks and content
-- Colors: ('red', 'blue', 'green', 'white', 'yellow', 'cyan', 'magenta', 'black', 'orange')

sectionsColors:set('orange')
keybindsColors:set('yellow')
optionsColors:set('white')
selectionColors:set('blue')   

textHideMode:set(false)
textHideOptions:set(false)
textHideJob:set(false)
textHideBattle:set(false)
textHideHUD:set(false)
useLightMode:set(false)
keybinds:set(false)

-- Optional. Swap to your sch macro sheet / book
set_macros(1,17) -- Sheet, Book   
--------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------
-- Define your modes: 
-- You can add or remove modes in the table below, they will get picked up in the cycle automatically. 
-- to define sets for idle if you add more modes, name them: sets.me.idle.mymode and add 'mymode' in the group.
-- to define sets for regen if you add more modes, name them: sets.midcast.regen.mymode and add 'mymode' in the group.
-- Same idea for nuke modes. 
idleModes = M('refresh', 'dt', 'mdt')
regenModes = M('hybrid', 'duration', 'potency')
-- To add a new mode to nuking, you need to define both sets: sets.midcast.nuking.mynewmode as well as sets.midcast.MB.mynewmode
nukeModes = M('normal', 'acc')

-- Setup your Key Bindings here:
    windower.send_command('bind insert gs c nuke cycle')            -- Insert Cycles Nuke element
    windower.send_command('bind !insert gs c nuke cycledown')       -- ALT+Insert Cycles Nuke element in reverse order 
    windower.send_command('bind f9 gs c toggle idlemode')       -- F9 to change Idle Mode    
    windower.send_command('bind !f9 gs c toggle runspeed') 		-- Alt-F9 toggles locking on / off Herald's Gaiters
    windower.send_command('bind f12 gs c toggle melee')			-- F12 Toggle Melee mode on / off and locking of weapons
    windower.send_command('bind !` input /ma Stun <t>') 		-- Alt-` Quick Stun Shortcut.
    windower.send_command('bind home gs c sc tier')				-- home to change SC tier between Level 1 or Level 2 SC
    windower.send_command('bind end gs c toggle regenmode')		-- end to change Regen Mode	
    windower.send_command('bind !f10 gs c toggle nukemode')     -- Alt-F10 to change Nuking Mode
    windower.send_command('bind F10 gs c toggle matchsc')       -- F10 to change Match SC Mode          	
    windower.send_command('bind !end gs c hud lite')            -- Alt-End to toggle light hud version       
    windower.send_command('bind ^end gs c hud keybinds')        -- CTRL-End to toggle Keybinds  

--[[
    This gets passed in when the Keybinds is turned on.
    Each one matches to a given variable within the text object
    IF you changed the Default Keybind above, Edit the ones below so it can be reflected in the hud using "//gs c hud keybinds" command
]]
keybinds_on = {}
keybinds_on['key_bind_idle'] = '(F9)'
keybinds_on['key_bind_regen'] = '(END)'
keybinds_on['key_bind_casting'] = '(ALT-F10)'
keybinds_on['key_bind_element_cycle'] = '(INSERT)'
keybinds_on['key_bind_sc_level'] = '(HOME)'
keybinds_on['key_bind_lock_weapon'] = '(F12)'
keybinds_on['key_bind_movespeed_lock'] = '(ALT-F9)'
keybinds_on['key_bind_matchsc'] = '(F10)'

-- Remember to unbind your keybinds on job change.
function user_unload()
    send_command('unbind insert')
    send_command('unbind delete')	
    send_command('unbind f9')
    send_command('unbind f10')
    send_command('unbind f12')
    send_command('unbind !`')
    send_command('unbind home')
    send_command('unbind end')
    send_command('unbind !f10')	
    send_command('unbind `f10')
    send_command('unbind !f9')	
    send_command('unbind !end')      	
end
--------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------
include('SCH_Lib.lua')          -- leave this as is    
refreshType = idleModes[1]      -- leave this as is     
--------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------
                --  _____                  __      __        _       _     _
                -- / ____|                 \ \    / /       (_)     | |   | |
                --| |  __  ___  __ _ _ __   \ \  / /_ _ _ __ _  __ _| |__ | | ___  ___
                --| | |_ |/ _ \/ _` | '__|   \ \/ / _` | '__| |/ _` | '_ \| |/ _ \/ __|
                --| |__| |  __/ (_| | |       \  / (_| | |  | | (_| | |_) | |  __/\__ \
                -- \_____|\___|\__,_|_|        \/ \__,_|_|  |_|\__,_|_.__/|_|\___||___/
--------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------    

-- Setup your Gear Sets below:
function get_sets()
 
    ----------------------------------------------------------
    -- Auto CP Cape: Will put on CP cape automatically when
    -- fighting Apex mobs and job is not mastered
    ----------------------------------------------------------
    CP_CAPE = "Mecisto. Mantle" -- Put your CP cape here
    ----------------------------------------------------------

    -- My formatting is very easy to follow. All sets that pertain to my character doing things are under 'me'.
    -- All sets that are equipped to faciliate my avatar's behaviour or abilities are under 'avatar', eg, Perpetuation, Blood Pacts, etc
      
    sets.me = {}        		-- leave this empty
    sets.buff = {} 				-- leave this empty
    sets.me.idle = {}			-- leave this empty
    -- Optional 
	include('AugGear.lua') -- I list all my Augmented gears in a sidecar file since it's shared across many jobs. 

    -- Define JSE Capes
    SCHCape = {}
    SCHCape.FC = { name="Lugh's Cape", augments={'MND+10','Mag. Acc+20 /Mag. Dmg.+20','"Fast Cast"+10','Mag. Evasion+12',}}
    SCHCape.NUKE = { name="Lugh's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','"Mag.Atk.Bns."+10',}}
   
    -- Movespeedset
    sets.me.movespeed = { 
        feet="Herald's Gaiters",
    }

    -- Your idle set
    sets.me.idle.refresh = {
		main={ name="Akademos", augments={'INT+15','"Mag.Atk.Bns."+15','Mag. Acc.+15',}},
		--main="Musa",    		
		sub="Eletta Grip",
		ammo="Homiliary",
		head="Peda. M.Board +3",
        body=Amal.Body.A, 
		hands="Acad. Bracers +3",
		legs="Assid. Pants +1",
        feet="Peda. Loafers +3",
		neck="Twilight Torque",
		waist="Refoccilation Stone",
        left_ear="Etiolation Earring",
        right_ear="Odnowa Earring +1",
		left_ring="Stikini Ring +1",
		right_ring="Defending Ring",
		back="Moonbeam Cape",
    }

    -- Your idle Sublimation set combine from refresh or DT depening on mode.
    sets.me.idle.sublimation = set_combine(sets.me.idle.refresh,{
    	head="Acad. Mortar. +1",
		body="Peda. Gown +3",
        feet="Peda. Loafers +3",
		back="Moonbeam Cape",
    })   
    -- Your idle DT set
    sets.me.idle.dt = set_combine(sets.me.idle[refreshType],{
        main="Malignance Pole", --20
        sub="Eletta Grip",	--4
        body="Mallquis Saio +2",
        feet="Mallquis Clogs +1",
		neck="Twilight Torque",	--5 
		right_ring="Defending Ring", --10
        left_ear="Etiolation Earring",
        right_ear="Odnowa Earring +1",
		back="Moonbeam Cape", --5
    })  
    sets.me.idle.mdt = set_combine(sets.me.idle[refreshType],{
        main="Malignance Pole", --20
        sub="Eletta Grip",  --4
        body="Mallquis Saio +2",
        feet="Mallquis Clogs +1",
        neck="Twilight Torque", --5 
        right_ring="Defending Ring", --10
        left_ear="Etiolation Earring",
        right_ear="Odnowa Earring +1",
        back="Moonbeam Cape", --5
    })  
	-- Your MP Recovered Whilst Resting Set
    sets.me.resting = { 
		ammo="Homiliary",
		head=Amal.Head.A,
		body=Amal.Body.A,
		hands=Amal.Hands.D,
		legs="Assid. Pants +1",
		feet=Amal.Feet.A,
		neck="Twilight Torque",
		waist="Refoccilation Stone",
		left_ear="Etiolation Earring",
		right_ear="Malignance Earring",
		left_ring="Stikini Ring +1",
		right_ring="Defending Ring",
		back=SCHCape.NUKE,
    }
    
    sets.me.latent_refresh = {waist="Fucho-no-obi"}     
    
	-- Combat Related Sets
    sets.me.melee = set_combine(sets.me.idle[idleModes.current],{

    })
      
    -- Weapon Skills sets just add them by name.
    sets.me["Shell Crusher"] = {
		ammo="Ghastly Tathlum +1",
		head="Jhakri Coronal +1",
		body="Jhakri Robe +2",
		hands="Jhakri Cuffs +1",
		legs="Jhakri Slops +1",
		feet="Jhakri Pigaches +1",
		neck="Sanctity Necklace",
		waist="Grunfeld Rope",
		left_ear="Mache Earring +1",
		right_ear="Telos Earring",
		left_ring="Stikini Ring +1",
		right_ring="Begrudging Ring",
		back="Altruistic Cape",	
	}
    sets.me["Shattersoul"] = {
		ammo="Ghastly Tathlum +1",
		head=Amal.Head.A,
		body=Amal.Body.A,
		hands=Amal.Hands.D,
		legs=Amal.Legs.A,
		feet=Amal.Feet.A,
		neck="Mizu. Kubikazari",
		waist="Mujin Obi",
		left_ear="Barkaro. Earring",
		right_ear="Malignance Earring",
		left_ring="Stikini Ring +1",
		right_ring="Prolix Ring",
		back="Altruistic Cape",
    }
    sets.me["Myrkr"] = {
		ammo="Ghastly Tathlum +1",
		head=Amal.Head.A,
		body=Amal.Body.A,
		hands=Amal.Hands.D,
		legs=Amal.Legs.A,
		feet=Amal.Feet.A,
		neck="Mizu. Kubikazari",
		waist="Mujin Obi",
		left_ear="Barkaro. Earring",
		right_ear="Malignance Earring",
		left_ring="Stikini Ring +1",
		right_ring="Prolix Ring",
		back="Altruistic Cape",
    }
      
    -- Feel free to add new weapon skills, make sure you spell it the same as in game. These are the only two I ever use though
  
    ------------
    -- Buff Sets
    ------------	
    -- Gear that needs to be worn to **actively** enhance a current player buff.
    -- Fill up following with your avaible pieces.
    sets.buff['Rapture'] = {head="Arbatel bonnet +1"}
    sets.buff['Perpetuance'] = {hands="Arbatel Bracers +1"}
    sets.buff['Immanence'] = {hands="Arbatel Bracers +1"}
    sets.buff['Penury'] = {legs="Arbatel Pants +1"}
    sets.buff['Parsimony'] = {legs="Arbatel Pants +1"}
    sets.buff['Celerity'] = {feet="Peda. Loafers +3"}
    sets.buff['Alacrity'] = {feet="Peda. Loafers +3"}
    sets.buff['Klimaform'] = {feet="Arbatel Loafers +1"}	
    -- Ebulience set empy now as we get better damage out of a good Merlinic head
    sets.buff['Ebullience'] = {} -- I left it there still if it becomes needed so the SCH.lua file won't need modification should you want to use this set
   
	
	
    ---------------
    -- Casting Sets
    ---------------
    sets.precast = {}   		-- Leave this empty  
    sets.midcast = {}    		-- Leave this empty  
    sets.aftercast = {}  		-- Leave this empty  
	sets.midcast.nuking = {}	-- leave this empty
	sets.midcast.MB	= {}		-- leave this empty      
    ----------
    -- Precast
    ----------
      
    -- Generic Casting Set that all others take off of. Here you should add all your fast cast 
    -- Grimoire: 10(cap:25) / rdm: 15
    sets.precast.casting = {
		main="Musa",    
    	ammo="Incantor Stone",		--2
		head=Amal.Head.A, 	--11
		body=Merl.Body.FC, 			--12
		hands="Acad. Bracers +3", 	--7
		legs="Psycloth Lappas", --7
		feet="Peda. Loafers +3", 	--8
		neck="Twilight Torque", 	
		waist="Witful Belt",		--3
	    left_ring="Kishar Ring",	--4
	    right_ring="Weather. Ring",	--5
		left_ear="Loquac. Earring", --2
		right_ear="Malignance Earring",--4
		back=SCHCape.FC,			--10
    }

	sets.precast["Stun"] = {
		main="Musa",
		ammo="Incantor Stone",
		head=Merl.Head.ACC,
		body=Amal.Body.A,
		hands="Acad. Bracers +3",
		legs="Psycloth Lappas", --7
		feet="Acad. loafers +3",
		neck="Erra Pendant",
		waist="Porous Rope",
		left_ear="Barkaro. Earring",
		right_ear="Malignance Earring",
		left_ring="Stikini Ring +1",
		right_ring="Weather. Ring",
		back=SCHCape.FC,	
	}

    -- When spell school is aligned with grimoire, swap relevent pieces -- Can also use Arbatel +1 set here if you value 1% quickcast procs per piece. (2+ pieces)  
    -- Dont set_combine here, as this is the last step of the precast, it will have sorted all the needed pieces already based on type of spell.
    -- Then only swap in what under this set after everything else. 
    sets.precast.grimoire = {
		feet="Acad. loafers +3",
    }

	
    -- Enhancing Magic, eg. Siegal Sash, etc
    sets.precast.enhancing = set_combine(sets.precast.casting,{
		waist="Siegel Sash",
        neck="Melic Torque",
    })
  
    -- Stoneskin casting time -, works off of enhancing -
    sets.precast.stoneskin = set_combine(sets.precast.enhancing,{
		waist="Siegel Sash",
    })
      
    -- Curing Precast, Cure Spell Casting time -
    sets.precast.cure = set_combine(sets.precast.casting,{
		back="Pahtli Cape",
		left_ring="Lebeche Ring",		
    })
      
    ---------------------
    -- Ability Precasting
    ---------------------

    sets.precast["Tabula Rasa"] = {legs="Pedagogy Pants +1"}
    sets.precast["Enlightenment"] = {body="Peda. Gown +3"}	 
    sets.precast["Sublimation"] = {head="Acad. Mortar. +1", body="Peda. Gown +3"}	 

	
	----------
    -- Midcast
    ----------
	
    -- Just go make it, inventory will thank you and making rules for each is meh.
    sets.midcast.Obi = {
    	waist="Hachirin-no-Obi",
    }
	
	-----------------------------------------------------------------------------------------------
	-- Helix sets automatically derives from casting sets. SO DONT PUT ANYTHING IN THEM other than:
	-- Pixie in DarkHelix
	-- Boots that aren't arbatel +1 (15% of small numbers meh, amalric+1 does more)
	-- Belt that isn't Obi.
	-----------------------------------------------------------------------------------------------
    -- Make sure you have a non weather obi in this set. Helix get bonus naturally no need Obi.	
    sets.midcast.DarkHelix = {
		head="Pixie Hairpin +1",
    	-- Amalric Nails +1 are beating Arbatel Loafers +1 for Helix atm, YMMV
		feet=Amal.Feet.A,
		waist="Refoccilation Stone",
        left_ring="Archon Ring",
    }
    -- Make sure you have a non weather obi in this set. Helix get bonus naturally no need Obi.	
    sets.midcast.Helix = {
		-- Amalric Nails +1 are beating Arbatel Loafers +1 for Helix atm, YMMV
		feet=Amal.Feet.A,
		waist="Refoccilation Stone",
    }	

    -- Whatever you want to equip mid-cast as a catch all for all spells, and we'll overwrite later for individual spells
    sets.midcast.casting = {
		main={ name="Akademos", augments={'INT+15','"Mag.Atk.Bns."+15','Mag. Acc.+15',}},   		
		sub="Enki Strap",    
		ammo="Pemphredo Tathlum",
		head= Merl.Head.ACC,
		body=Amal.Body.A,
		hands=Amal.Hands.D,
		legs=Chiro.Legs.ACC,
		feet=Amal.Feet.A,
		neck="Mizu. Kubikazari",
		waist="Refoccilation Stone",
		left_ear="Barkaro. Earring",
		right_ear="Malignance Earring",
		left_ring="Shiva Ring",
		right_ring="Shiva Ring",
		back=SCHCape.NUKE,	
    }

	sets.midcast["Sublimation"] = {head="Acad. Mortar. +1", body="Peda. Gown +3"}
    
    sets.midcast.nuking.normal = {
		main={ name="Akademos", augments={'INT+15','"Mag.Atk.Bns."+15','Mag. Acc.+15',}},   		
		sub="Enki Strap",  
		ammo="Pemphredo Tathlum",
		head= Merl.Head.ACC,
		body=Amal.Body.A,
		hands=Amal.Hands.D,
		legs=Amal.Legs.A,
		feet=Amal.Feet.A,
		neck="Sanctity Necklace",
		waist="Refoccilation Stone",
		left_ear="Barkaro. Earring",
		right_ear="Malignance Earring",
		left_ring="Shiva Ring",
		right_ring="Shiva Ring",
		back=SCHCape.NUKE,
    }
    -- used with toggle, default: F10
    -- Pieces to swap from freen nuke to Magic Burst
    sets.midcast.MB.normal = set_combine(sets.midcast.nuking.normal, {
		head= Merl.Head.MB,
		neck="Mizu. Kubikazari",		
		left_ring="Locus Ring",
		right_ring="Mujin Band",
    })
	
    sets.midcast.nuking.acc = {
		main={ name="Akademos", augments={'INT+15','"Mag.Atk.Bns."+15','Mag. Acc.+15',}},   		
		sub="Enki Strap",  
		ammo="Pemphredo Tathlum",
		head= Merl.Head.ACC,
		body=Amal.Body.A,
		hands=Amal.Hands.D,
		legs=Chiro.Legs.ACC,
		feet=Amal.Feet.A,
		neck="Sanctity Necklace",
		waist="Refoccilation Stone",
		left_ear="Barkaro. Earring",
		right_ear="Malignance Earring",
		left_ring="Shiva Ring",
		right_ring="Freke Ring",
		back=SCHCape.NUKE,
    }
    -- used with toggle, default: F10
    -- Pieces to swap from freen nuke to Magic Burst
    sets.midcast.MB.acc = set_combine(sets.midcast.nuking.normal, {
	    head="Peda. M.Board +3",
	    legs=Merl.Legs.MB,
	    neck="Mizu. Kubikazari",
	    waist="Refoccilation Stone",
	    left_ear="Barkaro. Earring",
	    right_ear="Malignance Earring",
	    left_ring="Locus Ring",
	    right_ring="Mujin Band",
    })	
	
    -- Enfeebling
	sets.midcast["Stun"] = {
		main="Musa",
        sub="Enki Strap",  
		ammo="Ghastly Tathlum +1",
		head=Merl.Head.ACC,
		body=Amal.Body.A,
		hands="Acad. Bracers +3",
		legs=Chiro.Legs.ACC,
		feet="Acad. loafers +3",
		neck="Erra Pendant",
		waist="Porous Rope",
		left_ear="Barkaro. Earring",
		right_ear="Malignance Earring",
		left_ring="Stikini Ring +1",
		right_ring="Weather. Ring",
		back=SCHCape.FC,	
	}	
    sets.midcast.IntEnfeebling = {
		main="Musa",    
        sub="Enki Strap",  
		ammo="Ghastly Tathlum +1",
		head=Merl.Head.ACC,
        body=Amal.Body.A,
        hands=Kayk.Hands.A,
		legs=Chiro.Legs.ACC,
		feet="Acad. loafers +3",
		neck="Imbodla Necklace",
		waist="Porous Rope",
		left_ear="Barkaro. Earring",
		right_ear="Malignance Earring",
		left_ring="Stikini Ring +1",
		right_ring="Stikini Ring",
		back=SCHCape.NUKE,
    }
    sets.midcast.MndEnfeebling = {
		main="Musa",
        sub="Enki Strap",  
		ammo="Ghastly Tathlum +1",
		head=Merl.Head.ACC,
		body=Amal.Body.A,
        hands=Kayk.Hands.A,
		legs=Chiro.Legs.ACC,
		feet="Acad. loafers +3",
		neck="Imbodla Necklace",
		waist="Porous Rope",
		left_ear="Barkaro. Earring",
		right_ear="Malignance Earring",
		left_ring="Stikini Ring +1",
		right_ring="Stikini Ring",
		back=SCHCape.FC,	
    }
	
    -- Enhancing
    sets.midcast.enhancing = set_combine(sets.midcast.casting,{
		main="Musa",  
        sub="Enki Strap",  
	    ammo="Ghastly Tathlum +1",
		head="Telchine Cap",
		body="Peda. Gown +3",
		hands="Telchine Gloves", 
		legs="Telchine Braconi",
		feet="Telchine Pigaches", 
		neck="Melic Torque",
		waist="Porous Rope",
		left_ear="Malignance Earring",
		right_ear="Loquac. Earring",
		left_ring="Stikini Ring +1",
		right_ring="Stikini Ring",
		back="Perimede Cape",
    })
    sets.midcast.storm = set_combine(sets.midcast.enhancing,{
		feet="Peda. Loafers +3",
		right_ring="Kishar Ring",
    })       
    -- Stoneskin
    sets.midcast.stoneskin = set_combine(sets.midcast.enhancing,{
		waist="Siegel Sash",
    })
    sets.midcast.refresh = set_combine(sets.midcast.enhancing,{
		head=Amal.Head.A,
    })
    sets.midcast.aquaveil = sets.midcast.refresh
	
    sets.midcast["Drain"] = set_combine(sets.midcast.nuking, {
        main="Rubicundity",
        sub="Ammurapi Shield",
		head="Pixie Hairpin +1",
		neck="Erra Pendant",
        left_ring="Archon Ring",
    })
    sets.midcast["Aspir"] = sets.midcast["Drain"]
 	
 	sets.midcast.cure = {} -- Leave This Empty
    -- Cure Potency
    sets.midcast.cure.normal = set_combine(sets.midcast.casting,{
		main="Musa",
        sub="Enki Strap",  
		ammo="Ghastly Tathlum +1",
        head="Vanya Hood",
		body="Gende. Bilaut +1",
		hands="Telchine Gloves",
		legs="Gyve Trousers",
		feet="Regal Pumps +1",
		neck="Fylgja Torque +1",
		waist="Porous Rope",
		left_ear="Mendi. Earring",
		right_ear="Loquac. Earring",
		right_ring="Stikini Ring +1",
		left_ring="Lebeche Ring", 	
		back="Pahtli Cape",
    })
    sets.midcast.cure.weather = set_combine(sets.midcast.cure.normal,{
		main="Chatoyant Staff",

    })    

    ------------
    -- Regen
    ------------	
	sets.midcast.regen = {} 	-- leave this empty
	-- Normal hybrid well rounded Regen
    sets.midcast.regen.hybrid = {
		main="Musa",
	    ammo="Ghastly Tathlum +1",
		head="Arbatel Bonnet +1",
		body="Telchine Chas.",
		hands="Telchine Gloves", 
		legs="Telchine Braconi",
		feet="Telchine Pigaches", 
		neck="Melic Torque",
		waist="Porous Rope",
		left_ear="Malignance Earring",
		right_ear="Loquac. Earring",
		left_ring="Stikini Ring +1",
		right_ring="Stikini Ring",
		back=SCHCape.NUKE,
    }
	-- Focus on Regen Duration 	
    sets.midcast.regen.duration = set_combine(sets.midcast.regen.hybrid,{
		head="Telchine Cap",
    }) 
	-- Focus on Regen Potency 	
    sets.midcast.regen.potency = set_combine(sets.midcast.regen.hybrid,{

    }) 
	
    ------------
    -- Aftercast
    ------------
      
    -- I don't use aftercast sets, as we handle what to equip later depending on conditions using a function.
	
end
