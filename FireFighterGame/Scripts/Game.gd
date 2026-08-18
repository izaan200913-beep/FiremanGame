extends Node

var Pause:bool = true
var Scraps:int = 0
@export var ScrapsBar:ProgressBar
@export var BulletManager:Node2D
@export var MinOrMaxY: float = 700
@export var BulletStartX:float = 140.0
@export var DistanceBeetweenBullet:float
@export var Player: Node2D
@export var HealthBar:ProgressBar
@export var EndMessage:AnimatedSprite2D
var Abilities: Array[String] = []
const BaseScrapMax:int = 10
var ScrapMax: int = BaseScrapMax
var ScrapMaxIncrement:int = 2
var IsBarrage:bool = false
var Rounds:int = 0
var RobotFinished:int = 0
var UpdateBars:bool = true
@export var MaxRobot:int
@export var RobotManager: Node2D
var Dead:bool = false
var NewBarrageManager:Node2D
const CardSet:PackedScene = preload("res://Scenes/CardSet.tscn")
const BarrageManager:PackedScene = preload("res://Scenes/BarrageManger.tscn")
const GamePath:PackedScene = preload("res://Scenes/Game.tscn")

func UpdateToAbilities():
	for i in Abilities:
		if i == "Barrage":
			if not IsBarrage:
				NewBarrageManager = BarrageManager.instantiate()
				self.add_child(NewBarrageManager)
				IsBarrage = true
			else: NewBarrageManager.Cooldown *= 0.75
			Abilities.erase(i)
		elif i == "Health":
			MaxRobot = ceili(MaxRobot * 1.5)
			Abilities.erase(i)

func _process(delta: float) -> void:
	if not Pause:
		ScrapsBar.value = Scraps
		ScrapsBar.max_value = ScrapMax
		HealthBar.max_value = MaxRobot
		HealthBar.value = MaxRobot - RobotFinished
	else:
		RobotFinished = 0
	
	UpdateToAbilities()
	
	if Scraps >= ScrapMax:
		Scraps = 0
		Rounds += 1
		var NewCardSet = CardSet.instantiate()
		NewCardSet.position.y = -250
		add_child(NewCardSet)

	EndMessage.visible = Dead
	if Dead:
		Scraps = 0
		if Input.is_action_just_pressed("Escape"):
			Player.Disappear()
			await get_tree().create_timer(0.8).timeout
			GlobalScript.SceneController.ChangeScene2D(GamePath)

	ScrapMax = BaseScrapMax + ScrapMaxIncrement * Rounds

	if RobotFinished >= MaxRobot:
		Pause = true
		Dead = true
