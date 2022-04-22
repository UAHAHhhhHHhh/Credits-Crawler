extends KinematicBody2D

# Script variables
export var GRAVITY: float = 0.5			# Gravity variable (exported to inspector)
export var SPEED: float = 0.25 			# Horizontal velocity (exported to inspector)
export var AMPLITUDE: float = 0.4		# Amplitude for sine motion (exported to inspector)

var velocity: Vector2 = Vector2()

const FLOOR_NORMAL: Vector2 = Vector2(0, -1) # Direction of a floor

onready var SCREEN_HEIGHT: float = get_viewport_rect().size.y	# Viewport height

onready var left_platform = $LeftFloor
onready var right_platform = $RightFloor

onready var global = get_node("/root/Game")

var credits
var camera
var initial_x: float

# Called when the node enters the scene tree for the first time.
func _ready():
	credits = get_node("/root/Game/CreditsLevel")
	camera = credits.get_child(1)
	velocity.x = SPEED
	initial_x = position.x

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	walk()
	velocity.y += GRAVITY * delta
	velocity.y = move_and_slide(velocity, FLOOR_NORMAL).y
	check_off_screen()
	# check_collision()
	
# Called when processing sinusoidal movement
func walk():
	var pos = position.x
	var right = initial_x + AMPLITUDE
	var left = initial_x - AMPLITUDE

	# Only do this while we're on the floor or 
	if (not left_platform.is_colliding()) or (pos <= left):
		# print("right")
		velocity.x = SPEED
	elif (not right_platform.is_colliding()) or (pos >= right):
		# print("left")
		velocity.x = -SPEED

# Called when checking if the character is off the screen
func check_off_screen():
	var upper = camera.position.y - (SCREEN_HEIGHT / 2)

	if position.y < upper:
		print("deleted")
		queue_free()

# Called to check collisions
# func check_collision():
# 	for idx in get_slide_count():
# 		var body = get_slide_collision(idx).collider
# 		if body.get_collision_layer() == 1:
# 			global.end()
