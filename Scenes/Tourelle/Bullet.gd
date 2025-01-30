extends Area2D

export var speed := 300  # Speed of the bullet
var direction := Vector2.ZERO  # Direction the bullet moves in

func _process(delta):
	position += direction * speed * delta  # Move the bullet

# Delete the bullet if it leaves the screen
func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

# If the bullet hits something, destroy it
func _on_Bullet_body_entered(body):
	queue_free()
