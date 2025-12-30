## CropData - Crop Configuration Resource
##
## This resource defines the properties for a crop type (e.g., tomato, corn).
## Create instances of this resource in the Crops/ folder to add new crop types.
##
## Usage:
##   1. Create a new resource file (e.g., res://Crops/wheat.tres)
##   2. Set the class to CropData
##   3. Configure the exported properties in the inspector
##   4. Add the resource to GameManager.all_crop_data array
class_name CropData
extends Resource

## Array of textures representing each growth stage of the crop.
## Index 0 is the seed/sprout, last index is the fully grown crop.
## The number of sprites determines how many visual stages the crop has.
@export var growth_sprites : Array[Texture]

## Number of days required for the crop to fully mature (when watered daily).
## Default is 8 days.
@export var days_to_grow : int = 8

## Cost in dollars to purchase one seed of this crop type from the shop.
@export var seed_price : int = 10

## Money earned when harvesting one fully grown crop of this type.
@export var sell_price : int = 20
