--------------------------------------------------
--Generic Declaration
--------------------------------------------------
    Amal = {}
    Amal.Head = {}
    Amal.Body = {}
    Amal.Hands = {}
    Amal.Legs = {}
    Amal.Feet = {}
    Merl = {}
    Merl.Head = {}
    Merl.Body = {}
    Merl.Hands = {}
    Merl.Legs = {}
    Merl.Feet = {}
    Adh = {}
    Adh.Head = {}
    Adh.Body = {}
    Adh.Hands = {}
    Adh.Legs = {}
    Adh.Feet = {}
    Lustr = {}
    Lustr.Head = {}
    Lustr.Body = {}
    Lustr.Hands = {}
    Lustr.Legs = {}
    Lustr.Feet = {}
    Rao = {}
    Rao.Head = {}
    Rao.Body = {}
    Rao.Hands = {}
    Rao.Legs = {}
    Rao.Feet = {}
    Ryuo = {}
    Ryuo.Head = {}
    Ryuo.Body = {}
    Ryuo.Hands = {}
    Ryuo.Legs = {}
    Ryuo.Feet = {}
    Herc = {}
    Herc.Head = {}
    Herc.Body = {}
    Herc.Hands = {}
    Herc.Legs = {}
    Herc.Feet = {}
    Chiro = {}
    Chiro.Head = {}
    Chiro.Body = {}
    Chiro.Hands = {}
    Chiro.Legs = {}
    Chiro.Feet = {}
    Carm = {}
    Carm.Head = {}
    Carm.Body = {}
    Carm.Hands = {}
    Carm.Legs = {}
    Carm.Feet = {}
    Kayk = {}
    Kayk.Head = {}
    Kayk.Body = {}
    Kayk.Hands = {}
    Kayk.Legs = {}
    Kayk.Feet = {}
    Taeon = {}
    Taeon.Head = {}
    Taeon.Body = {}
    Taeon.Hands = {}
    Taeon.Legs = {}
    Taeon.Feet = {}
--------------------------------------------------
--------------------------------------------------    

-- This helps when your augment changes to only have 1 place to update. 


if  ( player.main_job == "BLM" or
      player.main_job == "RDM" or 
      player.main_job == "SMN" or 
      player.main_job == "BLU" or 
      player.main_job == "SCH" or 
      player.main_job == "GEO" ) then 
       
	Amal.Head.A			=	{ name="Amalric Coif +1", augments={'MP+80','Mag. Acc.+20','"Mag.Atk.Bns."+20',}} 
	Amal.Body.A			=	{ name="Amalric Doublet +1", augments={'MP+80','Mag. Acc.+20','"Mag.Atk.Bns."+20',}}
	Amal.Hands.D		=	{ name="Amalric Gages +1", augments={'INT+12','Mag. Acc.+20','"Mag.Atk.Bns."+20',}}
	Amal.Legs.A			=	{ name="Amalric Slops +1", augments={'MP+80','Mag. Acc.+20','"Mag.Atk.Bns."+20',}}
	Amal.Feet.A			=	{ name="Amalric Nails +1", augments={'MP+80','Mag. Acc.+20','"Mag.Atk.Bns."+20',}}
end

if  ( player.main_job == "WHM" or
      player.main_job == "RDM" or 
      player.main_job == "BRD" or 
      player.main_job == "SCH" ) then 
       
  Kayk.Hands.A			=	{ name="Kaykaus Cuffs +1", augments={'MP+80','MND+12','Mag. Acc.+20',}}
end

if  ( player.main_job == "BLM" or
      player.main_job == "RDM" or 
      player.main_job == "SMN" or 
      player.main_job == "SCH" or 
      player.main_job == "GEO" ) then 
    
	Merl.Head.MB		=	{ name="Merlinic Hood", augments={'Attack+23','Magic burst dmg.+11%','INT+8','"Mag.Atk.Bns."+13',}}
	Merl.Head.ACC		=	{ name="Merlinic Hood", augments={'Mag. Acc.+25 "Mag.Atk.Bns."+25','Magic burst dmg.+2%','INT+7','Mag. Acc.+15',}}
	Merl.Body.FC		=	{ name="Merlinic Jubbah", augments={'Mag. Acc.+2 "Mag.Atk.Bns."+2','"Fast Cast"+6','CHR+5','"Mag.Atk.Bns."+14',}}
	Merl.Body.MB		=	{ name="Merlinic Jubbah", augments={'Mag. Acc.+8 "Mag.Atk.Bns."+8','Magic burst dmg.+9%','CHR+9','Mag. Acc.+7',}}
	Merl.Legs.MB		=	{ name="Merlinic Shalwar", augments={'Mag. Acc.+28','Magic burst dmg.+9%','INT+2','"Mag.Atk.Bns."+15',}}
end

if  ( player.main_job == "WHM" or
      player.main_job == "RDM" or 
      player.main_job == "BRD" or 
      player.main_job == "SCH" ) then 
    
	Chiro.Legs.Acc		=	{ name="Chironic Hose", augments={'Mag. Acc.+25 "Mag.Atk.Bns."+25','Haste+3','MND+8','"Mag.Atk.Bns."+8',}}
end

if  ( player.main_job == "MNK" or
      player.main_job == "THF" or 
      player.main_job == "RNG" or 
      player.main_job == "NIN" or 
      player.main_job == "BLU" or 
      player.main_job == "COR" or
      player.main_job == "PUP" or
      player.main_job == "DNC" or
      player.main_job == "RUN" ) then 

	Herc.Head.WS		  =	{ name="Herculean Helm", augments={'Accuracy+22','Weapon skill damage +3%','STR+3','Attack+14',}}
	Herc.Head.PetTP		=	{ name="Herculean Helm", augments={'Pet: Accuracy+26 Pet: Rng. Acc.+26','Pet: "Store TP"+8','Pet: AGI+1','Pet: Attack+7 Pet: Rng.Atk.+7',}}
	Herc.Head.PetDA		=	{ name="Herculean Helm", augments={'Pet: Attack+22 Pet: Rng.Atk.+22','Pet: "Dbl. Atk."+3','Pet: AGI+10',}}    
	Herc.Hands.PetTP	=	{ name="Herculean Gloves", augments={'Pet: "Store TP"+9','Pet: DEX+12','Pet: Attack+10 Pet: Rng.Atk.+10',}}
	Herc.Hands.PetDA	=	{ name="Herculean Gloves", augments={'Pet: Accuracy+24 Pet: Rng. Acc.+24','Pet: "Dbl. Atk."+3','Pet: Attack+7 Pet: Rng.Atk.+7',}}
	Herc.Legs.PetTP		=	{ name="Herculean Trousers", augments={'Pet: Accuracy+14 Pet: Rng. Acc.+14','Pet: "Store TP"+11','Pet: STR+2',}}
	Herc.Legs.PetDA		=	{ name="Herculean Trousers", augments={'Pet: Attack+13 Pet: Rng.Atk.+13','Pet: "Dbl.Atk."+3 Pet: Crit.hit rate +3','Pet: STR+8',}}
	Herc.Feet.WS		  =	{ name="Herculean Boots", augments={'Accuracy+21 Attack+21','Weapon skill damage +4%','AGI+3','Accuracy+13','Attack+7',}}
	Herc.Feet.PetTP		=	{ name="Herculean Boots", augments={'Pet: Accuracy+26 Pet: Rng. Acc.+26','Pet: "Store TP"+10','Pet: STR+2','Pet: Attack+10 Pet: Rng.Atk.+10','Pet: "Mag.Atk.Bns."+5',}}
	Herc.Feet.PetDA		=	{ name="Herculean Boots", augments={'Pet: Accuracy+23 Pet: Rng. Acc.+23','Pet: "Dbl. Atk."+3','Pet: DEX+11','Pet: Attack+10 Pet: Rng.Atk.+10','Pet: "Mag.Atk.Bns."+10',}}    
	Herc.Body.TP		  =	{ name="Herculean Vest", augments={'Accuracy+18 Attack+18','"Triple Atk."+2','DEX+1','Accuracy+3','Attack+15',}}	
end

if  ( player.main_job == "WAR" or
      player.main_job == "THF" or 
      player.main_job == "PLD" or 
      player.main_job == "DRK" or 
      player.main_job == "BST" or 
      player.main_job == "BRD" or
      player.main_job == "DRG" or
      player.main_job == "DNC" or
      player.main_job == "RUN" ) then 

	Lustr.Head.A		=	{ name="Lustratio Cap +1", augments={'Attack+20','STR+8','"Dbl.Atk."+3',}}
	Lustr.Body.A		=	{ name="Lustr. Harness +1", augments={'Attack+20','STR+8','"Dbl.Atk."+3',}}
	Lustr.Legs.B		=	{ name="Lustr. Subligar +1", augments={'Accuracy+20','DEX+8','Crit. hit rate+3%',}}
	Lustr.Feet.A		=	{ name="Lustra. Leggings +1", augments={'Attack+20','STR+8','"Dbl.Atk."+3',}}
end

if  ( player.main_job == "MNK" or
      player.main_job == "THF" or 
      player.main_job == "RNG" or 
      player.main_job == "NIN" or 
      player.main_job == "BLU" or 
      player.main_job == "COR" or
      player.main_job == "DNC" or
      player.main_job == "RUN" ) then 

	Adh.Hands.A			=	{ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}}
	Adh.Head.B			=	{ name="Adhemar Bonnet +1", augments={'STR+12','DEX+12','Attack+20',}}
end

if  ( player.main_job == "MNK" or
      player.main_job == "SAM" or 
      player.main_job == "NIN" or 
      player.main_job == "PUP" ) then 

  Rao.Head.C			=	{ name="Rao Kabuto +1", augments={'Pet: HP+125','Pet: Accuracy+20','Pet: Damage taken -4%',}}
  Rao.Body.C			=	{ name="Rao Togi +1", augments={'Pet: HP+125','Pet: Accuracy+20','Pet: Damage taken -4%',}}
  Rao.Hands.C			=	{ name="Rao Kote +1", augments={'Pet: HP+125','Pet: Accuracy+20','Pet: Damage taken -4%',}}
  Rao.Feet.C			=	{ name="Rao Sune-Ate +1", augments={'Pet: HP+125','Pet: Accuracy+20','Pet: Damage taken -4%',}}

  Ryuo.Hands.A		=	{ name="Ryuo Tekko +1", augments={'STR+12','DEX+12','Accuracy+20',}}
  Ryuo.Feet.D			=	{ name="Ryuo Sune-Ate +1", augments={'STR+12','Attack+25','Crit. hit rate+4%',}}
end

if  ( player.main_job == "RDM" or
      player.main_job == "PLD" or 
      player.main_job == "DRK" or 
      player.main_job == "RNG" or
      player.main_job == "DRG" or
      player.main_job == "BLU" or
      player.main_job == "COR" or
      player.main_job == "RUN" ) then 

	Carm.Head.D			=	{ name="Carmine Mask +1", augments={'Accuracy+20','Mag. Acc.+12','"Fast Cast"+4',}}
  Carm.Legs.D			=	{ name="Carmine Cuisses +1", augments={'Accuracy+20','Attack+12','"Dual Wield"+6',}}
  Carm.Feet.B			=	{ name="Carmine Greaves +1", augments={'Accuracy+12','DEX+12','MND+20',}}
end

if  ( player.main_job == "MNK" or
      player.main_job == "RDM" or
      player.main_job == "THF" or
      player.main_job == "BST" or
      player.main_job == "RNG" or
      player.main_job == "NIN" or
      player.main_job == "DRG" or
      player.main_job == "BLU" or
      player.main_job == "COR" or
      player.main_job == "PUP" or
      player.main_job == "DNC" or
      player.main_job == "RUN" ) then

  Taeon.Head.Phalanx	=	{ name="Taeon Chapeau", augments={'DEF+3','"Conserve MP"+5','Phalanx +3',}}
  Taeon.Head.TP		=	{ name="Taeon Chapeau", augments={'Accuracy+20 Attack+20','"Triple Atk."+2','STR+5 DEX+5',}}
  Taeon.Body.Phalanx	=	{ name="Taeon Tabard", augments={'"Fast Cast"+2','Phalanx +3',}}
  Taeon.Hands.Phalanx =	{ name="Taeon Gloves", augments={'"Fast Cast"+5','Phalanx +3',}}
  Taeon.Legs.Phalanx	=	{ name="Taeon Tights", augments={'Accuracy+12 Attack+12','Spell interruption rate down -9%','Phalanx +3',}}
  Taeon.Feet.Phalanx	=	{ name="Taeon Boots", augments={'Spell interruption rate down -8%','Phalanx +3',}}
end