var strokeWidth = 1;
var stepSize = 8;
var strokeColor = "#009dec";
var gridLayer = project.activeLayer;

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


var layer = new Layer();
layer.activate();

var userIsDrawingPath = false;
var pathBeingDrawn = null;
var pathSelected = null;
var wallStrokeWidth = 8;
var wallStrokeColor = "#4C4C4C";

function selectPath(event) {
	this.selected = true;
	pathSelected = this;
}
function deselectPath() {
	if (pathSelected) {
		pathSelected.selected = false;
		pathSelected = null;
	}
}
function snapToGrid(point){
	point.x = Math.round(point.x/stepSize)*stepSize;
	point.y = Math.round(point.y/stepSize)*stepSize;
	return point;
}
function startDrawingRoom(point) {
	userIsDrawingPath = true;
	pathBeingDrawn = new Path({
		strokeColor: "#124545",
		strokeWidth: 1
	});
	
	var rectangle = new Rectangle(point, point);
	pathBeingDrawn.rectanglePath = new Path.Rectangle(rectangle);
	pathBeingDrawn.rectanglePath.strokeColor = wallStrokeColor;
	pathBeingDrawn.rectanglePath.strokeWidth =  wallStrokeWidth;
	pathBeingDrawn.add(point);
	pathBeingDrawn.add(point);
}
function stopDrawingRoom() {
	userIsDrawingPath = false;
	if (pathBeingDrawn) {
		pathBeingDrawn.remove();
		if (pathBeingDrawn.segments[0].point.equals(pathBeingDrawn.segments[1].point)){
			pathBeingDrawn.rectanglePath.remove();
		}
		pathBeingDrawn.rectanglePath.onClick = selectPath;
		pathBeingDrawn = null;
		console.log(project.activeLayer.children.length);
	}
}
function resizeDrawingRoom(point) {
	pathBeingDrawn.firstSegment.point = point;
	pathBeingDrawn.rectanglePath.remove();
	var rectangle = new Rectangle(pathBeingDrawn.segments[0].point, pathBeingDrawn.segments[1].point);
	pathBeingDrawn.rectanglePath = new Path.Rectangle(rectangle);
	pathBeingDrawn.rectanglePath.strokeColor = wallStrokeColor;
	pathBeingDrawn.rectanglePath.strokeWidth =  wallStrokeWidth;
}



function onMouseMove(event) {
	if (userIsDrawingPath) {
		var snappedPoint = snapToGrid(event.point);
		resizeDrawingRoom(snappedPoint);
	}
}
function onMouseDown(event) {
	deselectPath();
	var snappedPoint = snapToGrid(event.point);
	startDrawingRoom(snappedPoint);
}
function onMouseUp(event) {
	stopDrawingRoom();
}
function onKeyDown(event) {
	if (event.key == 'delete' && pathSelected) {
		pathSelected.remove();	
	} 
}

function onKeyUp(event) {
	
}