--Damage
GLOBALDAMAGE = 2.9

--Health
GLOBALHEALTH = 20

-- Bitter scale
smallScale = 0.5
mediumScale = 0.5
bigScale = 0.5
behemothScale = 0.5
smallScale = 0.5

-- TST
enemies = {
    scale = {
        smallScale = 0.5,
        mediumScale = 0.8,
        bigScale = 1.2,
        behemothScale = 1.7,
        smallScale = 7
    },
    damage = {
        baseDamage = GLOBALDAMAGE,
        smallDamage = baseDamage * 1,
        mediumDamage = baseDamage * 1.25,
        bigDamage = baseDamage * 1.50,
        behemothDamage = baseDamage * 2,
        experimentalDamage = baseDamage * 200
    },
    health = {
        baseHealth = GLOBALHEALTH,
        healthmediumbitter = baseHealth * 5,
        healthbigbitter = baseHealth * 20,
        healthbehemothbitter = baseHealth * 300,
        healthexpbitter = baseHealth * 3500
    },
    colors = {
        primary = {
            biterTint = {r = 0, g = 0, b = 0, a = 1},
            laserBiterTint = {r = 0, g = 0, b = 1, a = 1},
            physicalBiterTint = {r = 1, g = 1, b = 1, a = 1},
            explosiveBiterTint = {r = 1, g = 0, b = 0, a = 1},
            swimmerBiterTint = {r = 0.2, g = 0.9, b = 1, a = 1},
            climberBiterTint = {r = 1, g = 0.3, b = 0, a = 1},
            spitterTint = {r = 0.68, g = 0.4, b = 0, a = 1},
            fireSpitterTint = {r = 0.1, g = 1, b = 0.1, a = 1},
            rocketSpitterTint = {r = 1, g = 0, b = 1, a = 1}
        },
        secondary = {
            secondColor = {r = 0, g = 0, b = 0, a = 1},
            secondColor2 = {r = 1, g = 1, b = 1, a = 1}
        }
    }
}

--Worm scale
behemoth_worm_scale = 1.5
experimental_worm_scale = 5

--Spiter scale
smallspitterscale = 0.5
mediumspitterscale = 0.8
bigspitterscale = 1.2
behemothspitterscale = 1.7
expspitterscale = 7

--Biter scale
smallbitterscale = 0.5
mediumbitterscale = 0.8
bigbitterscale = 1.2
behemothbitterscale = 1.7
expbitterscale = 7

-- Colors
secondColor = {r = 0, g = 0, b = 0, a = 1}
secondColor2 = {r = 1, g = 1, b = 1, a = 1}

-- Spitter colors
spitterTint = {r = 0.68, g = 0.4, b = 0, a = 1}
fireSpitterTint = {r = 0.1, g = 1, b = 0.1, a = 1}
rocketSpitterTint = {r = 1, g = 0, b = 1, a = 1}

-- Biter colors
biterTint = {r = 0, g = 0, b = 0, a = 1}
laserBiterTint = {r = 0, g = 0, b = 1, a = 1}
physicalBiterTint = {r = 1, g = 1, b = 1, a = 1}
explosiveBiterTint = {r = 1, g = 0, b = 0, a = 1}
swimmerBiterTint = {r = 0.2, g = 0.9, b = 1, a = 1}
climberBiterTint = {r = 1, g = 0.3, b = 0, a = 1}

--Worm color
behemoth_worm_tint = {r = 0.34, g = 0.68, b = 0.90, a = 1.0}
experimental_worm_tint = {r = 0.34, g = 0.68, b = 0.90, a = 1.0}

--Fire
firerange = 13
firedmg = globaldmg / 2
firesmalldmg = firedmg * 1
firemediumdmg = firedmg * 1.25
firebigdmg = firedmg * 1.50
firebehemothdmg = firedmg * 2
fireexpdmg = firedmg * 200

--Rocket
rocketrange = 13
rocketdmg = globaldmg * 2
rocketsmalldmg = rocketdmg * 1
rocketmediumdmg = rocketdmg * 1.25
rocketbigdmg = rocketdmg * 1.50
rocketbehemothdmg = rocketdmg * 2
rocketexpdmg = rocketdmg * 200

--Explosive
explosivedmg = globaldmg * 1
explosivesmalldmg = explosivedmg * 1
explosivemediumdmg = explosivedmg * 1.25
explosivebigdmg = explosivedmg * 1.50
explosivebehemothdmg = explosivedmg * 2
explosiveexpdmg = explosivedmg * 200

--Spitter (normal)
spiterdmg = globaldmg * 0.5
spitersmalldmg = spiterdmg * 1
spitermediumdmg = spiterdmg * 1.25
spiterbigdmg = spiterdmg * 1.50
spiterbehemothdmg = spiterdmg * 2
spiterexpdmg = spiterdmg * 200

--Bitter (normal)
biterdmg = globaldmg * 1
bitersmalldmg = biterdmg * 1
bitermediumdmg = biterdmg * 1.25
biterbigdmg = biterdmg * 1.50
biterbehemothdmg = biterdmg * 2
biterexpdmg = biterdmg * 200

--Bitter
healthsmallbitter = globalhp
healthmediumbitter = globalhp * 5
healthbigbitter = globalhp * 20
healthbehemothbitter = globalhp * 300
healthexpbitter = globalhp * 3500

--Spitter
healthsmallspitter = healthsmallbitter * 0.66
healthmediumspitter = healthmediumbitter * 0.66
healthbigspitter = healthbigbitter * 0.66
healthbehemothspitter = healthbehemothbitter * 0.66
healthexpspitter = healthexpbitter * 0.66
