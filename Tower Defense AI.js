//Returns a Random Number
var randomNumber = function(highestNum) {
	return Math.floor((Math.random() * highestNum) + 1)
}

//Uses a random number 1-4 to return a move object that is around the x/y location passed
var randomBuildingPosition = function(varX,varY) {
	var fourPositions = randomNumber(4);
	if (fourPositions == 1) {	
		return {x: varX - 4, y: varY}; //Left
	} else if (fourPositions == 2) {
		return {x: varX + 3, y: varY}; //Right
	} else if (fourPositions == 3) {
		return {x: varX, y: varY - 4}; //Top
	} else if (fourPositions == 4) {
		return {x: varX, y: varY + 3}; //Bottom
	}
}

// get my own player number; we need this to check if a unit is mine or not
var myPlayerNumber = scope.getMyPlayerNumber();
// get my team number; we can compare this to a units team number to check if its allied or not
var myTeamNumber = scope.getMyTeamNumber();
// get my gold value
var gold = scope.getGold();
// get several units
var idleWorkers = scope.getUnits({type: "Worker", player: myPlayerNumber, order: "Stop"});
var workers = scope.getUnits({type: "Worker", player: myPlayerNumber});
//Returns workers who are mining to prevent a worker who is building a tower to be sent to the next tower prior to completing theirs
var miningWorkers = scope.getUnits({type: "Worker", player: myPlayerNumber, order: "Mine"});
var fightingUnits = scope.getUnits({notOfType: "Worker", player: myPlayerNumber});
var castles = scope.getBuildings({type: "Castle", player: myPlayerNumber});
var barracks = scope.getBuildings({type: "Barracks", player: myPlayerNumber});
var houses = scope.getBuildings({type: "House", player: myPlayerNumber});
//Including teammates towers
var towers = scope.getBuildings({type: "Watchtower", team: myTeamNumber});
var finishedHouses = scope.getBuildings({type: "House", player: myPlayerNumber, onlyFinshed: true});
var finishedBarracks = scope.getBuildings({type: "Barracks", player: myPlayerNumber, onlyFinshed: true});
var mines = scope.getBuildings({type: "Goldmine"});
var enemyUnits = scope.getUnits({enemyOf: myPlayerNumber});

var nearestMineFromCastle = null;
var nearestMineDistanceFromCastle = 99999;

// look for the next gold mine from our castle (slightly modified from default still will not look for another mine after the first is depleted)
if (castles.length >= 1) {
	for (var i = 0; i < mines.length; i++) {
		var mine = mines[i];
		var dist = Math.pow(mine.getX() - castles[0].getX(), 2) + Math.pow(mine.getY() - castles[0].getY(), 2);
		if (dist < nearestMineDistanceFromCastle) {
			nearestMineFromCastle = mine;
			nearestMineDistanceFromCastle = dist;
		}
	}
}

// order all idle workers to mine from the nearest gold mine
if (nearestMineFromCastle && idleWorkers.length > 0) {
	scope.order("Mine", idleWorkers, {unit: nearestMineFromCastle});
}

// if the castle is idle, order to make a worker
if (castles.length >= 1 && !castles[0].getUnitTypeNameInProductionQueAt(1) && workers.length < 10) {
	scope.order("Train Worker", [castles[0]]);
}
 
// if any enemy units in sight and we have fighting units, order them to attack them
if (enemyUnits.length > 0 && fightingUnits.length > 0) {
	scope.order("AMove", fightingUnits, scope.getCenterOfUnits(enemyUnits));
}

// if we dont have a single house, make one
if (castles.length >= 1 && houses.length == 0) {
	//Added randomBuildingPosition around castle
	scope.order("Build House", workers, randomBuildingPosition(castles[0].getX(),castles[0].getY()));
}
 
// if we have at least one finished house (= we can make barracks), make a barracks (at some fixed position left of out castle, which will lead to some problems; you shouldnt do it like that)
if (castles.length >= 1 && finishedHouses.length > 0 && barracks.length == 0) {
	//Added randomBuildingPosition around castle
	scope.order("Build Barracks", workers, randomBuildingPosition(castles[0].getX(),castles[0].getY()));
}
 
//Trains 5 soldiers
if (finishedBarracks.length > 0  && fightingUnits.length < 5) {
	scope.order("Train Soldier", [barracks[0]]);
}
 
//Checks to see if passed x/y is near a tower returns true/false based on if the x/y is within a distance of 20
var nearTower = function(x,y) {	
	var nearestTower = null;
	var nearestTowerDistance = 99999;
	for (var i = 0; i < towers.length; i++) {
		var tower = towers[i];
		var towerDistance = Math.pow(tower.getX() - x, 2) + Math.pow(tower.getY() - y, 2);
		if (towerDistance < nearestTowerDistance) {
			nearestTower = tower;
			nearestTowerDistance = towerDistance;
		}
	}
	if (nearestTowerDistance < 20) {
		return true
	} else {
		return false
	}
}
 
//After we have 5 units send them out to attack. They will search for the nearest mine and hang out there until they find an enemy of a worker starts building a tower near the mine
//If a tower is being constructed or is constructed the Soldiers will move on to the next nearest mine until they will eventually find an enemy
if (fightingUnits.length == 5) {	
	var nearestMineFromFightingUnits = null;
	var nearestMineDistanceFromFightingUnits = 99999;
	var buildTowerNearMine = false;	
	for (var i = 0; i < mines.length; i++) {	
		var mine = mines[i];
		var mineNearTower = nearTower(mine.getX(), mine.getY());		
		var mineDistanceFromFightingUnits = Math.pow(mine.getX() - fightingUnits[0].getX(), 2) + Math.pow(mine.getY() - fightingUnits[0].getY(), 2);
		if (mineDistanceFromFightingUnits < nearestMineDistanceFromFightingUnits && mine != nearestMineFromCastle && !mineNearTower && mineDistanceFromFightingUnits > 22) {
			nearestMineFromFightingUnits = mine;
			nearestMineDistanceFromFightingUnits = mineDistanceFromFightingUnits;
			buildTowerNearMine = true;
		}		
	}	
	if (buildTowerNearMine) {
		scope.order("Build Watchtower", miningWorkers, randomBuildingPosition(nearestMineFromFightingUnits.getX(),nearestMineFromFightingUnits.getY()));
	}		
	scope.order("AMove", fightingUnits, {x: nearestMineFromFightingUnits.getX(), y: nearestMineFromFightingUnits.getY()});
}