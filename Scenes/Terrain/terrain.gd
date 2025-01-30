extends Node2D



var size = 500
var score = 0

# type des cases
enum Case { VIDE=-1, TERRE=0, HERBE=1, EAU=2 }

onready var t = $TileMap
onready var player = get_node_or_null("Player")
onready var score_label = get_node_or_null("Score")



# setup des cases par défaut
func _ready():
	for x in range(-size, size):
		for y in range(-size, size):
			if t.get_cell(x, y) == Case.VIDE:
				t.set_cell(x, y, Case.TERRE)



func _process(delta):
	if player == null:
		return
	
	var p = player.get_node("KinematicBody2D").position
	var cell = cell_from_position(p)
	#print("x: ", cell.x, ", y: ", cell.y)
	
	var dscore = 0
	for v in adjacent_cells(cell.x, cell.y, player.radius):
		if t.get_cellv(v) == Case.TERRE:
			t.set_cellv(v, Case.HERBE)
			dscore += 1
	score += dscore



# case sur la position
func cell_from_position(p):
	return t.world_to_map(p/t.scale)

# cases dans le rayon (euclidien)
func adjacent_cells(x, y, r):
	var adj = []
	for i in range(-r, r):
		for j in range(-r, r):
			if i*i + j*j < r*r:
				adj.append(Vector2(x+i, y+j))
	return adj



# pas utilisée
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
