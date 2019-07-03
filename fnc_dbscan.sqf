
// [units, eps, minPts, markers] call fnc_dbscan;
// returns a list of units, their positions and their label
fnc_dbscan = {
    params["_targets", "_eps", "_minPts", "_markers"];
    private _units = [];
    {
        _units pushBack ([_x, getPosATL _x, nil]);
    } forEach _targets;
    private _c = 0;
    {
        if (!isNil {_x # 2}) then {
        } else {
            private _neighbours = [_units, _x # 1, _eps] call fnc_range_query;
            if ((count _neighbours) < _minPts) then {
                _x set[2, -1];
            } else {
                _c = _c + 1;
                _x set[2, _c];

                private _seed = _neighbours;
                {
                    if (_x # 2 isEqualTo -1) then {
                        _x set [2, _c];
                    };
                    if (!isNil {_x # 2}) then {
                    } else {
                        _x set[2, _c];
                        private _n = [_units, _x # 1, _eps] call fnc_range_query;
                        if(count _n >= _minPts) then {
                            _seed = _seed arrayIntersect _n;
                        };
                    };
                } forEach _seed;
            };
        };
    } forEach _units;

    _units
};

fnc_range_query = {
    params["_units", "_p", "_eps"];
    private _neighbours = [];
    {
        if(_p distance (_x # 1) < _eps) then { _neighbours pushBack _x };
    } forEach _units;
    _neighbours
};
