extends CharacterBody2D

var Speed:float
@export var ParentNode:Node2D
var ScrapManager:Node2D
@export var Player:Node2D
@export var DeathParticles:CPUParticles2D
@export var Sprite:AnimatedSprite2D

var IsEnable:bool = true
const Scrap: PackedScene = preload("res://Scenes/Scraps.tscn")

func _physics_process(delta: float) -> void:
	position.x -= Speed

func _process(delta: float) -> void:
	if ParentNode.EndX > position.x:
		GlobalScript.SceneController.MainScene2D.RobotFinished += 1
		GlobalScript.SceneController.PlaySFX("RobotFinish")
		self.queue_free()
	if position.y >= GlobalScript.SceneController.MainScene2D.Player.position.y: z_index = 6
	else: z_index = 4
	if GlobalScript.SceneController.MainScene2D.Pause: Delete()

func Delete():
	DeathParticles.emitting = true
	Sprite.hide()
	await get_tree().create_timer(1).timeout
	queue_free()

func Death():
	if IsEnable:
		GlobalScript.SceneController.PlaySFX("RobotDeath")
		IsEnable = false
		DeathParticles.emitting = true
		Sprite.hide()
		var NewScrap = Scrap.instantiate()
		NewScrap.position = position
		self.position = Vector2(15000,1500)
		await get_tree().create_timer(1).timeout
		ScrapManager.add_child(NewScrap)
		queue_free()
