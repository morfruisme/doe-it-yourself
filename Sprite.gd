extends KinematicBody2D

var velocity = Vector2()
var speed = 200
var gravity = 600
var jump_force = -400
onready var animation = $AnimationPlayer

func _physics_process(delta):
	velocity.x = 0  # Réinitialise la vitesse horizontale à chaque frame

	# Détecter les inputs pour les mouvements horizontaux
	if Input.is_action_pressed("ui_right"):
		$Sprite.flip_h = false
		animation.play("walking")
		velocity.x = 1 * speed
		print("Droite")
	elif Input.is_action_pressed("ui_left"):
		$Sprite.flip_h = true
		animation.play("walking")
		velocity.x = -1 * speed
		print("gauche")
	else : 
		velocity.x = 0
	
	# Appliquer la gravité
	velocity.y += gravity * delta

	# Détecter l'input pour le saut
	if Input.is_action_just_pressed("ui_up") and is_on_floor():
		velocity.y = jump_force

	# Déplacer le personnage
	velocity = move_and_slide(velocity, Vector2.UP)
