extends Node

@export var Card1:Card
@export var Card2:Card
@export var Card3:Card
@export var Arrow: AnimatedSprite2D

var CurrentCard:Card

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	CurrentCard = Card2
	GlobalScript.SceneController.MainScene2D.Pause = true



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	Arrow.position.x = CurrentCard.position.x
	if Input.is_action_just_pressed("First"): CurrentCard = Card1
	if Input.is_action_just_pressed("Second"): CurrentCard = Card2
	if Input.is_action_just_pressed("Third"): CurrentCard = Card3
	if Input.is_action_just_pressed("Fire"):
		GlobalScript.SceneController.PlaySFX("Upgrade")
		GlobalScript.SceneController.MainScene2D.Abilities.append(CurrentCard.Ability)
		GlobalScript.SceneController.MainScene2D.Pause = false
		queue_free()
