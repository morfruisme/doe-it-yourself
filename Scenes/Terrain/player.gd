extends Area2D

export (int) var speed = 200
export (int) var radius = 10

onready var terrain = get_node("../Terrain")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _process(delta):
	var dir = Vector2(0, 0)
	if (Input.is_action_pressed("ui_left")):
		dir.x = -1
	if (Input.is_action_pressed("ui_right")):
		dir.x = 1
	if (Input.is_action_pressed("ui_up")):
		dir.y = -1
	if (Input.is_action_pressed("ui_down")):
		dir.y = 1
	
	var dp = delta*speed*dir
	
	# eau
	var cell = terrain.world_to_map(position + Vector2(dp.x, 0))
	if terrain.get_cellv(cell) != 2:
		position.x += dp.x
	cell = terrain.world_to_map(position + Vector2(0, dp.y))
	if terrain.get_cellv(cell) != 2:
		position.y += dp.y
