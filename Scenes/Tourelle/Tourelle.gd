extends Node2D

export var fire_rate := 1.5  # Time between shots and rotations (matches animation duration)
export (PackedScene) var bullet_scene  # Assign `Bullet.tscn` in the Inspector

onready var animation_player := $AnimationPlayer

var directions := ["right", "down", "left", "up"]  # Ordered cycle of directions
var current_index := 0  # Keeps track of current direction

func _ready():
	start_rotation_cycle()

func start_rotation_cycle():
	rotate_and_shoot()  # Start immediately
	var timer = Timer.new()
	timer.wait_time = fire_rate  # Set delay to match animation time
	timer.autostart = true
	timer.connect("timeout", self, "_on_Timer_timeout")
	add_child(timer)  # Add timer to turret

func _on_Timer_timeout():
	rotate_and_shoot()  # Rotate and fire bullet

func rotate_and_shoot():
	var new_direction = directions[current_index]  # Get next direction
	animation_player.play(new_direction)  # Play animation

	shoot_bullet(new_direction)  # Fire a bullet in this direction

	current_index = (current_index + 1) % directions.size()  # Loop to next direction

func shoot_bullet(direction):
	if not bullet_scene:
		return  # Prevents errors if no scene is assigned

	var bullet = bullet_scene.instance()  # Create bullet instance
	get_parent().add_child(bullet)  # Add to the scene

	bullet.global_position = global_position  # Spawn at turret's position

	# Set movement direction based on turret's current direction
	match direction:
		"right":
			bullet.direction = Vector2.RIGHT
		"left":
			bullet.direction = Vector2.LEFT
		"up":
			bullet.direction = Vector2.UP
		"down":
			bullet.direction = Vector2.DOWN
