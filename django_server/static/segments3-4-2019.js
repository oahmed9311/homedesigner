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

function pointEquals(point, otherPoint) {
	return Math.abs(point.x - otherPoint.x) < 0.001 && Math.abs(point.y - otherPoint.y) < 0.001;
}

var DRAW_TYPE = "room";
var ROOM_NAME = "multipurpose";

var polygonsLayer = new Layer();
var decorationLayer = new Layer();
polygonsLayer.activate();
var polygonSelected = null;

function Polygon(point) {
	this.isBeingDrawn = false;
	this.isBeingMoved = false;
	this.drawType = DRAW_TYPE;
	var snappedPoint = snapToGrid(point);
	if (this.drawType == "room") {
		this.path = new Path({strokeWidth: ROOM_PROPS.strokeWidth, strokeColor: ROOM_PROPS.drawingStrokeColor});		
		this.isBeingDrawn = true;
		this.path.add(snappedPoint);
		this.path.add(snappedPoint);
		this.path.polygon = this;
	} else if (this.drawType == "door") {
		this.path = new Path({strokeWidth: DOOR_PROPS.strokeWidth, strokeColor:DOOR_PROPS.strokeColor, fillColor:DOOR_PROPS.fillColor});
		var doorStepSize = 4;
		snappedPoint.x -= 4*doorStepSize;
		snappedPoint.y -= doorStepSize; this.path.add(snappedPoint);
		snappedPoint.x += 8*doorStepSize; this.path.add(snappedPoint);
		snappedPoint.y += 2*doorStepSize; this.path.add(snappedPoint);
		snappedPoint.x -= 8*doorStepSize; this.path.add(snappedPoint);
		snappedPoint.y -= 2*doorStepSize; this.path.add(snappedPoint);
		this.path.polygon = this;
	}
	
	this.decorations = [];
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
		
	};
	this.remove=function() {
		this.path.remove();
		this.path.polygon = null;
		this.path = null;
		this.pop();
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
	/* this.swim=function() {
		this.pop();
		polygons.push(this);
	} */
	this.select=function() {
		this.path.selected = true;
		selectedPolygons.push(this);
	};
	this.deselect=function() {
		this.popSelected();
		this.path.selected = false;
	};
	this.move=function(delta) {
		this.path.position += delta;
		for (var i in this.decorations) {
			var decoration = this.decorations[i];
			decoration.position += delta;
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

function onMouseMove(event) {
	if (motionPoint) {
		var delta = snapToGrid(event.point - motionPoint);
		if (delta.x != 0 || delta.y != 0) {
			motionPoint += delta;
			for (var i = 0; i < selectedPolygons.length; i++) {
				var polygon = selectedPolygons[i];
				polygon.move(delta);
			}
		}
	}
	var numPolygons = polygons.length;
	if (numPolygons > 0) {
		polygons[numPolygons-1].moveDraw(event.point);
	}
}
var selectedPolygons = [];
var polygons = [];
var multipleSelection = false;
var motionPoint = null;
function getLastPolygon() {
	if (polygons.length == 0) return null;
	return polygons[polygons.length-1];
}
function deselectAll() {
	var numSelectedPolygons = selectedPolygons.length;
	for (var i = 0; i < numSelectedPolygons; i++) {
		selectedPolygons.pop().deselect();
	}
}

//INPUT EVENTS

function onMouseDown(event) {
	var lastPolygon = getLastPolygon();
	if (lastPolygon && lastPolygon.isBeingDrawn) return;
	if (DRAW_TYPE == 'door') return;
	var hit = polygonsLayer.hitTest(event.point);
	if (hit) {
		motionPoint = event.point;
		if (!hit.item.selected && !multipleSelection) {
			deselectAll();
			var polygon = hit.item.polygon;
			polygon.select();
		}
	}
	
}

function onMouseUp(event) {
	motionPoint = null;
	var lastPolygon = getLastPolygon();
	if (lastPolygon && lastPolygon.isBeingDrawn) {
		lastPolygon.addPoint(event.point);
	} else if (pointEquals(event.point, event.downPoint)) {
		var hit = polygonsLayer.hitTest(event.point);
		if (hit && DRAW_TYPE != 'door') {
			var polygon = hit.item.polygon;
			if (multipleSelection) {
				if (hit.item.selected) polygon.deselect();
				else polygon.select();
			} else {
				deselectAll();
				polygon.select();
			}
		} else {
			if (selectedPolygons.length > 0) {
				if (!multipleSelection)
					deselectAll();
			} else {		
				var polygon = new Polygon(event.point);
				polygons.push(polygon);
			} 
		}
	}
	/* console.log('Polygons:');
	console.log(polygons);
	console.log('Selected Polygons: ');
	console.log(selectedPolygons); */
}

function onKeyDown(event) {
	if (event.key == 'delete') {
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
	DRAW_TYPE = newType;
}
