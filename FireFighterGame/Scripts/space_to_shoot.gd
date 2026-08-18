extends AnimatedSprite2D

var E:bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Fire"):
		GlobalScript.SceneController.MainScene2D.Pause = false
		GlobalScript.SceneController.MainScene2D.Player.Splash()
		E = true
		animation = "E"
	if E and Input.is_action_just_pressed("PickUp"):
		queue_free()
