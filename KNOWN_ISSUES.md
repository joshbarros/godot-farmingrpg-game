# Known Issues

## Crops Not Growing

**Status:** Fixed

**Description:** Planted crops do not grow when advancing days.

**Cause:** The `Crop` class has an `_on_new_day()` function that handles growth logic, but it was not connected to the `GameManager.NewDay` signal. The function existed but never got called.

**Location:** `Scripts/crop.gd:12`

**Fix Applied:** Connected the crop's `_on_new_day` method to `GameManager.NewDay` signal in `crop.gd`'s `_ready()` function:

```gdscript
func _ready():
    if GameManager:
        GameManager.NewDay.connect(_on_new_day)
```
