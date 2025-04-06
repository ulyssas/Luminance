extends RefCounted
class_name MeasureData

var bpm: float
var notes: Array[DivisionData]

# コンストラクタ
func _init(
    bpm: float,
    notes: Array[DivisionData]
):
    self.bpm = bpm
    self.notes = notes
