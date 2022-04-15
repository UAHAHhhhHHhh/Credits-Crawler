extends Camera2D

## Declare script variables

export var MAX_SCROLL: float 	= 200	# Maximum scroll value (exported to editor)
export var START_SCROLL: float	= 15	# Threshold to start scrolling (exported to editor)
export var SCROLL_SPEED: float	= 1		# Speed to scroll at (exported to editor)

var TILE_SIZE: float 	= 32			# Tile size (used to calculate scroll)
var TOTAL_SCROLL: float					# The total scrolling value (MAX_SCROLL * TILE_SIZE)
var SCROLLING_START: float				# Value to start scolling (START_SCROLL * TILE_SIZE)
var SPEED: float						# Speed of scrolling (SCROLL_SPEED * TILE_SIZE)

signal scrolling
onready var scroll_emitted: bool = false

# Reference to player object (to track it's position)
onready var player = get_node("/root/Game/Player")

# Called when the node enters the scene tree for the first time.
func _ready():
	make_current()	# Make this the main camera
	print_debug(position.x)
	TOTAL_SCROLL = MAX_SCROLL * TILE_SIZE
	SCROLLING_START = START_SCROLL * TILE_SIZE
	SPEED = SCROLL_SPEED * TILE_SIZE


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Only start scrolling after the player has gone below
	# a certain threshold
	if player.position.y > SCROLLING_START:
		if scroll_emitted == false:
			emit_signal("scrolling")
			scroll_emitted = true
		# Make sure we stop scrolling at some point
		if position.y < TOTAL_SCROLL:
			position.y += SPEED
