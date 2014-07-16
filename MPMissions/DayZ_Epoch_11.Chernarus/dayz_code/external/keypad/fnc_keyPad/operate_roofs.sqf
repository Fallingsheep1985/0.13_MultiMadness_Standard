private ["_isBuildable","_charPos","_character","_id","_pos","_z","_nearestGates","_inMotion","_lever","_text"];
_character = _this select 1;
_id = _this select 2;
_lever = _this select 3;
_isBuildable = true;
_charPos = getposATL _character;
_inMotion = _lever getVariable ["inMotion",0];
_lever removeAction _id;
_nearestGates = nearestObjects [_lever, ["Land_Ind_Shed_01_main","Land_Ind_Shed_01_end","Land_Ind_SawMillPen"], BBFlagRadius];
//dayz_updateNearbyObjects = [_charPos, _isBuildable];
//publicVariableServer "dayz_updateNearbyObjects";
//	if (isServer) then {
//		dayz_updateNearbyObjects call server_updateNearbyObjects;
//	};

//[_charPos, _isBuildable] call server_updateNearbyObjects;
if (typeOf(_lever) == "Infostand_2_EP1") then {
	if (_inMotion == 0) then {

		_lever setVariable ["inMotion", 1, true];
		
		{
			//_pos = getPosATL _x; // changed from getpos
			//_z = _pos select 2;
			_gateLowered = _x getVariable ["RoofLowered", false];
			//if (_z <= -2) then {
			if (_gateLowered) then {
				_text = "All Roofs";
				cutText [format["Raising the %1",_text], "PLAIN DOWN"];
				//_pos set [2,0];
				//_x setPos _pos;
				
				_posATL =  getPosATL _x; 						
				_z = _posATL select 2;
				_z = _z+10;   
				_posATL set [2,_z];
				_x setPosATL _posATL;
				
				
				[nil,_x,rSAY,["trap_bear_0",60]] call RE;
				sleep .5;
				[nil,_x,rSAY,["trap_bear_0",60]] call RE;
				_x setVariable ["RoofLowered", false, true];
			} else {
				_text = "All Roofs";
				cutText [format["Lowering the %1",_text], "PLAIN DOWN"];
				
				_posATL =  getPosATL _x; 						
				_z = _posATL select 2;
				_z = _z-10;   
				_posATL set [2,_z];
				_x setPosATL _posATL;
				[nil,_x,rSAY,["trap_bear_0",60]] call RE;
				_x setVariable ["RoofLowered", true, true];
			};
			
			sleep 1;
			
		} foreach _nearestGates;
		_lever setVariable ["inMotion", 0, true];
	};
};
//The Fence_corrugated_plate is now its own single gate and not tied to a panel