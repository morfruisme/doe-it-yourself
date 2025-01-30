extends Node2D



var pos_offset = Vector2(0, 200)
var speed = 5
var radius = 5

onready var kbody = $KinematicBody2D
onready var animation = $KinematicBody2D/AnimationPlayer
onready var sprite = $KinematicBody2D/Sprite



func _ready():
	pass



func _physics_process(delta):
	# Réinitialise la vitesse horizontale et verticale à chaque frame
	var dir = Vector2(0, 0)

	# Détecter les inputs pour les mouvements horizontaux et verticaux
	if Input.is_action_pressed("ui_right"):
		dir.x = 1
		animation.play("walking")
		sprite.flip_h = false  # Face à droite
	elif Input.is_action_pressed("ui_left"):
		dir.x = -1
		animation.play("walking")
		sprite.flip_h = true  # Face à gauche
	if Input.is_action_pressed("ui_up"):
		dir.y = -1
		animation.play("walking_up")  # Animation spécifique pour monter
	elif Input.is_action_pressed("ui_down"):
		dir.y = 1
		animation.play("walking_down")  # Animation spécifique pour descendre

	# Déplacer le personnage
	kbody.move_and_collide(speed*dir.normalized())
