extends KinematicBody2D

const SPEED: int = 200
const GRAVITY: int = 20
var sprite: Sprite
var animation: AnimationTree
var cartesian: Vector2
var isometric: Vector2
var _moved: Vector2
var tileSize: Dictionary

func _ready():
	sprite = $Sprite
	animation = $AnimationTree
	tileSize = Dictionary({"width": 223.0, "height": 128.0})

func cartesian_to_isometric(input_cartesian: Vector2):
	isometric = Vector2()
	isometric.x = input_cartesian.x - input_cartesian.y
	isometric.y = (input_cartesian.x + input_cartesian.y) / (tileSize["width"] / tileSize["height"])
	return isometric

func check_movement():
	cartesian = Vector2()
	if Input.is_action_pressed("up"):
		cartesian.y -= 1
	if Input.is_action_pressed("right"):
		cartesian.x += 1
	if Input.is_action_pressed("down"):
		cartesian.y += 1
	if Input.is_action_pressed("left"):
		cartesian.x -= 1
	cartesian = cartesian.normalized()
	isometric = cartesian_to_isometric(cartesian)
	if isometric:
		animation.get("parameters/playback").travel("Walking")
		animation.set("parameters/Idle/blend_position", isometric)
		animation.set("parameters/Walking/blend_position", isometric)
		_moved = move_and_slide(isometric * SPEED)
	else:
		animation.get("parameters/playback").travel("Idle")

func check_jump():
	# TODO: Impliment jump using gravity
	if Input.is_action_pressed("jump"):
		pass

func _physics_process(_delta):
	check_movement()
	
func _input(_event):
	check_jump()
