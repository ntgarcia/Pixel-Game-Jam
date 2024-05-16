extends CharacterBody2D

var speed = 0;
var direction = 1;
var player_chase = false;
var player = null;
var idle = true;
var counter = 0;


@onready var animated_sprite = $AnimatedSprite2D
@onready var ray_cast_right = $RayCastRight
@onready var ray_cast_left = $RayCastLeft

func _physics_process(delta):
	
	## two eel states, idle and chasing player.
	## idle eel state just left and right horizontal movement
	if idle:
		counter = 0;
		speed = 10
		print("idle")
		if(ray_cast_right.is_colliding()):
			direction = -1;
			animated_sprite.flip_h = false;
		if(ray_cast_left.is_colliding()):
			direction = 1;
			animated_sprite.flip_h = true;
		position.x += speed * delta * direction
	
	if player_chase:
		
		## eel jumps at the player and slows down rapidly after encounter
		counter +=1;
		speed = 20 + (counter/2);
		
		if(player.position.x < position.x):
			animated_sprite.flip_h = false
			direction = -1;
		else:
			animated_sprite.flip_h = true
			direction = 1;
			
		position += (player.position - position)/speed
	
				
## eel detection area signal functions
func _on_detection_area_body_entered(body):
	idle = false
	player = body
	player_chase = true;


func _on_detection_area_body_exited(body):

	idle = true
	player_chase = false
	player = null
	