extends Node

const Bullet:PackedScene = preload("res://Scenes/Bullet.tscn")
var BulletManager:Node2D
var CooldownTimer:float
@export var MinOrMaxY: float = 700
@export var BulletStartX:float = 140.0
@export var DistanceBeetweenBullet:float
@export var Cooldown:float
@export var CooldownBar:ProgressBar

func round_up_division(a: int, b: int) -> int: return ceil(a / float(b))

func  _ready() -> void:
	CooldownTimer = Cooldown
	CooldownBar.max_value = Cooldown

func _process(delta: float) -> void:
	if GlobalScript.SceneController.MainScene2D.Pause: CooldownTimer = Cooldown + 1
	CooldownBar.value = CooldownTimer
	CooldownBar.max_value = Cooldown
	CooldownTimer += delta
	if Input.is_action_just_pressed("Special") and not GlobalScript.SceneController.MainScene2D.Pause: Barrage()
func Barrage():
	if CooldownTimer > Cooldown:
		CooldownTimer = 0
		for z in range(1,4):
			for i in range(1,round_up_division(MinOrMaxY * 2,DistanceBeetweenBullet)):
				var NewBullet = Bullet.instantiate()
				NewBullet.position = Vector2(BulletStartX,i * DistanceBeetweenBullet - MinOrMaxY)
				GlobalScript.SceneController.MainScene2D.BulletManager.add_child(NewBullet)
			await get_tree().create_timer(0.25).timeout
