# ark_fnc_dbscan.sqf

This sqf function performs [Density-based spatial clustering of applications with noise](https://en.wikipedia.org/wiki/DBSCAN) (DBSCAN). 

## Usage

To use this function call `private _result = [units, eps, minPts] call ark_fnc_dbscan;`

| Argument | Type |Description |
|-|-|-|
| `units` | array\<object\> | The array of objects you wish to pass to the clustering algorithm.
| `eps` | number | The radius used in checking for `minPts` |
| `minPts` | number | The minimum number of neighbours required to be considered a cluster |


Returns a list of lists in the form `[object, positionATL, label]`. `Label` is the label of the cluster the object belongs to. If `label` is `-1`, then object is an outlier. 