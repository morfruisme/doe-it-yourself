extends Area2D

export (int) var speed = 200
export (int) var radius = 10

onready var terrain = get_node("../Terrain")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var dir = Vector2(0.0, 0.0)
	if (Input.is_action_pressed("ui_left")):
		dir.x = -1
	if (Input.is_action_pressed("ui_right")):
		dir.x = 1
	if (Input.is_action_pressed("ui_up")):
		dir.y = -1
	if (Input.is_action_pressed("ui_down")):
		dir.y = 1
	
	position += delta*speed*dir

	var cell = terrain.world_to_map(position)
	#print("x: ", cell.x, ", y: ", cell.y)
	for v in adjacent_cells(cell.x, cell.y, radius):
		terrain.set_cellv(v, 1)

func adjacent_cells(x, y, r):
	var adj = []
	var n = 2*r
	var s = terrain.cell_size.x
	for i in range(-r, r):
		for j in range(-r, r):
			if i*i + j*j < r*r:
				adj.append(Vector2(x+i, y+j))
	return adj
