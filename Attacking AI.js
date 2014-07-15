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
	return buildPositionObj;
}

var players = scope.getArrayOfPlayerNumbers();
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
var teamCastles = scope.getBuildings({type: "Castle", team: myTeamNumber});
var barracks = scope.getBuildings({type: "Barracks", player: myPlayerNumber});
var houses = scope.getBuildings({type: "House", player: myPlayerNumber});
var towers = scope.getBuildings({type: "Watchtower", player: myPlayerNumber});
//Including teammates towers
var teamTowers = scope.getBuildings({type: "Watchtower", team: myTeamNumber});
var finishedHouses = scope.getBuildings({type: "House", player: myPlayerNumber, onlyFinshed: true});
var finishedBarracks = scope.getBuildings({type: "Barracks", player: myPlayerNumber, onlyFinshed: true});
var mines = scope.getBuildings({type: "Goldmine"});
var enemyUnits = scope.getUnits({enemyOf: myPlayerNumber});

//Starts with all players
var enemies = scope.getArrayOfPlayerNumbers();
//Removes all players from 'enemies' that are on your team
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

var nearestMineFromCastle = null;
var nearestMineDistanceFromCastle = 99999;

if (castles.length >= 1) {
	$.each(mines, function(index, mine) {
		var dist = Math.pow(mine.getX() - castles[0].getX(), 2) + Math.pow(mine.getY() - castles[0].getY(), 2);
		if (dist < nearestMineDistanceFromCastle) {
			nearestMineFromCastle = mine;
			nearestMineDistanceFromCastle = dist;
		}
	});
}

// order all idle workers to mine from the nearest gold mine
if (nearestMineFromCastle && idleWorkers.length > 0) {
	scope.order("Mine", idleWorkers, {unit: nearestMineFromCastle});
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
//If the building of house 1 fails this is a fall through
else if (houses.length == 1 && finishedHouses.length == 0 && workers.length >= 7) {
	scope.order("Moveto", workers, {x: houses[0].getX(), y:houses[0].getY()});
}

// if we have at least one finished house make tower 
if (castles.length >= 1 && finishedHouses.length > 0 && towers.length == 0) {
	scope.order("Build Watchtower", workers, randomBuildingPosition(castles[0].getX(),castles[0].getY()));
}
// if we have at least one tower started build barracks
if (castles.length >= 1 && towers.length > 0 && barracks.length == 0) {
	scope.order("Build Barracks", miningWorkers, randomBuildingPosition(castles[0].getX(),castles[0].getY()));
}
 
//Trains 5 soldiers
if (finishedBarracks.length > 0  && fightingUnits.length < 5) {
	scope.order("Train Soldier", [barracks[0]]);
}
 
//Better Attack using new 'enemies' (only supports one enemy)
if (fightingUnits.length == 5) {
	var enemyPosition = scope.getStartLocationForPlayerNumber(enemies[0])	
	scope.order("AMove", fightingUnits, enemyPosition);
}