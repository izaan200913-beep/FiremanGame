class_name Interactable extends Area2D

signal Interacted(Plr:Node2D)

var PlayerTouching: bool
var Player:Node2D

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("PickUp") and PlayerTouching:
		Interacted.emit(Player)
func _on_body_entered(body: Node2D) -> void:
	PlayerTouching = true
	Player = body

func _on_body_exited(body: Node2D) -> void:
	PlayerTouching = false
