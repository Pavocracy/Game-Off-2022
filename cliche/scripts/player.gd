extends KinematicBody2D

var sprite: Sprite
var cartesian: Vector2
var isometric: Vector2
var _moved: Vector2
var speed: int
var jumping: bool
var jump_frame: int
var jump_direction: String
var tileSize: Dictionary

func _ready():
	sprite = $Sprite
	speed = 200
	jumping = false
	jump_frame = 0
	tileSize = Dictionary({"width": 223.0, "height": 128.0})

func cartesian_to_isometric(cartesian: Vector2):
	isometric = Vector2()
	isometric.x = cartesian.x - cartesian.y
	isometric.y = (cartesian.x + cartesian.y) / (tileSize["width"] / tileSize["height"])
	return isometric

func check_movement():
	cartesian = Vector2()
	if Input.is_action_pressed("up"):
		cartesian.y -= 1
		sprite.frame = 3
	if Input.is_action_pressed("right"):
		cartesian.x += 1
		sprite.frame = 2
	if Input.is_action_pressed("down"):
		cartesian.y += 1
		sprite.frame = 6
	if Input.is_action_pressed("left"):
		cartesian.x -= 1
		sprite.frame = 7
	cartesian = cartesian.normalized() * speed
	isometric = cartesian_to_isometric(cartesian)
	_moved = move_and_slide(isometric)

func check_jump():
	# This is pretty bad. Find a better way
	if Input.is_action_pressed("jump") && jumping == false:
		jumping = true
		jump_frame += 1
	if jumping == true:
		if jump_frame > 10:
			jumping = false
			jump_frame = 0
			return
		sprite.offset.y -= jump_frame if jump_frame <= 5 else -(jump_frame - 5)
		jump_frame += 1

func _physics_process(_delta):
	check_movement()
	check_jump()
