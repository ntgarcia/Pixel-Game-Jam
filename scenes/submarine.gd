extends CharacterBody2D

const max_speed = 200
const accel = 400
const friction = 600

var input = Vector2.ZERO

@onready var animated_sprite = $AnimatedSprite2D

func _physics_process(delta):
	var direction = Input.get_axis("move_left", "move_right")
	
	# Flip sprite on direcction
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true
	player_movement(delta)

func get_input():
	input.x = int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left"))
	input.y = int(Input.is_action_pressed("move_down")) - int(Input.is_action_pressed("move_up"))
	return input.normalized()

func player_movement(delta):
	input = get_input()
	
	if input == Vector2.ZERO:
		if velocity.length() > (friction * delta):
			velocity -= velocity.normalized() * (friction * delta)
		else:
			velocity = Vector2.ZERO
	else:
		velocity += (input * accel * delta)
		velocity = velocity.limit_length(max_speed)
		
	move_and_slide()
