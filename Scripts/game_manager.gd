extends Node

signal NewDay(day : int)
signal SetPlayerTool(tool : PlayerTools.Tool, seed: CropData)
signal HarvestCrop(crop : Crop)
signal ChangeSeedQuantity(crop_data: CropData, quantity : int)
signal ChangeMoney(money : int)

var day : int = 1
var money : int = 0

var all_crop_data : Array[CropData] = [
	preload("res://Crops/tomato.tres"),
	preload("res://Crops/corn.tres"),
]

var owned_seeds : Dictionary[CropData, int]

func _ready():
	pass

func set_next_day():
	pass

func harvest_crop(crop : Crop):
	pass

func try_buy_seed(crop_data: CropData):
	pass

func consume_seed(crop_data : CropData):
	pass

func give_money(amount : int):
	pass
