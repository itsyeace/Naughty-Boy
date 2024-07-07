extends KinematicBody2D

export(float) var move_speed = 400
export(float) var jump_impulse = 800
export(float) var gravity = 400
export(int) var max_jumps = 1

enum STATE { IDLE, RUN, JUMP, SLIDE }

onready var animated_sprite = $AnimatedSprite
onready var animation_player = $AnimationPlayer

var velocity : Vector2

var current_state = STATE.IDLE setget set_current_state
var jumps = 0

func _physics_process(delta):
	var input = get_player_input()
	adjust_flip_direction(input)
	
	velocity = Vector2(
		input.x * move_speed,
		min(velocity.y + GameSettings.gravity, GameSettings.terminal_velocity)
	)
		
	velocity = move_and_slide(velocity, Vector2.UP)
	
	pick_next_state()
	
func adjust_flip_direction(input : Vector2):
	if(sign(input.x) == 1):
		animated_sprite.flip_h = false
	elif(sign(input.x) == -1):
		animated_sprite.flip_h = true
	

func die():
	emit_signal("player_died", self)
	queue_free()

func pick_next_state():
	if(is_on_floor()):
	 jumps = 0
	
	if(Input.is_action_just_pressed("jump") && jumps < max_jumps):
		 self.current_state = STATE.JUMP
		 $AnimationPlayer.play("jump")
	elif(abs(velocity.x) > 0):
		 self.current_state = STATE.RUN
		 $AnimationPlayer.play("run")
	else:
		 self.current_state = STATE.IDLE
		 $AnimationPlayer.play("idle")
	
func get_player_input():
	var input : Vector2
	
	input.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	
	return input
	
func jump():
	velocity.y = -jump_impulse
	jumps += 1
	
func set_current_state(new_state):
	match(new_state):
		STATE.JUMP:
			jump()

func _on_DeadZone_body_entered(body):
	if body.get_name() == "Player":
		get_tree().change_scene("res://Level(Scene)/background.tscn")
