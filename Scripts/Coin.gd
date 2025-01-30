extends Area2D

func _ready():
	connect("body_entered", self, "_on_body_entered")

func _on_body_entered(body):
	if body is KinematicBody2D:
		queue_free()  # Supprime la pièce
		body.create_circle_effect()
