extends CharacterBody2D

var speed = 50;
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
	var parent_node = get_parent()
	if parent_node is PathFollow2D:
		get_parent().progress += speed * delta

## eel detection area signal functions
func _on_detection_area_body_entered(body):
	player = body
	idle = false
	player_chase = true;
	## detect_player_sound.play()
		

func _on_detection_area_body_exited(body):

	idle = true
	player_chase = false
	player = null
	
	
