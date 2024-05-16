extends CharacterBody2D

<<<<<<< HEAD
var collision = false
var max_speed = 80
var accel = 80
=======
const max_speed = 200
const accel = 150
>>>>>>> parent of f06ad63 (added submarine audio and tweaked sub movement)
const friction = 200

var input = Vector2.ZERO

@onready var animated_sprite = $AnimatedSprite2D

<<<<<<< HEAD

##Collision Audio
@onready var collision_1 = $Audio/collision1
@onready var collision_2 = $Audio/collision2
@onready var collision_3 = $Audio/collision3





=======
>>>>>>> parent of f06ad63 (added submarine audio and tweaked sub movement)
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
<<<<<<< HEAD
		if(accel < 80):
			accel += 0.2;
		
		if(collision):
			if(velocity.length()<20):
				velocity += (input * accel * delta)
		else:
			velocity += (input * accel * delta)
			velocity = velocity.limit_length(max_speed)
		
	move_and_slide()
	


func _on_area_2d_body_entered(body):
	
	collision = true;
	##ricochet on collision
	if(velocity.length() > 20):
		velocity= -velocity/3
	
	##reduce acceleration on collision

	accel = accel*.90
	
	var rng = RandomNumberGenerator.new()
	var num = rng.randi_range(0,2)
	
	match num:
		0:
			collision_1.play()
		1:
			collision_2.play()
		2:
			collision_3.play()


func _on_area_2d_body_exited(body):
	collision = false;
	
	
=======
		velocity += (input * accel * delta)
		velocity = velocity.limit_length(max_speed)
		
	move_and_slide()
>>>>>>> parent of f06ad63 (added submarine audio and tweaked sub movement)
