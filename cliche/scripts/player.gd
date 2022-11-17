extends KinematicBody2D

var sprite: Sprite
var movement: Vector2
var speed: int

func cartesian_to_isometric(cartesian: Vector2):
	return Vector2(cartesian.x - cartesian.y, (cartesian.x + cartesian.y) / 2)
	
func process_input(): 
	sprite = $Sprite
	movement = Vector2()
	speed = 200
	if Input.is_action_pressed("up"):
		movement.y -= 1
		sprite.frame = 1
	if Input.is_action_pressed("down"):
		movement.y += 1
		sprite.frame = 3
	if Input.is_action_pressed("left"):
		movement.x -= 1
		sprite.frame = 2
	if Input.is_action_pressed("right"):
		movement.x += 1
		sprite.frame = 0
	movement = movement.normalized() * speed
	movement = cartesian_to_isometric(movement)
	move_and_slide(movement)

func _physics_process(_delta):
	process_input()
