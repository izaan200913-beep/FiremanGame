extends CharacterBody2D

@export var Speed: float
@export var VelocityConservation:float
@export var Sprite: AnimatedSprite2D
@export var WaterShowTime:float
@export var WaterRegen:float
@export var Bar: ProgressBar
@export var BulletStartPos:Vector2
@export var BulletManager: Node2D
@export var Particles: CPUParticles2D
@export var Animating:bool

var Bullet:PackedScene = preload("res://Scenes/Bullet.tscn")
var WaterSplashTimer: float = 6
var WaterRegenTimer:float = 6
var Piercing:float = 1

func Move() -> void:
	#velocity *= VelocityConservation
	velocity.x = Input.get_axis("Left","Right") * Speed
	velocity.y = Input.get_axis("Up","Down") * Speed
	move_and_slide()
func _ready() -> void:
	Bar.max_value = WaterRegen
	Appear()

func SummonBullet():
	var NewBullet = Bullet.instantiate()
	NewBullet.position = to_global(BulletStartPos)
	NewBullet.Piercing = Piercing
	BulletManager.add_child(NewBullet)
	Particles.emitting = true

func Appear():
	Animating = true
	Sprite.animation = "Appear"
	await get_tree().create_timer(0.8).timeout
	Animating = false

func Disappear():
	GlobalScript.SceneController.PlaySFX("Teleport")
	Animating = true
	Sprite.animation = "Teleport"
	

func Splash() -> void:
	if WaterRegenTimer >= WaterRegen and GlobalScript.SceneController.MainScene2D.Pause == false:
		if Input.is_action_just_pressed("Fire"):
			GlobalScript.SceneController.PlaySFX("Shoot")
			WaterSplashTimer = 0
			WaterRegenTimer = 0
			SummonBullet()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not Animating:
		WaterSplashTimer += delta
		WaterRegenTimer += delta
		Bar.value = WaterRegenTimer
		Bar.max_value = WaterRegen
		Splash()
		
		for i in GlobalScript.SceneController.MainScene2D.Abilities:
			if i == "FireRate": 
				WaterRegen *= 0.75
				GlobalScript.SceneController.MainScene2D.Abilities.erase(i)
			elif i == "Speed":
				Speed += 100
				GlobalScript.SceneController.MainScene2D.Abilities.erase(i)
			elif i == "Piercing":
				Piercing += 1
				GlobalScript.SceneController.MainScene2D.Abilities.erase(i)
		
		if Input.get_axis("Left","Right") == 0 and Input.get_axis("Down","Up") == 0:
			Sprite.animation = "Idle"
		else:
			Sprite.animation = "Walk"

func _physics_process(delta: float) -> void: if not Animating:Move()
