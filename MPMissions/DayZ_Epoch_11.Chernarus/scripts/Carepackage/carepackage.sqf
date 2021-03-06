// Carepackage script by Matt L
//Special thanks to Infinistar for helping with mag selection for the weapons

private ["_cost","_hasBriefs","_display","_distance","_boxtype","_unit","_getPos","_position","_box","_chute","_smoke","_var","_textt","_tools","_items","_walls","_supplies","_weapon","_weapon2","_weapon3","_weapon4","_weapon5","_weapon6","_giveWep","_possibleMags","_mag","_whichBuild","_crateItems","_text"];

_cost = 2;
_hasBriefs = {"ItemBriefCase100oz" == _x} count (magazines player);
_LastUsedTime = 100;

lastpack = time;
_Time = time - lastpack;


if(_Time < _LastUsedTime) exitWith { // If cooldown is not done then exit script
	cutText [format["please wait %1 before calling in another carepackage!",(round(_Time - _LastUsedTime))], "PLAIN DOWN"]; //display text at bottom center of screen when players cooldown is not done
};


if (_hasBriefs >= _cost) then {

for "_i" from 0 to _cost - 1 do {
player removeMagazine "ItemBriefcase100oz";
};

disableSerialization;
_display = findDisplay 24;
(_display) closeDisplay 0;

_distance = 500;
_boxtype = "USVehicleBox_EP1";
_unit = player;
_getPos = getPos _unit;
_position = [_getPos select 0, _getPos select 1, 25];
_box = _boxtype createVehicle _position;
_box setVariable ["Mission",1,true];
_box setVariable ["permaLoot",1,true];
_box setVariable ["ObjectID",""];
_chute = createVehicle ["ParachuteMediumEast", getPos _box, [], 0, "FLY"];
_box attachTo [_chute, [0,0,3]];
_smoke = "SmokeShellBlue" createVehicle (getPos _box);
_smoke attachTo [_box, [0,0,0]];
_var = floor((random 2) + 1);

lastpack = time;

//display text to alert user
_textt = format ["\nCarepackage is above you!",10];
titleText [_textt,"PLAIN DOWN"];

//define items

_tools = ["ItemEtool","ItemKnife","ItemGPS","ItemFishingPole","ItemHatchet_DZE","ItemMatchbox_DZE","ItemCrowbar"];
_items = ["ItemSodaPepsi","FoodCanCorn","FoodNutmix","ItemSodaClays","FoodCanSardines","ItemKiloHemp"];
_walls = ["ItemWoodWallGarageDoor","ItemWoodWallWithDoorLg","ItemWoodWallLg","ItemWoodWallGarageDoor","ItemWoodFloor","metal_floor_kit Z","CinderWallDoorSmall_DZ"];
_supplies = ["CinderBlocks","MortarBucket","ItemTankTrap","PartWoodPlywood","PartWoodLumber","ItemPole","PartGlass"];

//weapon lists
_weapon = "DMR";
_weapon2 = "AK_47_M";
_weapon3 = "BAF_L85A2_RIS_Holo";
_weapon4 = "RPK_74";
_weapon5 = "M14_EP1";
_weapon6 = "M249_DZ";
_giveWep = [_weapon,_weapon2,_weapon3,_weapon4,_weapon5,_weapon6] call BIS_fnc_selectRandom;
_possibleMags = getArray (configfile >> "cfgWeapons" >> _giveWep >> "magazines");
_mag = _possibleMags select 0;

//select arrays to use
_crateItems = [_walls,_supplies,_items] call BIS_fnc_selectRandom;
uisleep 1;

clearweaponcargoglobal _box;
clearmagazinecargoglobal _box;

uisleep 1;

{_box addMagazineCargoGlobal [_x, _var];} forEach _crateItems;
{_box addWeaponCargoGlobal [_x, 1];} forEach _tools;
_box addMagazineCargoGlobal [_mag, _var];
_box addWeaponCargoGlobal [_giveWep, 1];

uisleep 1;

waitUntil {(player distance _box) > _distance};
deleteVehicle _box;
deleteVehicle _chute;

} else {
_text = format ["\nYou need two full briefs to call a carepackage!",10];
titleText [_text,"PLAIN DOWN"];
};