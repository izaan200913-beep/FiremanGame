extends Area2D

@export var Speed:float = 5
@export var MaxX:float
var Piercing:int


func _ready() -> void:pass

func _process(delta: float) -> void:
	position.x += Speed
	if position.x >= MaxX: queue_free()

func _on_body_entered(Robot: Node2D) -> void:
	Robot.Death()
	Piercing -= 1
	if Piercing == 0: queue_free()
