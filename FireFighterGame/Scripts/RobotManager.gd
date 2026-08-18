extends Node2D

@export var StartX:float
@export var EndX:float
@export var MinY:float
@export var MaxY:float
@export var MinTime:float
@export var MaxTime:float
@export var RobotBaseSpeed:float
@export var ScrapManager:Node2D
var RobotSpeed:float
var SpawnTimer:float
@export var SpeedIncrease:float
var CurrentMinTime:float
var CurrentMaxTime:float

const RobotScene = preload("res://Scenes/EvilRobot.tscn")

func CreateRobot() -> void:
	var NewRobot:Node2D = RobotScene.instantiate()
	NewRobot.ParentNode = self
	NewRobot.ScrapManager = ScrapManager
	NewRobot.position.x = StartX
	NewRobot.position.y = randf_range(MinY,MaxY)
	NewRobot.Speed = RobotSpeed
	self.add_child(NewRobot)

func ResetTimer():
	CreateRobot()
	SpawnTimer += randf_range(CurrentMinTime,CurrentMaxTime)
	

func _ready() -> void:
	CurrentMinTime = MinTime
	CurrentMaxTime = MaxTime
	ResetTimer()

func _process(delta: float) -> void:
	CurrentMinTime = MinTime/(GlobalScript.SceneController.MainScene2D.Rounds * 0.5 + 1)
	CurrentMaxTime = MaxTime/(GlobalScript.SceneController.MainScene2D.Rounds * 0.5 + 1)
	RobotSpeed = RobotBaseSpeed + GlobalScript.SceneController.MainScene2D.Rounds * SpeedIncrease
	if not GlobalScript.SceneController.MainScene2D.Pause:
		SpawnTimer -= delta
		if SpawnTimer <= 0: ResetTimer()
