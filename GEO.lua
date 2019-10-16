
--[[
        Custom commands:
    
        Toggle Function: 
        gs c toggle melee               Toggle Melee mode on / off and locking of weapons
        gs c toggle mb                  Toggles Magic Burst Mode on / off.
        gs c toggle runspeed            Toggles locking on / off Herald's Gaiters
        gs c toggle idlemode            Toggles between Refresh and DT idle mode. Activating Sublimation JA will auto replace refresh set for sublimation set. DT set will superceed both.        
        gs c toggle regenmode           Toggles between Hybrid, Duration and Potency mode for regen set  
        gs c toggle nukemode            Toggles between Normal and Accuracy mode for midcast Nuking sets (MB included)  
        gs c toggle matchsc             Toggles auto swapping element to match the last SC that just happenned.
		
        Casting functions:
        these are to set fewer macros (2 cycle, 5 cast) to save macro space when playing lazily with controler
        
        gs c nuke cycle              	Cycles element type for nuking & SC
		gs c nuke cycledown				Cycles element type for nuking & SC	in reverse order
        gs c nuke t1                    Cast tier 1 nuke of saved element 
        gs c nuke t2                    Cast tier 2 nuke of saved element 
        gs c nuke t3                    Cast tier 3 nuke of saved element 
        gs c nuke t4                    Cast tier 4 nuke of saved element 
        gs c nuke t5                    Cast tier 5 nuke of saved element 
        gs c nuke ra1                   Cast tier 1 -ra nuke of saved element 
        gs c nuke ra2                   Cast tier 2 -ra nuke of saved element 
        gs c nuke ra3                   Cast tier 3 -ra nuke of saved element 	
		
		gs c geo geocycle				Cycles Geomancy Spell
		gs c geo geocycledown			Cycles Geomancy Spell in reverse order
		gs c geo indicycle				Cycles IndiColure Spell
		gs c geo indicycledown			Cycles IndiColure Spell in reverse order
		gs c geo geo					Cast saved Geo Spell
		gs c geo indi					Cast saved Indi Spell

        HUD Functions:
        gs c hud hide                   Toggles the Hud entirely on or off
        gs c hud hidemode               Toggles the Modes section of the HUD on or off
        gs c hud hidejob                Toggles the job section of the HUD on or off
        gs c hud hidebattle             Toggles the Battle section of the HUD on or off
        gs c hud lite                   Toggles the HUD in lightweight style for less screen estate usage. Also on ALT-END
        gs c hud keybinds               Toggles Display of the HUD keybindings (my defaults) You can change just under the binds in the Gearsets file.

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


include('organizer-lib') -- Remove if you dont use Organizer

--------------------------------------------------------------------------------------------------------------
res = require('resources')      -- leave this as is    
texts = require('texts')        -- leave this as is    
include('Modes.lua')            -- leave this as is      
--------------------------------------------------------------------------------------------------------------

-- Define your modes: 
-- You can add or remove modes in the table below, they will get picked up in the cycle automatically. 
-- to define sets for idle if you add more modes, name them: sets.me.idle.mymode and add 'mymode' in the group.
-- to define sets for regen if you add more modes, name them: sets.midcast.regen.mymode and add 'mymode' in the group.
-- Same idea for nuke modes. 
idleModes = M('normal', 'dt', 'mdt')
-- To add a new mode to nuking, you need to define both sets: sets.midcast.nuking.mynewmode as well as sets.midcast.MB.mynewmode
nukeModes = M('normal', 'acc')

-- Set this to true and as soon as you move you swap into movespeed set, and revert when stationary
-- Set it to false and the movespeed toggle is manual. 
autorunspeed = false

-- TP treshold where weapons gets locked. 
lockWeaponTP = 500

-- Setting this to true will stop the text spam, and instead display modes in a UI.
-- Currently in construction.
use_UI = true
hud_x_pos = 1400    --important to update these if you have a smaller screen
hud_y_pos = 200     --important to update these if you have a smaller screen
hud_draggable = true
hud_font_size = 10
hud_transparency = 200 -- a value of 0 (invisible) to 255 (no transparency at all)
hud_font = 'Impact'

-- Setup your Key Bindings here:  
    windower.send_command('bind insert gs c nuke cycle')            -- insert Cycles Nuke element
    windower.send_command('bind delete gs c nuke cycledown')        -- delete Cycles Nuke element in reverse order   
    windower.send_command('bind home gs c geo geocycle') 			-- home Cycles Geomancy Spell
    windower.send_command('bind PAGEUP gs c geo geocycledown') 		-- PgUP Cycles Geomancy Spell in reverse order	
    windower.send_command('bind PAGEDOWN gs c geo indicycle') 		-- PgDOWN Cycles IndiColure Spell
    windower.send_command('bind end gs c geo indicycledown') 	    -- End Cycles IndiColure Spell in reverse order	
    windower.send_command('bind !PAGEDOWN gs c geo entrustcycle') 	-- ALT-PgDown Cycles Entrust IndiColure Spell
    windower.send_command('bind !end gs c geo entrustcledown') 	    -- ALT-End Cycles Entrust IndiColure Spell in reverse order	
    windower.send_command('bind !f9 gs c toggle runspeed') 			-- Alt-F9 toggles locking on / off Herald's Gaiters
    windower.send_command('bind !f10 gs c toggle nukemode')         -- Alt-F10 to change Nuking Mode
    windower.send_command('bind F10 gs c toggle matchsc')           -- F10 to change Match SC Mode         
    windower.send_command('bind f12 gs c toggle melee')				-- F12 Toggle Melee mode on / off and locking of weapons
	windower.send_command('bind f9 gs c toggle idlemode')			-- F9 Toggles between MasterRefresh or MasterDT when no luopan is out
--[[
    This gets passed in when the Keybinds is turned on.
    Each one matches to a given variable within the text object
    IF you changed the Default Keybind above, Edit the ones below so it can be reflected in the hud using "//gs c hud keybinds" command
]]																	-- or between Full Pet Regen+DT or Hybrid PetDT and MasterDT when a Luopan is out
keybinds_on = {}
keybinds_on['key_bind_idle'] = '(F9)'
keybinds_on['key_bind_regen'] = '(END)'
keybinds_on['key_bind_casting'] = '(ALT-F10)'
keybinds_on['key_bind_matchsc'] = '(F10)'

keybinds_on['key_bind_element_cycle'] = '(INS or DEL)'
keybinds_on['key_bind_geo_cycle'] = '(HOME or PgUP)'
keybinds_on['key_bind_indi_cycle'] = '(End or PgDOWN)'
keybinds_on['key_bind_entrust_cycle'] = '(ALT + End or PgDOWN)'
keybinds_on['key_bind_lock_weapon'] = '(F12)'
keybinds_on['key_bind_movespeed_lock'] = '(ALT-F9)'


-- Remember to unbind your keybinds on job change.
function user_unload()
    send_command('unbind insert')
    send_command('unbind delete')
    send_command('unbind home')
    send_command('unbind PAGEUP')
    send_command('unbind PAGEDOWN')
    send_command('unbind ^PAGEDOWN')
    send_command('unbind end')
    send_command('unbind ^end')
    send_command('unbind f10')
    send_command('unbind !f10')
    send_command('unbind f12')
    send_command('unbind f9')
    send_command('unbind !f9')
end

--------------------------------------------------------------------------------------------------------------
include('GEO_Lib.lua')          -- leave this as is     
--------------------------------------------------------------------------------------------------------------

geomancy:set('Geo-Frailty')     -- Geo Spell Default		(when you first load lua / change jobs the saved spells is this one)
indicolure:set('Indi-Haste')    -- Indi Spell Default		(when you first load lua / change jobs the saved spells is this one)
entrustindi:set('Indi-Fury')    -- Enttrust Spell Default	(when you first load lua / change jobs the saved spells is this one)
validateTextInformation()

-- Optional. Swap to your sch macro sheet / book
set_macros(1,5) -- Sheet, Book   
    
-- Setup your Gear Sets below:
function get_sets()
  
    ----------------------------------------------------------
    -- Auto CP Cape: Will put on CP cape automatically when
    -- fighting Apex mobs and job is not mastered
    ----------------------------------------------------------
    CP_CAPE = "Mecisto. Mantle" -- Put your CP cape here
    ----------------------------------------------------------

    -- My formatting is very easy to follow. All sets that pertain to my character doing things are under 'me'.
    -- All sets that are equipped to faciliate my.pan's behaviour or abilities are under .pan', eg, Perpetuation, Blood Pacts, etc
      
    sets.me = {}        -- leave this empty
    sets.pan = {}       -- leave this empty
	sets.me.idle = {}	-- leave this empty    
	sets.pan.idle = {}	-- leave this empty 

	-- sets starting with sets.me means you DONT have a luopan currently out.
	-- sets starting with sets.pan means you DO have a luopan currently out.

	-- For aug gear you can define some here like this.. Look below in the midcast MB set to see how it is used.
    -- This helps when your augment changes to only have 1 place to update. 
    include('AugGear.lua')
    
    -- JSE
    AF = {}         -- leave this empty
    RELIC = {}      -- leave this empty
    EMPY = {}       -- leave this empty


    -- Fill this with your own JSE. 
    --Atrophy
    AF.Head     =   "Geo. Galero +1"
    AF.Body     =   "Geo. Tunic +1"
    AF.Hands    =   "Geo. Mitaines +1"
    AF.Legs     =   "Geo. Pants +1"
    AF.Feet     =   "Geo. Sandals +1"

    --Vitiation
    RELIC.Head  =   "Bagua Galero +1"
    RELIC.Body  =   "Bagua Tunic +1"
    RELIC.Hands =   "Bagua Mitaines +1"
    RELIC.Legs  =   "Bagua Pants +1"
    RELIC.Feet  =   "Bagua Sandals +1"

    --Lethargy
    EMPY.Head   =   "Azimuth Hood +1"
    EMPY.Body   =   "Azimuth Coat +1"
    EMPY.Hands  =   "Azimuth Gloves +1"
    EMPY.Legs   =   "Azimuth Tights +1"
    EMPY.Feet   =   "Azimuth Gaiters +1"

    -- Movespeed boots
    sets.me.movespeed = {feet=AF.Feet}

    -- Your idle set when you DON'T have a luopan out
    sets.me.idle.normal = {
        main="Idris",
        sub= "Ammurapi Shield",
        range="Dunna",
        head=EMPY.Head,
        body=Amal.Body.A,
        hands={ name="Bagua Mitaines +1", augments={'Enhances "Curative Recantation" effect',}},
        legs="Assid. Pants +1",
        feet=AF.Feet,
        neck="Twilight Torque",
        waist="Fucho-no-Obi",
        left_ear="Etiolation Earring",
        right_ear="Odnowa Earring +1",
        left_ring="Stikini Ring +1",
        right_ring="Defending Ring",
        back={ name="Nantosuelta's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Pet: "Regen"+10','Damage taken-5%',}},
    }
	
    -- Your idle MasterDT set (Notice the sets.me, means no Luopan is out)
    sets.me.idle.dt = set_combine(sets.me.idle.normal,{
        left_ear="Etiolation Earring",
        right_ear="Odnowa Earring +1",
        body="Mallquis Saio +2",
        feet="Mallquis Clogs +1",
		neck="Twilight Torque",	
		right_ring="Defending Ring",
        back={ name="Nantosuelta's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Pet: "Regen"+10','Damage taken-5%',}},
    })
    sets.me.idle.mdt = set_combine(sets.me.idle.normal,{
        left_ear="Etiolation Earring",
        right_ear="Odnowa Earring +1",
        body="Mallquis Saio +2",
        feet="Mallquis Clogs +1",
        neck="Twilight Torque", 
        right_ring="Defending Ring",
        back={ name="Nantosuelta's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Pet: "Regen"+10','Damage taken-5%',}},
    })	
    -- Your MP Recovered Whilst Resting Set
    sets.me.resting = { 

    }
	
	sets.me.latent_refresh = {waist="Fucho-no-obi"}
	
	
    -----------------------
    -- Luopan Perpetuation
    -----------------------
      
    -- Luopan's Out --  notice sets.pan 
    -- This is the base for all perpetuation scenarios, as seen below
    sets.pan.idle.normal = {
        main="Idris",
        sub= "Ammurapi Shield",
        range="Dunna",
        head=EMPY.Head,
        body="Telchine Chas.", 
        hands=AF.Hands,
        legs="Assid. Pants +1",
        feet=RELIC.Feet,
        neck="Bagua Charm +2",
        waist="Isa Belt",
        left_ear="Etiolation Earring",
        right_ear="Odnowa Earring +1",
        left_ring="Stikini Ring +1",
        right_ring="Defending Ring",
        back={ name="Nantosuelta's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Pet: "Regen"+10','Damage taken-5%',}},
    }
	
	-- This is when you have a Luopan out but want to sacrifice some slot for master DT, put those slots in.
    sets.pan.idle.dt = set_combine(sets.pan.idle.normal,{
        body="Mallquis Saio +2",
        feet="Mallquis Clogs +1",
        right_ring="Defending Ring",
        back={ name="Nantosuelta's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Pet: "Regen"+10','Damage taken-5%',}},
    })   
    sets.pan.idle.mdt = set_combine(sets.pan.idle.normal,{
        body="Mallquis Saio +2",
        feet="Mallquis Clogs +1",
        right_ring="Defending Ring",
        back={ name="Nantosuelta's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Pet: "Regen"+10','Damage taken-5%',}},
    })   
    -- Combat Related Sets
      
    -- Melee
    -- Anything you equip here will overwrite the perpetuation/refresh in that slot.
	-- No Luopan out
	-- they end in [idleMode] so it will derive from either the normal or the dt set depending in which mode you are then add the pieces filled in below.
    sets.me.melee = set_combine(sets.me.idle[idleMode],{
        range={ name="Dunna", augments={'MP+20','Mag. Acc.+10','"Fast Cast"+3',}},
        head="Jhakri Coronal +1",
        body="Jhakri Robe +2",
        hands="Jhakri Cuffs +2",
        legs="Jhakri Slops +2",
        feet="Jhakri Pigaches +2",
        neck="Sanctity Necklace",
        waist="Windbuffet Belt +1",
        left_ear="Mache Earring +1",
        right_ear="Telos Earring",
        left_ring="Jhakri Ring",
        right_ring="Supershear Ring",
        back={ name="Nantosuelta's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Pet: "Regen"+10','Damage taken-5%',}},
    })
	
    -- Luopan is out
	sets.pan.melee = set_combine(sets.pan.idle[idleMode],{
        range={ name="Dunna", augments={'MP+20','Mag. Acc.+10','"Fast Cast"+3',}},
        head="Jhakri Coronal +1",
        body="Jhakri Robe +2",
        hands="Jhakri Cuffs +2",
        legs="Jhakri Slops +2",
        feet="Jhakri Pigaches +2",
        neck="Sanctity Necklace",
        waist="Windbuffet Belt +1",
        left_ear="Mache Earring +1",
        right_ear="Telos Earring",
        left_ring="Jhakri Ring",
        right_ring="Supershear Ring",
        back={ name="Nantosuelta's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Pet: "Regen"+10','Damage taken-5%',}},
    }) 
    
    -- Weapon Skill sets
	-- Example:
    sets.me["Flash Nova"] = {

    }

    sets.me["Realmrazer"] = {

    }
	
    sets.me["Exudation"] = {

    } 
    -- Feel free to add new weapon skills, make sure you spell it the same as in game.
  
    ---------------
    -- Casting Sets
    ---------------
      
    sets.precast = {}               -- leave this empty    
    sets.midcast = {}               -- leave this empty    
    sets.aftercast = {}             -- leave this empty    
    sets.midcast.nuking = {}        -- leave this empty
    sets.midcast.MB = {}            -- leave this empty    
    ----------
    -- Precast
    ----------
      
    -- Generic Casting Set that all others take off of. Here you should add all your fast cast  
    sets.precast.casting = {
        main="Idris",
        sub= "Ammurapi Shield",
        range="Dunna",
        head=Amal.Head.A,
        body=Merl.Body.FC,
        hands="Telchine Gloves",
        legs="Geo. Pants +1",
        feet="Regal Pumps +1",
        neck="Bagua Charm +2",
        waist="Witful Belt",
        left_ear="Malignance Earring",
        right_ear="Loquac. Earring",
        right_ring="Lebeche Ring",
        left_ring="Weather. Ring",
        back="Lifestream Cape",
    }   

    sets.precast.geomancy = set_combine(sets.precast.casting,{
        
    })
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
        right_ring="Lebeche Ring",
        right_ear="Mendi. Earring",
    })
    sets.precast.regen = set_combine(sets.precast.casting,{

    })     
    ---------------------
    -- Ability Precasting
    ---------------------
	
	-- Fill up with your JSE! 
    sets.precast["Life Cycle"] = {
    	body = AF.Body,
    }
    sets.precast["Bolster"] = {
    	body = RELIC.Body,
    }
    sets.precast["Primeval Zeal"] = {
    	head = RELIC.Head,
    }  
    sets.precast["Cardinal Chant"] = {
    	head = AF.Head,
    }  
    sets.precast["Full Circle"] = {
    	head = EMPY.Head,
    }  
    sets.precast["Curative Recantation"] = {
    	hands = RELIC.Hands,
    }  
    sets.precast["Mending Halation"] = {
    	legs = RELIC.Legs,
    }
    sets.precast["Radial Arcana"] = {
    	feet = RELIC.Feet,
    }

    ----------
    -- Midcast
    ----------
            
    -- Whatever you want to equip mid-cast as a catch all for all spells, and we'll overwrite later for individual spells
    sets.midcast.casting = {
        main="Idris",
        sub="Ammurapi Shield",
        range={ name="Dunna", augments={'MP+20','Mag. Acc.+10','"Fast Cast"+3',}},
        head=Merl.Head.ACC,
        body=Amal.Body.A,
        hands=Amal.Hands.D,
        legs=Amal.Legs.A,
        feet=Amal.Feet.A,
        neck="Bagua Charm +2",
        waist="Refoccilation Stone",
        left_ear="Barkaro. Earring",
        right_ear="Malignance Earring",
        left_ring="Stikini Ring +1",
        right_ring="Weather. Ring",
        back="Perimede Cape",
    }
	
	-- For Geo spells /
    sets.midcast.geo = set_combine(sets.midcast.casting,{
        main="Idris",
        sub="Ammurapi Shield",
        range={ name="Dunna", augments={'MP+20','Mag. Acc.+10','"Fast Cast"+3',}},
        head=EMPY.Head,
        body=EMPY.Body,
        hands=EMPY.Hands,
        legs=EMPY.Legs,
        feet=EMPY.Feet,
        neck="Bagua Charm +2",
        waist="Hachirin-no-Obi",
        left_ear="Malignance Earring",
        right_ear="Barkaro. Earring",
        left_ring="Stikini Ring +1",
        right_ring="Stikini Ring",
        back={ name="Lifestream Cape", augments={'Geomancy Skill +10','Indi. eff. dur. +18','Pet: Damage taken -3%',}},
    })
	-- For Indi Spells
    sets.midcast.indi = set_combine(sets.midcast.geo,{
        main="Solstice",
        legs="Bagua Pants +1",
    })
	
	-- For Entrusted Indi Spells
    sets.midcast.entrust = set_combine(sets.midcast.indi,{
        main="Solstice",
        legs="Bagua Pants +1",
    })

	sets.midcast.Obi = {
	    waist="Hachirin-no-Obi",
	}
	
	-- Nuking
    sets.midcast.nuking.normal = set_combine(sets.midcast.casting,{
        main="Maxentius",
        sub="Ammurapi Shield",
        range={ name="Dunna", augments={'MP+20','Mag. Acc.+10','"Fast Cast"+3',}},
        head=Merl.Head.ACC,
        body=Amal.Body.A,
        hands=Amal.Hands.D,
        legs=Amal.Legs.A,
        feet=Amal.Feet.A,
        neck="Mizu. Kubikazari",
        waist="Refoccilation Stone",
        left_ear="Barkaro. Earring",
        right_ear="Malignance Earring",
        left_ring="Shiva Ring",
        right_ring="Freke Ring",
        back="Moonbeam Cape",
    })
	sets.midcast.MB.normal = set_combine(sets.midcast.nuking.normal, {
        head= Merl.Head.MB,
        body=Merl.Body.MB,
        neck="Mizu. Kubikazari",
        left_ring="Locus Ring",
        right_ring="Mujin Band",
	})
    sets.midcast.nuking.acc = set_combine(sets.midcast.nuking.normal,{

    })
    sets.midcast.MB.acc = set_combine(sets.midcast.MB.normal, {

    })

	-- Enfeebling
	sets.midcast.IntEnfeebling = set_combine(sets.midcast.casting,{
        main="Maxentius",
        sub= "Ammurapi Shield",
        head=Merl.Head.ACC,
        body=Amal.Body.A,
        hands="Azimuth Gloves +1",
        legs="Psycloth Lappas",
        feet="Jhakri Pigaches +1",
        neck="Bagua Charm +2",
        waist="Porous Rope",
        left_ear="Barkaro. Earring",
        right_ear="Barkaro. Earring",
        left_ring="Stikini Ring +1",
        right_ring="Weather. Ring",
        back="Lifestream Cape", 
    })
	sets.midcast.MndEnfeebling = set_combine(sets.midcast.casting,{
        main="Maxentius",
        sub= "Ammurapi Shield",
        head=Merl.Head.ACC,
        body=Amal.Body.A,
        hands="Azimuth Gloves +1",
        legs="Psycloth Lappas",
        feet="Jhakri Pigaches +1",
        neck="Bagua Charm +2",
        waist="Porous Rope",
        left_ear="Barkaro. Earring",
        right_ear="Barkaro. Earring",
        left_ring="Stikini Ring +1",
        right_ring="Weather. Ring",
        back="Lifestream Cape", 
    })
	
    -- Enhancing
    sets.midcast.enhancing = set_combine(sets.midcast.casting,{
        main="Maxentius",
        sub= "Ammurapi Shield",
        range={ name="Dunna", augments={'MP+20','Mag. Acc.+10','"Fast Cast"+3',}},
        head="Telchine Cap",
        body="Telchine Chas.",
        hands="Telchine Gloves",
        legs="Telchine Braconi",
        feet="Telchine Pigaches",
        neck="Melic Torque",
        waist="Porous Rope",
        left_ear="Andoaa Earring",
        right_ear="Malignance Earring",
        left_ring="Stikini Ring +1",
        right_ring="Stikini Ring",
        back="Perimede Cape",
    })
	
    -- Stoneskin
    sets.midcast.stoneskin = set_combine(sets.midcast.enhancing,{
		waist="Siegel Sash",
    })
    sets.midcast.refresh = set_combine(sets.midcast.enhancing,{
		head=Amal.Head.A,
    })
    sets.midcast.aquaveil = sets.midcast.refresh
	
	sets.midcast["Drain"] = set_combine(sets.midcast.IntEnfeebling, {
    	main={ name="Rubicundity", augments={'Mag. Acc.+10','"Mag.Atk.Bns."+10','Dark magic skill +10','"Conserve MP"+7',}},		
		head="Pixie Hairpin +1",
		neck="Erra Pendant",
        back="Perimede Cape",
	})

	sets.midcast["Aspir"] = sets.midcast["Drain"]
     
    sets.midcast.cure = {} -- Leave This Empty
    -- Cure Potency
    sets.midcast.cure.normal = set_combine(sets.midcast.casting,{
        main="Serenity",
        sub="Enki Strap",
        head="Vanya Hood",
        body="Gende. Bilaut +1",
        hands="Telchine Gloves",
        legs="Gyve Trousers",
        feet="Regal Pumps +1",
        neck="Fylgja Torque +1",
        waist="Porous Rope",
        left_ear="Malignance Earring",
        right_ear="Mendi. Earring",
        right_ring="Lebeche Ring",
        left_ring="Stikini Ring +1", 
        back="Pahtli Cape",
    })
    sets.midcast.cure.weather = set_combine(sets.midcast.cure.normal,{
        main="Chatoyant Staff",

    })    
    sets.midcast.regen = set_combine(sets.midcast.enhancing,{
        main="Bolelabunga",
        sub= "Ammurapi Shield",
        head="Telchine Cap",
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
        back="Perimede Cape",
    }) 
   
    ------------
    -- Aftercast
    ------------
      
    -- I don't use aftercast sets, as we handle what to equip later depending on conditions using a function, eg, do we have a Luopan pan out?
  
end
