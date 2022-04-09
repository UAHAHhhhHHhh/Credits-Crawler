extends KinematicBody2D

# Script variables
export var GRAVITY: float = 0.8			# Gravity variable (exported to inspector)
export var RUN_VELOCITY: float = 0.5 	# Horizontal velocity (exported to inspector)
export var JUMP_VELOCITY: float = 0.5	# Vertical velocity (exported to inspector)

var jumping: bool = false
var velocity: Vector2 = Vector2()

const FLOOR_NORMAL: Vector2 = Vector2(0, -1) # Direction of a floor

onready var SCREEN_WIDTH: float = get_viewport_rect().size.x

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	get_input()
	velocity.y += GRAVITY * delta
	velocity = move_and_slide(velocity, FLOOR_NORMAL)
	get_wrap()
	if jumping and is_on_floor():
		jumping = false

# Called when getting user input
func get_input():
	velocity.x = 0

	var right = Input.is_action_pressed("ui_right")
	var left = Input.is_action_pressed("ui_left")
	var jump = Input.is_action_pressed("ui_up")

	if right:
		velocity.x += RUN_VELOCITY
	if left:
		velocity.x -= RUN_VELOCITY
	if jump and is_on_floor():
		jumping = true
		velocity.y -= JUMP_VELOCITY

# Called when checking if we need to wrap
func get_wrap():
	# Check if we are off right side of screen
	if position.x > SCREEN_WIDTH:
		position.x = 1
	# Check if we are off left side of screen
	if position.x < 0:
		position.x = SCREEN_WIDTH-1
