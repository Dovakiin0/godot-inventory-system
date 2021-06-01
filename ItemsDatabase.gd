extends Node

var Items : Dictionary

func _ready():
	var file = File.new()
	file.open("res://items.json", File.READ)
	var json = JSON.parse(file.get_as_text())
	file.close()
	Items =  json.result
