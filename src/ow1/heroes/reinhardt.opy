#!mainFile "../../main.opy"

def initReinhardt():
    
    do:
        clearCustomHealth()
        setCustomHealth(OW1_REINHARDT_HEALTH, OW1_REINHARDT_ARMOR, 0)
        wait(1)
    while (eventPlayer.getMaxHealth() != OW1_REINHARDT_HEALTH + OW1_REINHARDT_ARMOR)


rule "[reinhardt.opy]: Initialize Reinhardt":
    @Event eachPlayer
    @Hero reinhardt
    @Condition eventPlayer.initialized == false # without this flag, the reset code in generic.opy executes after initialization

    initReinhardt()
    eventPlayer.initialized = true

rule "[reinhardt.opy]: Set default charge cooldown":
    @Event eachPlayer
    @Hero reinhardt
    @Condition eventPlayer.isUsingAbility1()
    
    waitUntil(not eventPlayer.isUsingAbility1(), 9999)
    eventPlayer.setAbilityCooldown(Button.ABILITY_1, OW1_REINHARDT_CHARGE_COOLDOWN)

rule "[reinhardt.opy]: Force single firestrike":
    @Event eachPlayer
    @Hero reinhardt
    @Condition eventPlayer.isUsingAbility2() == true

    waitUntil(not eventPlayer.isUsingAbility2(), 1)
    eventPlayer.setAbilityCharge(Button.ABILITY_2, 0)
    wait(ow1_cooldown_ability2_REINHARDT)
    eventPlayer.setAbilityCharge(Button.ABILITY_2, 2)

rule "[reinhardt.opy]: Charge Damage":
    @Event eachPlayer
    @Hero reinhardt
    @Condition eventPlayer.isUsingAbility1() == true

    eventPlayer.setDamageDealt(percent(OW1_CHARGE_DAMAGE/OW2_CHARGE_DAMAGE))
    waitUntil(eventPlayer.isUsingAbility1() == false, 9999)
    wait(0.2)
    eventPlayer.setDamageDealt(100)
