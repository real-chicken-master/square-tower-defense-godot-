extends Control

const discShooterPrice = 50

const sniperPrice = 75

const sprayerPrice = 100

signal towerplace(TowerType)

signal startNextWave(waveNumber)

var towerType

var health

var money

var wave

@onready var healthLabel = $"topbar (Stats)/HBoxContainer/heartImage/health"

@onready var waveLabel = $"topbar (Stats)/HBoxContainer/wave"

@onready var moneyLabel = $"topbar (Stats)/HBoxContainer/$image/money"

var upgradeOpen = false

var upgradeTowerType

var upgradeTowerNode

var upgradeBranch1PriceMultiplyer = 1
var upgradeBranch1BasePrice = 30
var upgradeBranch1Price = upgradeBranch1BasePrice * upgradeBranch1PriceMultiplyer

var upgradeBranch2PriceMultiplyer = 1
var upgradeBranch2BasePrice = 40
var upgradeBranch2Price = upgradeBranch2BasePrice * upgradeBranch2PriceMultiplyer

var upgradeBranch3PriceMultiplyer = 1
var upgradeBranch3BasePrice = 50
var upgradeBranch3Price = upgradeBranch3BasePrice * upgradeBranch3PriceMultiplyer

var sellPrice = 0

func _ready():
	$"sidebar (towers)/HBoxContainer/speedButton".text = "x" + str(round(Engine.time_scale))
	$"sidebar (towers)/VBoxContainer(buttons)/discShooter".text = "$"+str(discShooterPrice)
	$"sidebar (towers)/VBoxContainer(buttons)/sniper".text = "$"+str(sniperPrice)
	$"sidebar (towers)/VBoxContainer(buttons)/sprayer".text = "$"+str(sprayerPrice)
	$"sidebar (towers)/VBoxContainer(buttons)".visible = true
	$"sidebar (towers)/VBoxContainer(upgrades)".visible = false
	if(Globals.levelpath == "res://maps/tutorialMap.tscn"):
		tutorial()


func _on_disc_shooter_button_down():
	if(money >= discShooterPrice):
		Globals.money -= discShooterPrice
		towerType = "disc Shooter"
		towerplace.emit(towerType)

func _on_sniper_button_down():
		if(money >= sniperPrice):
			Globals.money -= sniperPrice
			towerType = "sniper"
			towerplace.emit(towerType)


func _on_sprayer_button_down():
		if(money >= sprayerPrice):
			Globals.money -= sprayerPrice
			towerType = "sprayer"
			towerplace.emit(towerType)

func _process(_delta):
	updateStats()
	updateTowerButtons()
	if(upgradeOpen):
		if(is_instance_valid(upgradeTowerNode)):
			updateUpgradeButtons()

func updateStats():
	health = Globals.health
	money = Globals.money
	wave = Globals.wave
	healthLabel.text = str(health)
	moneyLabel.text = str(money)
	waveLabel.text = "wave
		" + str(wave)

func updateTowerButtons():
	if(money >= discShooterPrice):
		$"sidebar (towers)/VBoxContainer(buttons)/discShooter".modulate = Color.WHITE
	else:
		$"sidebar (towers)/VBoxContainer(buttons)/discShooter".modulate = Color.RED
	if(money >= sniperPrice):
		$"sidebar (towers)/VBoxContainer(buttons)/sniper".modulate = Color.WHITE
	else:
		$"sidebar (towers)/VBoxContainer(buttons)/sniper".modulate = Color.RED
	if(money >= sprayerPrice):
		$"sidebar (towers)/VBoxContainer(buttons)/sprayer".modulate = Color.WHITE
	else:
		$"sidebar (towers)/VBoxContainer(buttons)/sprayer".modulate = Color.RED


func _on_start_wave_button_down():
	if(!Globals.waveInProgress):
		Globals.waveInProgress = true
		Globals.wave += 1
		wave = Globals.wave
		startNextWave.emit(wave)

func towerUpgrade(upgradeBranch1,upgradeBranch2,upgradeBranch3,tower,towerNode):
	upgradeOpen = true
	upgradeTowerType = tower
	upgradeTowerNode = towerNode
	upgradeBranch1PriceMultiplyer = upgradeBranch1
	upgradeBranch2PriceMultiplyer = upgradeBranch2
	upgradeBranch3PriceMultiplyer = upgradeBranch3
	updateUpgradeButtons()
	$"sidebar (towers)/VBoxContainer(buttons)".visible = false
	$"sidebar (towers)/VBoxContainer(upgrades)".visible = true

func updateUpgradeButtons():
		upgradeBranch1PriceMultiplyer = upgradeTowerNode.upgradeBranch1
		upgradeBranch1Price = upgradeBranch1BasePrice * upgradeBranch1PriceMultiplyer
		if(money >= upgradeBranch1Price):
			$"sidebar (towers)/VBoxContainer(upgrades)/upgradeBranch1".modulate = Color.GREEN
		else:
			$"sidebar (towers)/VBoxContainer(upgrades)/upgradeBranch1".modulate = Color.RED
		upgradeBranch2PriceMultiplyer = upgradeTowerNode.upgradeBranch2
		upgradeBranch2Price = upgradeBranch2BasePrice * upgradeBranch2PriceMultiplyer
		if(money >= upgradeBranch2Price):
			$"sidebar (towers)/VBoxContainer(upgrades)/upgradeBranch2".modulate = Color.GREEN
		else:
			$"sidebar (towers)/VBoxContainer(upgrades)/upgradeBranch2".modulate = Color.RED
		upgradeBranch3PriceMultiplyer = upgradeTowerNode.upgradeBranch3
		upgradeBranch3Price = upgradeBranch3BasePrice * upgradeBranch3PriceMultiplyer
		$"sidebar (towers)/VBoxContainer(upgrades)/Label".text = upgradeTowerType + " upgrades"
		$"sidebar (towers)/VBoxContainer(upgrades)/upgradeBranch1".text = "increase attack speed by 10%
		from " + str(snapped(upgradeTowerNode.attackSpeed, 0.01))+ "
		$" + str(upgradeBranch1Price)
		$"sidebar (towers)/VBoxContainer(upgrades)/upgradeBranch2".text = "increase damage by 50%
		from " + str(snapped(upgradeTowerNode.Damage , 0.01)) + "
		$" + str(upgradeBranch2Price)
		sellPrice = floor((upgradeTowerNode.price + (10*upgradeBranch1PriceMultiplyer) + (12*upgradeBranch2PriceMultiplyer) + (10*upgradeBranch3PriceMultiplyer))/1.8)
		$"sidebar (towers)/VBoxContainer(upgrades)/sell".text = "sell for $" + str(sellPrice)

func _on_upgrade_branch_1_button_down():
	if(money >= upgradeBranch1Price):
		upgradeTowerNode.attackSpeed *= 1.1
		upgradeTowerNode.upgradeBranch1 += 1
		Globals.money -= upgradeBranch1Price
	updateUpgradeButtons()


func _on_upgrade_branch_2_button_down():
	if(money >= upgradeBranch2Price):
		upgradeTowerNode.Damage *= 1.5
		upgradeTowerNode.upgradeBranch2 += 1
		Globals.money -= upgradeBranch2Price
	updateUpgradeButtons()

func upgradeStop():
	await get_tree().create_timer(0.01).timeout
	if(!anyButtonPressed()):
		upgradeOpen = false
		$"sidebar (towers)/VBoxContainer(buttons)".visible = true
		$"sidebar (towers)/VBoxContainer(upgrades)".visible = false
		upgradeTowerNode = null
		upgradeTowerType = null

func anyButtonPressed():
	var anybuttonpressed = false
	for button in get_tree().get_nodes_in_group("button"):
		if(button.button_pressed):
			anybuttonpressed = true
	return anybuttonpressed

func _on_quit_button_button_down():
	get_tree().quit()


func _on_menu_button_button_down():
	get_tree().change_scene_to_file("res://UI/title_screen.tscn")


func _on_button_button_down():
	var speed = Globals.speed
	if(speed == 1):
		Globals.speed = 2
	if(speed == 2):
		Globals.speed = 1
	Engine.time_scale = Globals.speed
	$"sidebar (towers)/HBoxContainer/speedButton".text = "x" + str(round(Engine.time_scale))

func tutorial():
	for children in $"sidebar (towers)".get_children():
		for button in children.get_children():
			if(button.is_in_group("button")):
				button.set_disabled(true)


func _on_sell_button_down():
	var temp_time = Engine.time_scale
	var comformation = await areYouSure()
	if(comformation):
		Globals.money += sellPrice
		upgradeTowerNode.queue_free()
		Engine.time_scale = temp_time
		$areYouSure.visible = false
	else :
		Engine.time_scale = temp_time
		$areYouSure.visible = false
	

func areYouSure():
	$areYouSure/yes.set_pressed(false)
	$areYouSure/no.set_pressed(false)
	Engine.time_scale = 0
	$areYouSure.visible = true
	var buttonClicked = false
	while (!buttonClicked):
		if($areYouSure/yes.button_pressed):
			return true
		if($areYouSure/no.button_pressed):
			return false
		await get_tree().create_timer(0.0000001,true,false,true).timeout

