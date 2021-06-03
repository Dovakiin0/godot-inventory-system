extends Panel

var ItemClass = preload("res://Item.tscn")
var item = null
var slot_index
var slot_type
enum SlotType {
	HOTBAR = 0,
	INVENTORY,
	HEAD,
	BODY,
	LEGS
}

var selected_texture = preload("res://Assets/UI/SlotsActive.png")
var default_texture = preload("res://Assets/UI/Slots.png")

var selected_style : StyleBoxTexture = null
var default_style : StyleBoxTexture = null

func _ready():
	selected_style = StyleBoxTexture.new()
	default_style = StyleBoxTexture.new()
	selected_style.texture = selected_texture
	default_style.texture = default_texture
	refresh_style()

func refresh_style():
	if SlotType.HOTBAR == slot_type and PlayerInventory.active_item == slot_index:
		set("custom_styles/panel", selected_style)
	else:
		set("custom_styles/panel", default_style)
		

func pickFromSlot():
	remove_child(item)
	var inventoryNode = find_parent("UserInterface")
	inventoryNode.add_child(item)
	item = null
	
func putIntoSlot(new_item):
	item = new_item
	item.position = Vector2(0,0)
	var inventoryNode = find_parent("UserInterface")
	inventoryNode.remove_child(item)
	add_child(item)

func initialize_item(item_name, item_quantity):
	if item == null:
		item = ItemClass.instance()
		add_child(item)
		item.set_item(item_name, item_quantity)
	else:
		item.set_item(item_name, item_quantity)
