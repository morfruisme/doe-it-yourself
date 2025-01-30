extends Control


func _ready():
	$Doe/AnimationPlayer.play("starting")
	$VBoxContainer/Start.connect("pressed", self, "_on_StartButton_pressed")
	$VBoxContainer2/QUIT.connect("pressed", self, "_on_QuitButton_pressed")

func _on_StartButton_pressed():
	# Charger et démarrer la scène du jeu
	get_tree().change_scene("res://Scenes/Main/Main.tscn")

func _on_QuitButton_pressed():
	# Quitter le jeu
	get_tree().quit()
