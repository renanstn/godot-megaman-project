extends KinematicBody2D

const UP = Vector2(0, -1)
const GRAVITY = 12
const SPEED = 200

var motion = Vector2()
var shooting = false
var current_animation = ""
var animation = "idle"
var moving = false

func _physics_process(delta):
	
	motion.y += GRAVITY
	
	# Fly
	if Input.is_action_pressed("ui_up"):
		motion.y = -200
		animation = "flying"
	
	# Shoot
	if Input.is_action_pressed("ui_select") and is_on_floor():
		animation = "shooting"
		shooting = true
	else:
		shooting = false
	
	# Left / Rigth
	if Input.is_action_pressed("ui_left"):
		animation = "flying"
		moving = true
		$Sprite.set_scale(Vector2(1,1))
		motion.x = -SPEED
		
	elif Input.is_action_pressed("ui_right"):
		moving = true
		animation = "flying"
		$Sprite.set_scale(Vector2(-1,1))
		motion.x = SPEED
		
	else:
		motion.x = 0
		moving = false
	
	if is_on_floor() and !shooting and !moving:
		animation = "idle"
	elif !is_on_floor() and !Input.is_action_pressed("ui_up"):
		animation = "falling"
		
	if animation != current_animation:
		current_animation = animation
		$AnimationPlayer.play(animation)
	
	motion = move_and_slide(motion, UP)