extends TileMap

var size = 500

onready var player = get_node("../Player")

# setup des cases par défaut
# idéalement instancier les décors ici
func _ready():
	for x in range(size):
		for y in range(size):
			if get_cell(x, y) == -1: # not set
				set_cell(x, y, 0)


func _process(delta):
	var cell = world_to_map(player.position)
	#print("x: ", cell.x, ", y: ", cell.y)
	for v in adjacent_cells(cell.x, cell.y, player.radius):
		if get_cellv(v) == 0:
			set_cellv(v, 1)

func adjacent_cells(x, y, r):
	var adj = []
	for i in range(-r, r):
		for j in range(-r, r):
			if i*i + j*j < r*r:
				adj.append(Vector2(x+i, y+j))
	return adj

func gen_path(start, angle, n):
	var path = [start]
	var c = start
	
	for i in range(n):
		var step = 100*randf()
		var a = angle*(1 - 2*randf())
		var next = step*Vector2(cos(a), sin(a)) + c
		path.append(next)
		c = next
		
	return path
