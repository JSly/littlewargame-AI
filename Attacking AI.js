//Returns a Random Number
var randomNumber = function(highestNum) {
	return Math.floor((Math.random() * highestNum) + 1)
}
//Returns a Random Number that can be positive or negative
var randomPosNegNumber = function(highestNum) {
	return (randomNumber(2) == 1) ? randomNumber(highestNum)*-1 : randomNumber(highestNum);
}

//Returns a move object that is around the x/y location passed
var randomBuildingPosition = function(varX,varY) {
	var changePosition = function(position){
		var randomThree = randomNumber(3);
		var newPosition = position;
		//Changes the position passed to stay the 
		if (randomThree == 1) {
			newPosition = position+randomPosNegNumber(3); //Same then +/- 1,2, or 3
		} else if (randomThree == 2) {
			newPosition = position-4+randomPosNegNumber(3); //-4 then +/- 1,2, or 3
		} else if (randomThree == 3) {
			newPosition = position+4+randomPosNegNumber(3); //+4 then +/- 1,2, or 3
		}
		return newPosition
	}
	var buildPositionObj = {
		x: changePosition(varX),
		y: changePosition(varY)
	};
	if (scope.positionIsPathable(buildPositionObj.x, buildPositionObj.y)) {
		return buildPositionObj;
	} else {
		return randomBuildingPosition(varX,varY);
	}
}

//Returns a move object surrounding a mine
var buildCastle = function(varX,varY) {
	var positionArr = [
		{x: 0,y: 10},{x: 10,y: 0},{x: 0,y: -10},{x: -10,y: 0},
		{x: 1,y: 10},{x: 10,y: 1},{x: 1,y: -10},{x: -10,y: 1},
		{x: -1,y: 10},{x: 10,y: -1},{x: -1,y: -10},{x: -10,y: -1},
		{x: 2,y: 10},{x: 10,y: 2},{x: 2,y: -10},{x: -10,y: 2},
		{x: -2,y: 10},{x: 10,y: -2},{x: -2,y: -10},{x: -10,y: -2},
		{x: 3,y: 9},{x: 9,y: 3},{x: 3,y: -9},{x: -9,y: 3},
		{x: -3,y: 9},{x: 9,y: -3},{x: -3,y: -9},{x: -9,y: -3},
		{x: 4,y: 8},{x: 8,y: 4},{x: 4,y: -8},{x: -8,y: 4},
		{x: -4,y: 8},{x: 8,y: -4},{x: -4,y: -8},{x: -8,y: -4},
		{x: 5,y: 7},{x: 7,y: 5},{x: 5,y: -7},{x: -5,y: 4},
		{x: -5,y: 7},{x: 7,y: -5},{x: -5,y: -7},{x: -5,y: -4},
		{x: 6,y: 6},{x: 6,y: -6},{x: -6,y: 6},{x: -6,y: -6},
	];
	var ranNum = randomNumber(positionArr.length-1);
	var buildPositionObj = {
		x: varX+positionArr[ranNum].x,
		y: varY+positionArr[ranNum].y
	};
	if (scope.positionIsPathable(buildPositionObj.x, buildPositionObj.y)) {
		return buildPositionObj;
	} else {
		return buildCastle(varX,varY);
	}
}

var players = scope.getArrayOfPlayerNumbers();
var myPlayerNumber = scope.getMyPlayerNumber();
var myTeamNumber = scope.getMyTeamNumber();
var gold = scope.getGold();

var idleWorkers = scope.getUnits({type: "Worker", player: myPlayerNumber, order: "Stop"});
var workers = scope.getUnits({type: "Worker", player: myPlayerNumber});
var miningWorkers = scope.getUnits({type: "Worker", player: myPlayerNumber, order: "Mine"});
var fightingUnits = scope.getUnits({notOfType: "Worker", player: myPlayerNumber});
var enemyUnits = scope.getUnits({enemyOf: myPlayerNumber});

var castles = scope.getBuildings({type: "Castle", player: myPlayerNumber});
var finishedCastles = scope.getBuildings({type: "Castle", player: myPlayerNumber, onlyFinshed: true});
var teamCastles = scope.getBuildings({type: "Castle", team: myTeamNumber});
var barracks = scope.getBuildings({type: "Barracks", player: myPlayerNumber});
var finishedBarracks = scope.getBuildings({type: "Barracks", player: myPlayerNumber, onlyFinshed: true});
var houses = scope.getBuildings({type: "House", player: myPlayerNumber});
var finishedHouses = scope.getBuildings({type: "House", player: myPlayerNumber, onlyFinshed: true});
var towers = scope.getBuildings({type: "Watchtower", player: myPlayerNumber});
var mines = scope.getBuildings({type: "Goldmine"});

if (!this.enemies) {
	var enemies = scope.getArrayOfPlayerNumbers();
	$.each(players, function(index, playerNumber) {
		var startPosition = scope.getStartLocationForPlayerNumber(playerNumber)
		if (teamCastles.length > 0) {
			$.each(teamCastles, function(index, castle) {
				var castlePosition = {x:castle.getX(), y:castle.getY()}
				if (startPosition.x == castle.getX()-1 && startPosition.y == castle.getY()-1) {
					enemies = jQuery.grep(enemies, function(value) {
						return value != playerNumber;
					});
				}
			});
		}
	});
	this.enemies = enemies;
}
	
var nearestMineFromCastle = null;
var nearestMineDistanceFromCastle = 99999;
if (castles.length >= 1) {
	$.each(mines, function(index, mine) {
		var dist = Math.pow(mine.getX() - castles[0].getX(), 2) + Math.pow(mine.getY() - castles[0].getY(), 2);
		if (dist < nearestMineDistanceFromCastle && mine.unit.gold != 0) {
			nearestMineFromCastle = mine;
			nearestMineDistanceFromCastle = dist;
		}
	});
}
var secondNearestMineFromCastle = null;
var secondNearestMineDistanceFromCastle = 99999;
if (castles.length >= 1) {
	$.each(mines, function(index, mine) {
		var dist = Math.pow(mine.getX() - castles[0].getX(), 2) + Math.pow(mine.getY() - castles[0].getY(), 2);
		if (dist < secondNearestMineDistanceFromCastle && dist != nearestMineDistanceFromCastle && mine.unit.gold != 0) {
			secondNearestMineFromCastle = mine;
			secondNearestMineDistanceFromCastle = dist;
		}
	});
}

// order all idle workers to mine from the nearest gold mine
if (nearestMineFromCastle && idleWorkers.length > 0) {
	$.each(workers, function(index, worker) {
		if (worker.getCurrentOrderName() == "Stop") {
			var workersMine = (index<10) ? nearestMineFromCastle : secondNearestMineFromCastle;
			scope.order("Mine", [worker], {unit: workersMine});
		}
	});
}

// if the castle is idle, order to make workers up to 7
if (castles.length >= 1 && !castles[0].getUnitTypeNameInProductionQueAt(1) && workers.length < 7) {
	scope.order("Train Worker", [castles[0]]);

}
//After primary base is established (tower/barracks) create workers up to 10
else if (castles.length >= 1 && !castles[0].getUnitTypeNameInProductionQueAt(1) && finishedBarracks.length > 0 && workers.length < 10) {
	scope.order("Train Worker", [castles[0]]);
}
 
// if any enemy units in sight and we have fighting units, order them to attack them
if (enemyUnits.length > 0 && fightingUnits.length > 3) {
	scope.order("AMove", fightingUnits, scope.getCenterOfUnits(enemyUnits));
}

// if we dont have a single house, make one
if (castles.length >= 1 && houses.length == 0) {
	//Added randomBuildingPosition around castle
	scope.order("Build House", workers, randomBuildingPosition(castles[0].getX(),castles[0].getY()));
} 
//Build second house at new base
else if (castles.length >= 2 && houses.length == 1) {
	scope.order("Build House", miningWorkers, randomBuildingPosition(castles[1].getX(),castles[1].getY()));
}

// if we have at least one finished house make tower 
if (castles.length >= 1 && finishedHouses.length > 0 && towers.length == 0) {
	scope.order("Build Watchtower", workers, randomBuildingPosition(castles[0].getX(),castles[0].getY()));
}
// if we have at least one tower started build barracks
if (castles.length >= 1 && towers.length > 0 && barracks.length == 0) {
	scope.order("Build Barracks", miningWorkers, randomBuildingPosition(castles[0].getX(),castles[0].getY()));
}

// Secondary base
if (castles.length == 1 && finishedBarracks.length > 0 && gold > 400) {
	// order all idle workers to mine from the nearest gold mine
	scope.order("Build Castle", miningWorkers, buildCastle(secondNearestMineFromCastle.getX(),secondNearestMineFromCastle.getY()));
}

if (castles.length >= 2 && workers.length < 20) {
	if (!castles[0].getUnitTypeNameInProductionQueAt(1)) {
		scope.order("Train Worker", [castles[0]]);
	}
	if (!castles[1].getUnitTypeNameInProductionQueAt(1)) {
		scope.order("Train Worker", [castles[1]]);
	}
}
 
//Trains 5 soldiers
if (finishedBarracks.length > 0  && fightingUnits.length < 5) {
	scope.order("Train Soldier", [barracks[0]]);
}
 
//Better Attack using new 'enemies' (only supports one enemy)
if (fightingUnits.length == 5) {
	var enemyPosition = scope.getStartLocationForPlayerNumber(this.enemies[0])	
	scope.order("AMove", fightingUnits, enemyPosition);
}