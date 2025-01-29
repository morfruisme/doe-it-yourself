extends TileMap

var size = 500

# Called when the node enters the scene tree for the first time.
func _ready():
	for x in range(size):
		for y in range(size):
			set_cell(x, y, 0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
