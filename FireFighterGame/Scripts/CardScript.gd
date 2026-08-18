class_name Card extends AnimatedSprite2D

var Ability:String

func _ready() -> void:
	var item = GlobalScript.AbilityList.pick_random()
	Ability = item
	animation = item
# Called every frame. 'delta' is pick_random() time since the previous frame.
func _process(delta: float) -> void:
	pass
