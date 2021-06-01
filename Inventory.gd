extends Resource
class_name Inventory

var drag_data = null

signal items_changed(indexes)

export (Array) var items = [
	null, null, null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null
]

export (Array) var hotbar_items = [
	null,
	null,
	null,
	null,
	null,
	null,
	null,
	null,
	null
]

func set_item(item_index, item):
	var previousItem = items[item_index]
	items[item_index] = item
	emit_signal("items_changed", [item_index])
	return previousItem
	
func swap_item(item_index, target_item_index):
	var target_item = items[target_item_index]
	var item = items[item_index]
	items[target_item_index] = item
	items[item_index] = target_item
	emit_signal("items_changed", [item_index, target_item_index]) 
	
func remove_item(item_index):
	var previousItem = items[item_index]
	items[item_index] = null
	emit_signal("items_changed", [item_index])
	return previousItem
	
func make_items_unique():
	var unique = []
	for item in items:
		if item != null:
			unique.append(item.duplicate())
		else:
			unique.append(null)
	items = unique
