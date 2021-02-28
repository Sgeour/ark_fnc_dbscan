// [_targets, _radius, _minPts] call ark_fnc_dbscan;
// Labels units with a cluster label and returns a HashMap of clusters. Units in cluster -1 are outliers.
// Returns: Cluster: [units]
ark_fnc_dbscan = { 
    params ["_targets", "_radius", "_minPts"]; 
    private _c = 0; 
    private _hashMap = createHashMap; 
    _hashMap set [-1, []];
    // reset 
    { 
        _x setVariable ["cluster", nil]; 
    } forEach _targets; 
 
    { 
        if (isNil {_x getVariable "cluster"}) then { 
            private _neighbours = [_targets, getPosATL _x, _radius] call ark_fnc_rangeQuery; 
            if ((count _neighbours) < _minPts) then { 
                _x setVariable ["cluster", -1]; 
                (_hashMap get -1) pushBack _x;
                // Altered implementation, we don't care for outliers 
            } else { 
                _c = _c + 1; 
                _hashMap set [_c, []]; 
                _x setVariable ["cluster", _c]; 
                (_hashMap get _c) pushBack _x; 
                private _seed = _neighbours; 
                { 
                    // If player has no cluster 
                    if (isNil {_x getVariable "cluster"}) then { 
                        _x setVariable ["cluster", _c]; 
                        (_hashMap get _c) pushBack _x; 
                        private _n = [_targets, getPosATL _x, _radius] call ark_fnc_rangeQuery; 
                        if (count _n >= _minPts) then { 
                            _seed = _seed arrayIntersect _n; 
                        }; 
                    } else { 
                        // Outliers join cluster 
                        if((_x getVariable "cluster") isEqualTo -1) then { 
                            _x setVariable ["cluster", _c];
                            _hashMap set [-1, (_hashMap get -1) - [_x]];
                            (_hashMap get _c) pushBack _x; 
                        }; 
                    }; 
                } forEach _seed;
            }; 
        }; 
    } forEach _targets; 
    _hashMap 
}; 

ark_fnc_rangeQuery = {
    params["_units", "_p", "_radius"];
    private _neighbours = [];
    {
        if (_p distance (getPosATL _x) < _radius) then { _neighbours pushBack _x };
    } forEach _units;
    _neighbours
};
