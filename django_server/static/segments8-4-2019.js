// TODO: parallel joined segments should be "welded" together		(DONE)
// TODO: avoid drawing overlapping polygons, doors					(DONE DOORS, OMIT POLYGONS UNTIL SUBMISSION CHECKS)	
// TODO: all polygons mush be attached								(SUBMISSION CHECKS)
// TODO: 4 Grades													(INTERFACE)
// TODO: multiple tabs for different plans
// TODO: naming plans (tabs)
// TODO: ruler of finest detail 0.25 meter
// TODO: scrolling & zooming
// TODO: add north indicator
// TODO: undo,redo, copy, cut, paste
// TODO: snapshot with snapshot tree (order vertically according to grade, horizontally with time).
// TODO: go live!

var stepSize = 20;
function drawGrid() {
	var strokeWidth = 1;
	var strokeColor = "#009dec";
	for (var i = 0; i < view.size.width; i+= stepSize) {
		var path = new Path([new Point(i, 0), new Point(i, view.size.height)]);
		path.strokeWidth = strokeWidth;
		path.strokeColor = strokeColor;
	}
	for (var i = 0; i < view.size.height; i+= stepSize) {
		var path = new Path([new Point(0, i), new Point(view.size.width, i)]);
		path.strokeWidth = strokeWidth;
		path.strokeColor = strokeColor;
	}
}
drawGrid();

function getRandomColor() {
  var letters = '0123456789ABCDEF';
  var color = '#';
  for (var i = 0; i < 6; i++) {
    color += letters[Math.floor(Math.random() * 16)];
  }
  return color;
}
function pointToStr(point) {
	return '(' + point.x + ', ' + point.y + ')';
}
function pointEquals(point, otherPoint) {
	return Math.abs(point.x - otherPoint.x) < 0.001 && Math.abs(point.y - otherPoint.y) < 0.001;
}

var TOOL_TYPE = "room";
var ROOM_NAME = "multipurpose";

var polygonsLayer = new Layer();
var doorsLayer = new Layer();
var decorationLayer = new Layer();
polygonsLayer.activate();
var polygonSelected = null;

var selectedPolygons = [];
var polygons = [];
var doors = [];
var selectedDoor = null;
var multipleSelection = false;
var motionPoint = null;

function getLastPolygon() {
	if (polygons.length == 0) return null;
	return polygons[polygons.length-1];
}
function getLastDoor() {
	if (doors.length == 0) return null;
	return doors[doors.length-1];
}
function deselectAll() {
	if (selectedDoor) {
		selectedDoor.deselect();
	}
	var numSelectedPolygons = selectedPolygons.length;
	for (var i = 0; i < numSelectedPolygons; i++) {
		selectedPolygons.pop().deselect();
	}
}

function Door(point, orientation, polygon) {
	this.isBeingDrawn = true;
	this.isBeingMoved = false;
	this.polygonType = TOOL_TYPE;
	this.orientation = orientation;
	//this.center = point;
	this.polygons = [polygon];
	this.path = new Path({strokeWidth: DOOR_PROPS.strokeWidth, strokeColor:DOOR_PROPS.strokeColor, fillColor:DOOR_PROPS.fillColor});
	this.path.door = this;
	var doorStepSize = 4;
	if (orientation == 'H') {
		point.x -= 4*doorStepSize;
		point.y -= doorStepSize; this.path.add(point);
		point.x += 8*doorStepSize; this.path.add(point);
		point.y += 2*doorStepSize; this.path.add(point);
		point.x -= 8*doorStepSize; this.path.add(point);
		point.y -= 2*doorStepSize; this.path.add(point);
	} else {
		point.y -= 4*doorStepSize;
		point.x -= doorStepSize; this.path.add(point);
		point.y += 8*doorStepSize; this.path.add(point);
		point.x += 2*doorStepSize; this.path.add(point);
		point.y -= 8*doorStepSize; this.path.add(point);
		point.x -= 2*doorStepSize; this.path.add(point);
	}
	
	this.rotate=function(orientation) {
		if (this.orientation == orientation) return;
		this.orientation = orientation;
		this.path.rotate(90);
	}
	this.moveDraw=function(newProjection, polygon) {
		this.path.position = newProjection;
		this.rotate(newProjection.orientation);
		if (polygon != this.polygons[0]) {
			this.polygons.pop();
			this.polygons.push(polygon);
		}
	};
	this.finishDraw=function() {
		for (var d = 0; d < doors.length-1; d++) {
			var intersections = doors[d].path.getIntersections(this.path);
			if (intersections.length > 0) {
				//this.remove();
				return;
			}
		}
		this.isBeingDrawn = false;
		this.polygons[0].doors.push(this);
		for (var i in polygons) {
			var polygon = polygons[i];
			if (polygon == this.polygons[0]) continue;
			var intersections = this.path.getIntersections(polygon.path);
			if (intersections.length > 1) {
				this.polygons.push(polygon);
				polygon.doors.push(this);	
			}
		}
	};
	this.select=function() {
		this.path.selected = true;
		selectedDoor = this;
	};
	this.deselect=function() {
		if (!this==selectedDoor) return;
		this.path.selected=false;
		selectedDoor=null;
	};
	this.remove=function() {
		this.deselect();
		this.path.remove();
		this.path.door = null;
		var numPolygons = this.polygons.length;
		for (var i = 0; i < numPolygons; i++) {
			var polygon = this.polygons.pop();
			polygon.removeDoor(this);
		}
		this.pop();
	};
	this.pop=function() {
		for (var j in doors) {
			if (this == doors[j]) {
				doors.splice(j, 1);
				break;
			}
		}
	};
	this.move=function(delta, movedPolygons, movedDoors) {
		for (var i in movedDoors) {
			if (movedDoors[i] == this) return;
		}
		movedDoors.push(this);
		this.path.position += delta;
		for (var p in this.polygons) {
			var polygon = this.polygons[p];
			polygon.move(delta, movedPolygons, movedDoors);
		}
	};
	this.toString=function() {
		var doorStr = "Door at "  + pointToStr(this.path.position) + " connected to polygons at: ";
		for (var p = 0; p < this.polygons.length-1; p++) {
			doorStr += pointToStr(this.polygons[p].path.position) + ', ';
		}
		doorStr += pointToStr(this.polygons[this.polygons.length-1].path.position) + '.';
		return doorStr;
	};
	
}
	
function Polygon(point) {
	this.isBeingDrawn = false;
	this.isBeingMoved = false;
	this.polygonType = TOOL_TYPE;
	var snappedPoint = snapToGrid(point);
	this.path = new Path({strokeWidth: ROOM_PROPS.strokeWidth, strokeColor: ROOM_PROPS.drawingStrokeColor});		
	this.isBeingDrawn = true;
	this.path.add(snappedPoint);
	this.path.add(snappedPoint);
	this.path.polygon = this;
	
	this.decorations = [];
	this.doors = [];
	this.roomNameText = null;
	
	
	
	this.stopDrawing = function() {
		this.isBeingDrawn = false;
		if (this.path) {
			if (this.path.segments[0].point == this.path.segments[1].point){
				this.path.remove();
			} else {
				this.path.onClick = this.select;
				//intersectionsLayer.activate();
			}
			this.path = null;
		}
	};
	this.moveDraw = function(point) {
		if (!this.isBeingDrawn) return;
		var numSegments = this.path.segments.length;
		var snappedPoint = snapToGridHV(point, this.path.segments[numSegments-2].point);
		this.path.segments[numSegments-1].point = snappedPoint;
	};
	this.addPoint = function(point) {
		var numSegments = this.path.segments.length;
		var snappedPoint = snapToGridHV(point, this.path.segments[numSegments-2].point);
		if (pointEquals(snappedPoint, this.path.segments[0].point)) {
			this.path.segments[numSegments-1].point = snappedPoint;
			this.isBeingDrawn = false;
			this.path.fillColor = ROOM_PROPS.fillColor;
			this.path.strokeColor = ROOM_PROPS.strokeColor;
			if (numSegments == 2) {
				this.remove();
			}
			//Decoration text
			this.addDecorationText();		
		} else {
			this.path.removeSegment(numSegments-1);
			var addedPath = new Path([this.path.segments[numSegments-2].point, snappedPoint]);
			var intersections = addedPath.getIntersections(this.path);
			addedPath.remove();
			this.path.add(snappedPoint);
			if (intersections.length > 1) return;
			this.path.add(snappedPoint);
		}
		numSegments = this.path.segments.length;
		var handPoint = 0;
		if (numSegments > 3) {
			if (this.isBeingDrawn) {		
				handPoint = 1;
			} 
			var p1 = this.path.segments[numSegments - handPoint - 1].point;
			var p2 = this.path.segments[numSegments - handPoint - 2].point;
			var p3 = this.path.segments[numSegments - handPoint - 3].point;
			if ((p1.x == p2.x && p2.x == p3.x) || (p1.y == p2.y && p2.y == p3.y)) {
				this.path.segments[numSegments - handPoint - 2].remove();
			}
			if (!this.isBeingDrawn) {
				var p1 = this.path.segments[numSegments - 2].point;
				var p2 = this.path.segments[numSegments - 1].point; // first point is same as last point
				var p3 = this.path.segments[1].point;
				if ((p1.x == p2.x && p2.x == p3.x) || (p1.y == p2.y && p2.y == p3.y)) {
					this.path.segments[numSegments - 1].remove();
					this.path.segments[0].remove();
					this.path.insert(0, new Point(p1));
				}
			}
		}
	};
	this.remove=function() {
		this.path.remove();
		var numDecorations = this.decorations.length;
		for (var d = 0; d < numDecorations; d++){
			var decoration = this.decorations.pop();
			decoration.remove();
			
		}
		this.path.polygon = null;
		this.path = null;
		this.pop();
	};
	this.removeDoor=function(door) {
		for (var j in this.doors) {
			if (door == this.doors[j]) {
				this.doors.splice(j, 1);
				break;
			}
		}
	};
	this.pop=function() {
		for (var j in polygons) {
			if (this == polygons[j]) {
				polygons.splice(j, 1);
				break;
			}
		}
	};
	this.popSelected=function() {
		for (var j in selectedPolygons) {
			if (this == selectedPolygons[j]) {
				selectedPolygons.splice(j, 1);
				break;
			}
		}
	};

	this.select=function() {
		this.path.selected = true;
		selectedPolygons.push(this);
	};
	this.deselect=function() {
		this.popSelected();
		this.path.selected = false;
	};
	this.move=function(delta, movedPolygons, movedDoors) {
		for (var i in movedPolygons) {
			if (movedPolygons[i] == this) return;
		}
		movedPolygons.push(this);
		this.path.position += delta;
		for (var i in this.decorations) {
			var decoration = this.decorations[i];
			decoration.position += delta;
		}
		for (var d in this.doors) {
			var door = this.doors[d];
			door.move(delta, movedPolygons, movedDoors);
		}
	};
	
	
	this.addDecorationText =function() {
		var minPoint = new Point(this.path.segments[0].point);
		for (var j = 1; j < this.path.segments.length; j++) {
			var p = this.path.segments[j].point;
			if (p.x <= minPoint.x && p.y <= minPoint.y)
			{ minPoint.x = p.x; minPoint.y = p.y; }
		}
		minPoint.x += stepSize/2;
		minPoint.y += stepSize*2/3;
		decorationLayer.activate();
		this.roomNameText = new PointText(minPoint);
		this.decorations.push(this.roomNameText);
		this.roomNameText.fillColor = 'black'; this.roomNameText.fontSize = 10; this.roomNameText.fontWeight= 'bold'; 
		this.roomNameText.content = ROOM_NAME;
		polygonsLayer.activate();
	};
	this.changeRoomName = function() {
		this.roomNameText.content = ROOM_NAME;
	};
	this.getProjection = function(point) {
		var snappedPoint = snapToGrid(point);
		var minSnappedPoint = null; var minDistance = null;
		for (var i = 0; i < this.path.segments.length-1; i++) {
			var p1 = this.path.segments[i].point;
			var p2 = this.path.segments[i+1].point;
			if (p1.y == p2.y) {
				if (p1.x > p2.x) {var p = p1; p1=p2; p2=p;}
				if (snappedPoint.x > p1.x && snappedPoint.x < p2.x) {
					var d = Math.abs(point.y - p1.y);
					if (minDistance == null || d < minDistance) {
						minDistance = d;
						minSnappedPoint = new Point(snappedPoint.x, p1.y);
						minSnappedPoint.orientation = 'H';
					}
				}
			} else { //p1.x == p2.x
				if (p1.y > p2.y) {var p = p1; p1=p2; p2=p;}
				if (snappedPoint.y > p1.y && snappedPoint.y < p2.y) {
					var d = Math.abs(point.x - p1.x);
					if (minDistance == null || d < minDistance) {
						minDistance = d;
						minSnappedPoint = new Point(p1.x, snappedPoint.y);
						minSnappedPoint.orientation = 'V';
					}
				}
			}
		}
		return minSnappedPoint;
	};
	
	this.toString=function() {
		var polygonStr = "Polygon at " + pointToStr(this.path.position);
		if (this.doors.length > 0) polygonStr += "\n\tDoors:\n";
		for (var d in this.doors) {
			var door = this.doors[d];
			polygonStr += "\t\t" + door + "\n";
		}
		return polygonStr;
	};
}
var ROOM_PROPS = {
	'strokeWidth': 3,
	'strokeColor': "#4C4C4C",
	'drawingStrokeColor': "#4C4CCC",
	'fillColor': "#EEEEEE"
}
var DOOR_PROPS = {
	'strokeWidth': 5,
	'strokeColor': "#000000",
	'fillColor': "#EEEEEE"
}


function snapToGrid(point){
	point.x = Math.round(point.x/stepSize)*stepSize;
	point.y = Math.round(point.y/stepSize)*stepSize;
	return point;
}
function snapToGridHV(point, refPoint){
	point.x = Math.round(point.x/stepSize)*stepSize;
	point.y = Math.round(point.y/stepSize)*stepSize;
	var deltaX = Math.abs(point.x - refPoint.x);
	var deltaY = Math.abs(point.y - refPoint.y);
	if (deltaX < deltaY) { //snap x
		point.x = refPoint.x;
	} else {
		point.y = refPoint.y;
	}
	return point;
}

//INPUT EVENTS
function onMouseMove(event) {
	if (TOOL_TYPE == 'move') {
		if (motionPoint) {
			var delta = snapToGrid(event.point - motionPoint);
			if (delta.x != 0 || delta.y != 0) {
				motionPoint += delta;
				var movedPolygons = []; var movedDoors = [];
				for (var i = 0; i < selectedPolygons.length; i++) {
					var polygon = selectedPolygons[i];
					polygon.move(delta, movedPolygons, movedDoors);
				}
			}
		}
	} else if (TOOL_TYPE == 'room') {
		var numPolygons = polygons.length;
		if (numPolygons > 0) {
			polygons[numPolygons-1].moveDraw(event.point);
		}
	} else if (TOOL_TYPE == 'door') {
		var lastDoor = getLastDoor();
		var hit = polygonsLayer.hitTest(event.point);
		if (hit && hit.item.polygon)
			var projectedPoint = hit.item.polygon.getProjection(event.point);
		if (hit && hit.item.polygon && projectedPoint) { //we're hitting a polygon
			if (!lastDoor || !lastDoor.isBeingDrawn) {
				var door = new Door(projectedPoint, projectedPoint.orientation, hit.item.polygon);
				doors.push(door);
			} else {
				lastDoor.moveDraw(projectedPoint, hit.item.polygon);
			}	
		} else if ( lastDoor && lastDoor.isBeingDrawn) {
			lastDoor.remove();
		}
	}
}

function onMouseDown(event) {
	if (TOOL_TYPE == 'move') {
		var hit = doorsLayer.hitTest(event.point);
		if (hit) {
			if (!hit.item.selected) {
				deselectAll();
				var door = hit.item.door;
				door.select();
			}
		} else {
			hit = polygonsLayer.hitTest(event.point);
			if (hit) {
				motionPoint = event.point;
				if (!hit.item.selected && !multipleSelection) {
					deselectAll();
					var polygon = hit.item.polygon;
					polygon.select();
				}
			}
		}
	} else if (TOOL_TYPE == 'room') {
		
	} else if (TOOL_TYPE == 'door') {
		
	}
	
}

function onMouseUp(event) {
	if (TOOL_TYPE == 'move') {
		motionPoint = null;
		if (pointEquals(event.point, event.downPoint)) {
			if (selectedDoor) {
				var hit = doorsLayer.hitTest(event.point);
				if (hit) {
					if (!hit.item.selected) {
						deselectAll();
						var door = hit.item.door;
						door.select();
					}
				} else {
					deselectAll();
				}
			} else {
				var hit = polygonsLayer.hitTest(event.point);
				if (hit) {
					var polygon = hit.item.polygon;
					if (multipleSelection) {
						if (hit.item.selected) polygon.deselect();
						else polygon.select();
					} else {
						deselectAll();
						polygon.select();
					}
				} else if (!multipleSelection) {
					deselectAll(); 
				}
			}
		}
	} else if (TOOL_TYPE == 'room') {
		var lastPolygon = getLastPolygon();
		if (lastPolygon && lastPolygon.isBeingDrawn) {
			lastPolygon.addPoint(event.point);
		} else if (pointEquals(event.point, event.downPoint)) {
			var hit = polygonsLayer.hitTest(event.point);
			if (!hit ) {
				var polygon = new Polygon(event.point);
				polygons.push(polygon);
			}
		}
	} else if (TOOL_TYPE == 'door') {
		var lastDoor = getLastDoor();
		if (lastDoor && lastDoor.isBeingDrawn) {
			lastDoor.finishDraw();
		}
	}
	
	/* console.log('Polygons:');
	console.log(polygons);
	console.log('Selected Polygons: ');
	console.log(selectedPolygons); */
}

function onKeyDown(event) {
	if (event.key == 'delete') {
		if (selectedDoor) {
			selectedDoor.remove();
		}
		var numSelectedPolygons = selectedPolygons.length;
		if (selectedPolygons.length > 0) {
			for (var i = 0; i < numSelectedPolygons; i++) {
				var polygon = selectedPolygons.pop();
				polygon.remove();
			}
		}
	} else if (event.key == 'escape') {
		var lastPolygon = getLastPolygon();
		if (lastPolygon && lastPolygon.isBeingDrawn) {
			lastPolygon.remove();
			
		}
	} else if (event.key == 'shift') {
		multipleSelection = true;
	} else if (event.key == 'l') {
		console.log('POLYGONS');
		for (var p in polygons)
			console.log(''+polygons[p]);
		console.log('DOORS');
		for (var d in doors)
			console.log(''+doors[d]);
	}
}

function onKeyUp(event) {
	if (event.key == 'shift') {
		multipleSelection = false;
	}		
}

paperEvents.onRoomNameChange = function(newName) {
	ROOM_NAME = newName;
	if (selectedPolygons.length > 0) {
		for (var i in selectedPolygons){
			selectedPolygons[i].changeRoomName();
		}
	}
}

paperEvents.onDrawTypeChange = function(newType) {
	if (TOOL_TYPE == 'move') {
		deselectAll(); //move to tool_type change
	}
	if (newType == 'door') {
		doorsLayer.activate();
	} else {
		polygonsLayer.activate();
	}
	TOOL_TYPE = newType;
}
