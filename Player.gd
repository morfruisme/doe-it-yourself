extends KinematicBody2D

var velocity = Vector2()
var speed = 200
var gravity = 600
var jump_force = -400
onready var animation = $AnimationPlayer
onready var circle_effect = null  # Pour ajouter le cercle

func _ready():
	# Connecter le signal de détection de collision pour tous les nœuds Area2D enfants
	for child in get_children():
		if child is Area2D:
			child.connect("body_entered", self, "_on_Area2D_body_entered")

func _on_Area2D_body_entered(body):
	if body.name == "Coin":
		body.queue_free()  # Supprime la pièce
		create_circle_effect()

func create_circle_effect():
	# Créer un effet de cercle autour de la biche
	if circle_effect == null:
		circle_effect = Sprite.new()
		circle_effect.texture = load("res://Extra/glowCircle.png")
		add_child(circle_effect)
		circle_effect.position = Vector2(0, 0)  # Positionner autour de la biche

func _physics_process(delta):
	# Réinitialise la vitesse horizontale à chaque frame
	velocity.x = 0

	# Détecter les inputs pour les mouvements horizontaux
	if Input.is_action_pressed("ui_right"):
		animation.play("walking")
		$Sprite.flip_h = false
		velocity.x = speed
		print("Droite")
	elif Input.is_action_pressed("ui_left"):
		animation.play("walking")
		$Sprite.flip_h = true
		velocity.x = -speed
		print("gauche")
	else:
		animation.play("RESET")

	# Appliquer la gravité
	velocity.y += gravity * delta

	# Détecter l'input pour le saut
	if Input.is_action_just_pressed("ui_up") and is_on_floor():
		velocity.y = jump_force

	# Déplacer le personnage
	velocity = move_and_slide(velocity, Vector2.UP)
