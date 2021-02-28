# ark_fnc_dbscan.sqf

This sqf function performs [Density-based spatial clustering of applications with noise](https://en.wikipedia.org/wiki/DBSCAN) (DBSCAN). 

## Usage

To use this function call `private _result = [units, radius, minPts] call ark_fnc_dbscan;`

| Argument | Type |Description |
|-|-|-|
| `units` | array\<object\> | The array of objects you wish to pass to the clustering algorithm.
| `radius` | number | The radius used in checking for `minPts` |
| `minPts` | number | The minimum number of neighbours required to be considered a cluster |


Returns a HashMap where each key/value pair is a cluster and list of units belonging to the cluster.
Also sets a "cluster" label variable on units locally to where script is run.

Key `-1` contains all outliers.

```
    [
        [1,[B Alpha 1-1:9,B Alpha 1-1:10,B Alpha 1-1:11,B Alpha 1-2:1,C Alpha 1-1:1,C Alpha 1-1:2]],
        [3,[B Alpha 1-4:10,B Alpha 1-4:11,C Alpha 1-4:1,C Alpha 1-4:2]],
        [2,[B Alpha 1-3:10,B Alpha 1-3:11]],
        [4,[B Alpha 1-5:10,B Alpha 1-5:11]],
        [-1,[C Alpha 1-2:1,C Alpha 1-2:2]]
    ]
```

To get the cluster label for a particular unit:
```
    _unit getVariable "cluster"
```