function insertInOrder(pointList, newPoint) {
	if (pointList.length == 0) {
		pointList.push(newPoint);
		return;
	}
	var start = 0;
	var end = pointList.length;
	while (true) {
		var mid = start + parseInt((end-start)/2);
		if (pointList[mid].y < newPoint.y) {//pointList[mid].x*pointList[mid].x+pointList[mid].y*pointList[mid].y < newPoint.x*newPoint.x+newPoint.y*newPoint.y) {
			start = mid+1;
		} else {
			end = mid;
		}
		if (start >= end) {
			pointList.splice(start, 0, newPoint);
			break;
		}
	}
}

function buildGraph(graph, sortedPoints) {
	for (i in wallLayer.children) {
		var path = wallLayer.children[i];
		var point0 = path.segments[0].point;
		var point1 = path.segments[1].point; 
		if (!(point0 in graph)) {
			graph[point0] = [];
			insertInOrder(sortedPoints, point0);
		}
		insertInOrder(graph[point0], point1); //modify to push in correct ccw order!
		
		if (!(point1 in graph)) {
			graph[point1] = [];
			insertInOrder(sortedPoints, point1);
		}
		insertInOrder(graph[point1], point0); //modify to push in correct ccw order!
	}
}
function pointEquals(point, otherPoint) {
	return Math.abs(point.x - otherPoint.x) < 0.001 && Math.abs(point.y - otherPoint.y) < 0.001;
}
function listOfLinesContains(listOfLines, line) {
	for (s in listOfLines) {
		if ((pointEquals(listOfLines[s][0], line[0]) && pointEquals(listOfLines[s][1], line[1])) || 
			(pointEquals(listOfLines[s][1], line[0]) && pointEquals(listOfLines[s][0], line[1])))
		return true;
	}
	return false;
}
function listOfPointsContains(listOfPoints, point) {
	for (var i in listOfPoints) {
		otherPoint = listOfPoints[i];
		if (pointEquals(point, otherPoint)) return true;
	}
	return false;
}

function listOfLinesToStr(listOfLines) {
	var str = '';
	for (var i in listOfLines) {
		str += listOfPointsToStr(listOfLines[i]);
	}
	return str + 'end';
}

function listOfPointsToStr(listOfPoints) {
	var str = '';
	for (var i in listOfPoints) {
		str += pointToStr(listOfPoints[i]) +' - '
	}
	return str + 'end';
}

function pointToStr(point) {
	return '(' + point.x + ', ' + point.y + ')';
}
function deleteFromListOfPoints(listOfPoints, point) {
	for (var i in listOfPoints) {
		otherPoint = listOfPoints[i];
		if (pointEquals(point, otherPoint)) {
			listOfPoints.splice(i, 1);
			break;
		}
	}
}
function getIncludedAngle(point1, point, point2) {
	var x1 = point1.x - point.x;
	var x2 = point2.x - point.x;
	var y1 = point1.y - point.y;
	var y2 = point2.y - point.y;
	var mag1 = Math.sqrt(x1*x1 + y1*y1);
	var mag2 = Math.sqrt(x2*x2 + y2*y2);
	x1/=mag1; y1/=mag1;
	x2/=mag2; y2/=mag2;
	var direction = (x1*y2 - x2*y1) > 0 ? 1 : -1;
	var angle =  Math.acos(x1 * x2 + y1 * y2) / Math.PI;
	if (angle >= 1) angle -= 1;
	if (angle <= -1) angle += 1;
	angle *= direction;
	if (isNaN(angle) || angle == 0) return -1*Math.PI/2;
	return angle;
}

function strToPoint(pstr) {
	return new Point(JSON.parse(pstr.replace("x", "\"x\"").replace("y", "\"y\"")));
}

function findMinimalPolygon(graph, minimalPolygon, goCW) {
	var deadEnds = [];
	while (minimalPolygon.length >= 2) {
		console.log('minimalPolygon at start of loop: ');
		console.log(listOfPointsToStr(minimalPolygon));
		var point = minimalPolygon[minimalPolygon.length - 1];
		var previousPoint = minimalPolygon[minimalPolygon.length - 2];
		
		var leastPoint = null;
		var leastAngleDifference = null;
		
		console.log('checking primary point: ');
		console.log(pointToStr(point));
		for (var i in graph[point]) {
			var otherPoint = graph[point][i];
			console.log('checking secondary point: ');
			console.log(pointToStr(otherPoint));
			//cycle check
			if (minimalPolygon.length > 2 && pointEquals(otherPoint, minimalPolygon[0])) {
				//we have a cycle
				//minimalPolygon.push(otherPoint);
				return true;
			}
			
			if (listOfPointsContains(minimalPolygon, otherPoint)) {
				console.log('polygon contains other point!');
				continue; //avoid itnernal cycles
			}
			if (listOfPointsContains(deadEnds, otherPoint)) {
				console.log('other point is deadend!');
				continue; //avoid deadends
			}
			//least point check
			//var otherAngle = getAngle(point, otherPoint);
			var includedAngle = getIncludedAngle(otherPoint, point, previousPoint);
			console.log('with angle: ' + includedAngle);
			var correctDirection = (!goCW && includedAngle < 0) || (goCW && includedAngle > 0);
			if ((leastAngleDifference == null || Math.abs(includedAngle) < Math.abs(leastAngleDifference)) && correctDirection) {
				console.log(includedAngle + ' < ' + leastAngleDifference);
				leastAngleDifference = includedAngle;
				leastPoint = otherPoint;
				console.log('found least point!');
				console.log(pointToStr(leastPoint));
			}
		}
		if (leastPoint) {
			minimalPolygon.push(leastPoint);
		} else {
			console.log('found deadend!');
			var deadend = minimalPolygon.pop();
			console.log(pointToStr(deadend));
			deadEnds.push(deadend); // point is a deadend
		}
	}
	return false;
}

function computeMinimalPolygons() {
	//build graph
	var graph = {};
	var sortedPoints = [];
	buildGraph(graph, sortedPoints);
	//delete loose lines 
	var checkAgain = true;
	// use sortedPoints instead
	while (checkAgain) {
		checkAgain = false;
		for (var pstr in graph) {
			var point = strToPoint(pstr);
			if (graph[pstr].length == 1) {
				checkAgain = true;
				var otherPoint = graph[pstr][0];
				delete graph[pstr];
				deleteFromListOfPoints(graph[otherPoint], point);
			} else if (graph[pstr].length == 0) {
				delete graph[pstr];
			}
		}
	}
	console.log('graph: ');
	console.log(graph);
	console.log(sortedPoints);
	
	var consumedLines = [];
	var minimalPolygons = [];
	while (true) {
		console.log('consumed lines at start: ');
		console.log(listOfLinesToStr(consumedLines));
		var line = null;
		//pick next top-most non-consumed line
		for (var p in sortedPoints) {
			var point = sortedPoints[p];
			if (!(point in graph)) {
				console.log('point not in graph');
				continue;
			}
			
			for (i in graph[point]) {
				var otherPoint = graph[point][i];
				if (point.x == otherPoint.x)
					if (point.y > otherPoint.y)
						line = [otherPoint, point];
					else
						line = [point, otherPoint];
				else if (point.x > otherPoint.x)
					line = [point, otherPoint];
				else
					line = [otherPoint, point];
				if (listOfLinesContains(consumedLines, line)) {
					line = null;
					continue;
				}
				
				console.log('picked line: ');
				console.log(listOfPointsToStr(line));
				console.log('line consumed?');
				console.log(listOfLinesContains(consumedLines, line));
				consumedLines.push(line);
				break;
			}
			if (line) break;
		}
		
		if (!line) break; //loop until all lines are consumed
		//loop in single direction
		
		var minimalPolygon = [line[0], line[1]];
		var ccwPolygonFound = findMinimalPolygon(graph, minimalPolygon, false);
		if (ccwPolygonFound) {
			console.log('got cycle: ');
			console.log(listOfPointsToStr(minimalPolygon));
			minimalPolygons.push(minimalPolygon);
			console.log('marking lines as consumed!');
			for (var i = 0; i < minimalPolygon.length - 1; i++) {
				var side = [minimalPolygon[i], minimalPolygon[i+1]];
				console.log(listOfPointsToStr(side));
				if (! listOfLinesContains(consumedLines, side)) {
					consumedLines.push(side);
				}
			}
			consumedLines.push([minimalPolygon[0], minimalPolygon[minimalPolygon.length-1]]);
		}
		minimalPolygon = [line[0], line[1]];
		var cwPolygonFound = findMinimalPolygon(graph, minimalPolygon, true);
		if (cwPolygonFound) {
			console.log('got cycle: ');
			console.log(listOfPointsToStr(minimalPolygon));
			minimalPolygons.push(minimalPolygon);
			console.log('marking lines as consumed!');
			for (var i = 0; i < minimalPolygon.length - 1; i++) {
				var side = [minimalPolygon[i], minimalPolygon[i+1]];
				console.log(listOfPointsToStr(side));
				if (! listOfLinesContains(consumedLines, side)) {
					consumedLines.push(side);
				}
			}
			consumedLines.push([minimalPolygon[0], minimalPolygon[minimalPolygon.length-1]]);
		}
		
	}
	return minimalPolygons;
}