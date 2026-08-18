extends Node

var TouchedPlayer:Node2D
@export var Parent:Interactable

func _process(delta: float) -> void:
	if GlobalScript.SceneController.MainScene2D.Pause: Parent.queue_free()

func _on_interactable_interacted(Plr: Node2D) -> void:
	if not TouchedPlayer:
		TouchedPlayer = Plr
		GlobalScript.SceneController.MainScene2D.Scraps += 1
		GlobalScript.SceneController.PlaySFX("PickUp")
		Parent.queue_free()
