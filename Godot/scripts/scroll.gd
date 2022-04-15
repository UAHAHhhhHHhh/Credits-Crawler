extends Camera2D

## Declare script variables

export var MAX_SCROLL: float = 200

var TILE_SIZE: float 	= 32
var TOTAL_SCROLL: float

# Called when the node enters the scene tree for the first time.
func _ready():
	make_current()	# Make this the main camera
	print_debug(position.x)
	TOTAL_SCROLL = MAX_SCROLL * TILE_SIZE


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Make sure we stop scrolling at some point
	if position.y < TOTAL_SCROLL:
		position.y += 1
