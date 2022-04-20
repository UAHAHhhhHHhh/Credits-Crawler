extends KinematicBody2D

# Script variables
export var GRAVITY: float = 0.8			# Gravity variable (exported to inspector)
export var RUN_VELOCITY: float = 0.5 	# Horizontal velocity (exported to inspector)
export var JUMP_VELOCITY: float = 0.5	# Vertical velocity (exported to inspector)

var jumping: bool = false
var velocity: Vector2 = Vector2()

const FLOOR_NORMAL: Vector2 = Vector2(0, -1) # Direction of a floor

onready var SCREEN_WIDTH: float = get_viewport_rect().size.x	# Viewport width
onready var SCREEN_HEIGHT: float = get_viewport_rect().size.y	# Viewport height

onready var global = get_node("/root/Game")

var scrolling: bool
var credits
var camera

# Called when the node enters the scene tree for the first time.
func _ready():
	credits = get_node("/root/Game/CreditsLevel")
	camera = credits.get_child(1)
	camera.connect("scrolling", self, "_scrolling")
	scrolling = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	get_input()								# Move based on input
	velocity.y += GRAVITY * delta			# Apply accel. gravity
	velocity = move_and_slide(velocity, FLOOR_NORMAL)	# Move player
	chk_wrap()								# See if we need to wrap character around screen
	chk_outside_scroll()

	# See if we landed back on the floor
	if jumping and is_on_floor():
		jumping = false

# Called when getting user input
func get_input():
	velocity.x = 0

	# Get which button was pressed
	var right = Input.is_action_pressed("ui_right")
	var left = Input.is_action_pressed("ui_left")
	var jump = Input.is_action_pressed("ui_up")

	# Move right
	if right:
		velocity.x += RUN_VELOCITY
	# Move left
	if left:
		velocity.x -= RUN_VELOCITY
	# Jump (only jump if we were on the floor)
	if jump and is_on_floor():
		jumping = true
		velocity.y -= JUMP_VELOCITY

# Called when checking if we need to wrap
func chk_wrap():
	## NOTE: 	position is an inbuilt property 
	## 			of the KinematicBody2D object

	# Check if we are off right side of screen
	if position.x > SCREEN_WIDTH:
		position.x = 1
	# Check if we are off left side of screen
	if position.x < 0:
		position.x = SCREEN_WIDTH-1

# Called when checking if character is outside the scroll
func chk_outside_scroll():
	## NOTE:	position is an inbuilt property
	##			of the KinematicBody2D object

	# Get the current position of the scroll camera
	var camera_y = camera.position.y
	var upper = camera_y - (SCREEN_HEIGHT / 2)
	var lower = camera_y + (SCREEN_HEIGHT / 2)

	# Only check this if we are scrolling
	if scrolling:
		# Check if we are outside the camera
		if (position.y < upper) or (position.y > lower):
			print("dead")
			global.end()

# Called when scrolling signal emitted from ScrollCamera
func _scrolling():
	print("scrolling")
	scrolling = true
	
	
