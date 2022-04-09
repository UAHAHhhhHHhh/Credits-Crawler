extends Camera2D

## Declare script variables

export var MAX_SCROLL: float = 200

# Called when the node enters the scene tree for the first time.
func _ready():
	make_current()	# Make this the main camera
	print_debug(position.x)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Make sure we stop scrolling at some point
	if position.y < MAX_SCROLL:
		position.y += 1
