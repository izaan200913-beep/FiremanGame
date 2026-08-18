class_name GameControllerNode extends Node

@export var Game2D: Node
@export var MainScene2D: Node2D
@export var GUI: Node
@export var MainSceneGUI: Control
@export var Audio:Node
@export var Music:AudioStreamPlayer
const FirstScene:PackedScene = preload("res://Scenes/Game.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Music.play()
	GlobalScript.SceneController = self
	ChangeScene2D(FirstScene)

func ChangeScene2D(ScenePath:PackedScene, Delete: bool = true, Hide:bool = true) -> Node2D:
	print_tree_pretty()
	if MainScene2D:
		if Delete:
			MainScene2D.queue_free()
		elif Hide:
			MainScene2D.hide()
	var NewScene = ScenePath.instantiate()
	Game2D.add_child(NewScene)
	MainScene2D = NewScene
	return NewScene
func ReActivateScene2D(Scene:Node, Delete: bool = true, Hide:bool = true) -> Node2D:
	if MainScene2D:
		if Delete:
			MainScene2D.queue_free()
		elif Hide:
			MainScene2D.hide()
	var NewScene = Scene
	NewScene.show()
	return NewScene
func ChangeSceneGUI(ScenePath:String, Delete: bool = true, Hide:bool = true) -> Control:
	if MainSceneGUI:
		if Delete:
			MainSceneGUI.queue_free()
		elif Hide:
			MainSceneGUI.hide()
	var NewScene = load(ScenePath).instantiate()
	GUI.add_child(NewScene)
	MainSceneGUI = NewScene
	return NewScene
func ReActivateSceneGUI(Scene:Node, Delete: bool = true, Hide:bool = true) -> Control:
	if MainSceneGUI:
		if Delete:
			MainSceneGUI.queue_free()
		elif Hide:
			MainSceneGUI.hide()
	var NewScene = Scene
	NewScene.show()
	return NewScene
func PlaySFX(SFX:String):
	var Sound:AudioStreamPlayer
	for child in Audio.get_children():
		if child.name == SFX:
			Sound = child
			break
	Sound.pitch_scale = randf_range(0.9,1.1)
	Sound.play()
