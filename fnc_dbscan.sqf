
// [units, eps, minPts, markers] call fnc_dbscan;
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
    // DEBUG
    if(_markers) then {
        [_units] call fnc_markers;
    };
};

fnc_range_query = {
    params["_units", "_p", "_eps"];
    private _neighbours = [];
    {
        if(_p distance (_x # 1) < _eps) then { _neighbours pushBack _x };
    } forEach _units;
    _neighbours
};

fnc_markers = {
    params["_units"];
    {
        private _name = format["%1_marker", name (_x # 0)];
        deleteMarker _name;
        [_x] call fnc_add_marker;
    } forEach _units;
};

fnc_add_marker = {
    params["_unit"];
    private _colors = ["ColorRed", "ColorBlue", "ColorGreen","ColorYellow","ColorWhite","ColorPink","ColorKhaki", "ColorOrange", "ColorBrown","ColorYellow"];
    private _name = format["%1_marker", name (_unit # 0)];
    // Create marker
    createMarker [_name, _unit # 1];
    if (_unit # 2 isEqualTo -1) then {
        _name setMarkerColor "ColorBlack";
        _name setMarkerText "";
        _name setMarkerType "mil_triangle";
    } else {
        _name setMarkerColor (_colors # ((_unit # 2) mod (count _colors)));
        _name setMarkerText format["%1", _unit # 2];
        _name setMarkerType "mil_dot";
    };
};
