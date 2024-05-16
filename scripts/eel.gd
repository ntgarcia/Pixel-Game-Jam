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

##sounds
@onready var idle_sound = $idle
@onready var detect_player_sound = $detect_player

func _physics_process(delta):
	
	## two eel states, idle and chasing player.
	## idle eel state just left and right horizontal movement
	if idle:
		counter = 0;
		speed = 10

	if(!idle_sound.has_stream_playback()):
		idle_sound.play()

	if(ray_cast_right.is_colliding()):
		direction = -1;
		animated_sprite.flip_h = false;
		position.x += speed * delta * direction
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
	player = body
	idle = false
	player_chase = true;
	detect_player_sound.play()
		

func _on_detection_area_body_exited(body):

	idle = true
	player_chase = false
	player = null
	
	
