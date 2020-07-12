// TODO: parallel joined segments should be "welded" together		(DONE)
// TODO: avoid drawing overlapping project.activePlan.polygons, project.activePlan.doors					(DONE project.activePlan.doors, OMIT project.activePlan.polygons UNTIL SUBMISSION CHECKS)	
// TODO: all project.activePlan.polygons mush be attached								(SUBMISSION CHECKS)
// TODO: 4 Grades													(INTERFACE)
// TODO: multiple tabs for different plans							(DONE)
// TODO: undo,redo (polygon designation action, plan name action, plan delete action, floating door bug)
// TODO: naming plans (tabs)
// TODO: ruler of finest detail 0.25 meter
// TODO: scrolling & zooming
// TODO: add north indicator

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

var TOOL_TYPE = "move";
var ROOM_NAME = "multipurpose";

function Command() {
	this.actionsDone = []; // stack
	this.actionsUndone = []; // stack
	this.do=function(action) {
		action.do();
		this.actionsDone.push(action);
		this.actionsUndone = [];
	};
	this.undo=function() {
		var action = this.actionsDone.pop();
		if (!action) return;
		action.undo();
		this.actionsUndone.push(action);
	};
	this.redo=function() {
		var action = this.actionsUndone.pop();
		if (!action) return;
		action.do();
		this.actionsDone.push(action);
	};
}
function MoveAction(polygons, delta) {
	this.polygons = polygons;
	this.delta = delta;
	this.do=function() {
		var movedPolygons = []; var movedDoors = [];
		for (var i = 0; i < this.polygons.length; i++) {
			var polygon = this.polygons[i];
			polygon.move(this.delta, movedPolygons, movedDoors);
		}
	};
	this.undo=function() {
		var movedPolygons = []; var movedDoors = [];
		for (var i = 0; i < this.polygons.length; i++) {
			var polygon = this.polygons[i];
			polygon.move(this.delta*-1, movedPolygons, movedDoors);
		}
	};
}

function AddPolygonAction(polygon, plan) {
	this.polygon = polygon;
	this.plan = plan;
	this.do=function() {
		polygon.unhide(this.plan); 
	};
	this.undo=function() {
		polygon.hide(this.plan); 
	};
}

function DeletePolygonAction(plan) {
	this.polygons = plan.selectedPolygons.slice(0); //clone
	this.plan = plan;
	this.do=function() {
		for (var i = 0; i < this.polygons.length; i++) {
			polygon = this.polygons[i]
			polygon.hide(this.plan); 
		}
	};
	this.undo=function() {
		for (var i = 0; i < this.polygons.length; i++) {
			polygon = this.polygons[i]
			polygon.unhide(this.plan); 
		}
	};
	//handle doors which belong nowhere else!
}
function AddDoorAction(door, plan) {
	this.door = door;
	this.plan = plan;
	this.do=function() {
		for (var i in this.door.polygons) {
			var polygon = this.door.polygons[i];
			polygon.addDoor(this.door);
		}
		this.door.unhide(this.plan);
	};
	this.undo=function() {
		for (var i in this.door.polygons) {
			var polygon = this.door.polygons[i];
			polygon.removeDoor(this.door);
		}
		this.door.hide(this.plan);
	};
}
function DeleteDoorAction(plan) {
	this.door = plan.selectedDoor;
	this.plan = plan;
	this.do=function() {
		for (var i in this.door.polygons) {
			var polygon = this.door.polygons[i];
			polygon.removeDoor(this.door);
		}
		this.door.hide(this.plan);
	};
	this.undo=function() {
		for (var i in this.door.polygons) {
			var polygon = this.door.polygons[i];
			polygon.addDoor(this.door);
		}
		this.door.unhide(this.plan);
	};
}
function Plan(id) {
	this.id = id;
	this.polygonsLayer = new Layer();
	this.doorsLayer = new Layer();
	this.decorationsLayer = new Layer();
	this.polygonsLayer.activate();
	this.selectedPolygons = [];
	this.polygons = [];
	this.doors = [];
	this.selectedDoor = null;
	this.multipleSelection = false;
	this.motionPoint = null;
	this.deactivate=function() {
		this.polygonsLayer.visible=false;
		this.doorsLayer.visible=false;
		this.decorationsLayer.visible=false;
	};
	this.activate=function() {
		this.polygonsLayer.visible=true;
		this.doorsLayer.visible=true;
		this.decorationsLayer.visible=true;
		this.polygonsLayer.activate();
	};
	this.getLastPolygon=function() {
		if (this.polygons.length == 0) return null;
		return this.polygons[this.polygons.length-1];
	};
	this.getLastDoor=function() {
		if (this.doors.length == 0) return null;
		return this.doors[this.doors.length-1];
	};
	this.deselectAll=function() {
		if (this.selectedDoor) {
			this.selectedDoor.deselect();
		}
		var numSelectedPolygons = this.selectedPolygons.length;
		for (var i = 0; i < numSelectedPolygons; i++) {
			this.selectedPolygons.pop().deselect();
		}
	};
	
	this.remove=function() {
		this.polygonsLayer.remove();
		this.doorsLayer.remove();
		this.decorationsLayer.remove();
		this.doors=null;
		this.polygons=null;
		this.selectedPolygons = null;
	};
    this.serialize=function() {
        var serialized = {};
        serialized['name'] = paperEvents.getPlanNameById(this.id);
        serialized['polygons'] = [];
        for (var p in this.polygons) {
            var polygon = this.polygons[p];
            serialized['polygons'].push(polygon.serialize());
        }
        serialized['doors'] = [];
        for (var d in this.doors) {
            var door = this.doors[d];
            serialized['doors'].push(door.serialize());
        }
        return serialized;
    };
    this.deserialize=function(serialized) {
        for (var p in serialized.polygons) {
            var serializedPolygon = serialized.polygons[p];
            var polygon = new Polygon(serializedPolygon.path[0]);
            polygon.deserialize(serializedPolygon);
            this.polygons.push(polygon);
        }
        for (var d in serialized.doors) {
            var serializedDoor = serialized.doors[d];
            var door = new Door(new Point(0, 0), 'H');
            door.deserialize(serializedDoor);
            this.doors.push(door);
        }
    };

}
function Project() {
	this.plans = [];
	this.plans.push(new Plan(0));
	this.activePlan = this.plans[0];
	this.command = new Command();
	this.addPlan = function() {
		var planId = this.plans[this.plans.length-1].id+1;
		this.plans.push(new Plan(planId));
		this.activatePlan(planId);
		return planId;
	};
	this.activatePlan=function(id) {
		for (var p = 0; p < this.plans.length; p++) {
			var plan = this.plans[p];
			if (plan.id == id) {
				this.activePlan.deactivate();
				plan.activate();
				this.activePlan = plan;
				break;
			}
		}
	};
	this.deletePlan=function(planId) {
		for (var p = 0; p < this.plans.length; p++) {
			var plan = this.plans[p];
			if (plan.id == planId) {
				this.plans.splice(p, 1);
				if (this.activePlan == plan) {
					this.activePlan.deactivate();
					if (this.plans.length == 0) {
						plan.remove();
						this.activePlan = null;
						return -1;
					}
					this.activePlan = this.plans[this.plans.length-1];
					this.activePlan.activate()
				}
				plan.remove();
				return this.activePlan.id;
			}
		}
	};
	this.do=function(action) {
		this.command.do(action);
	};
	this.undo=function() {
		this.command.undo();
	};
	this.redo=function() {
		this.command.redo();
	};
	this.finalizeMoveAction=function() {
		var doneActions = this.command.actionsDone;
		if (! (doneActions.length > 0 && doneActions[doneActions.length-1] instanceof MoveAction)) return;
		var lastAction = doneActions.pop();
		var totalAction = lastAction;
		while (doneActions.length > 0 && doneActions[doneActions.length-1] && doneActions[doneActions.length-1] instanceof MoveAction &&
				doneActions[doneActions.length-1].polygons == lastAction.polygons) {
			lastAction = doneActions.pop();
			totalAction.delta += lastAction.delta;
		}
		totalAction.polygons = totalAction.polygons.slice(0); //clone
		doneActions.push(totalAction);
	};
	this.delete=function() {
		if (this.activePlan.selectedDoor) {
			var deleteDoorAction = new DeleteDoorAction(this.activePlan);
			this.do(deleteDoorAction);
		}
		if (this.activePlan.selectedPolygons.length > 0) {
			var deletePolygonAction = new DeletePolygonAction(this.activePlan);
			this.do(deletePolygonAction);
		}
	};
	this.addPolygon=function(polygon) {
		var addPolygonAction = new AddPolygonAction(polygon, this.activePlan);
		this.do(addPolygonAction);
	};
    this.serialize=function() {
        var serialized = {};
        serialized['plans'] = [];
        for (var p in this.plans) {
            var plan = this.plans[p];
            serialized['plans'].push(plan.serialize());
        }
        return serialized;
    };
    this.deserialize=function(serialized) {
        for (var p in this.plans) {
            var plan = this.plans[p];
            paperEvents.deletePlanTabById(plan.id);
            plan.remove();
        }
        this.plans = [];
        for (var p in serialized.plans) {
            var id = parseInt(p);
            var serializedPlan = serialized.plans[p];
            var plan = new Plan(id);
            paperEvents.addPlanTab(id, serializedPlan.name, true);
            if (this.activePlan) this.activePlan.deactivate();
            plan.activate();
            this.activePlan = plan;
            plan.deserialize(serializedPlan);
            this.plans.push(plan);
        }
        paperEvents.activatePlanById(0);
    };
}

var project = new Project();

function Door(point, orientation) {
	this.isBeingDrawn = true;
	this.orientation = orientation;
	//this.center = point;
	this.polygons = [];
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
	this.moveDraw=function(newProjection) {
		this.path.position = newProjection;
		this.rotate(newProjection.orientation);
	};
	this.finishDraw=function() {
		for (var d = 0; d < project.activePlan.doors.length-1; d++) {
			var intersections = project.activePlan.doors[d].path.getIntersections(this.path);
			if (intersections.length > 0) {
				//this.remove();
				return false;
			}
		}
		for (var i in project.activePlan.polygons) {
			var polygon = project.activePlan.polygons[i];
			var intersections = this.path.getIntersections(polygon.path);
			if (intersections.length > 1) {
				this.addPolygon(polygon);
			}
		}
		this.isBeingDrawn = false;
		return true;
	};
	this.select=function() {
		this.path.selected = true;
		project.activePlan.selectedDoor = this;
	};
	this.deselect=function() {
		if (!this==project.activePlan.selectedDoor) return;
		this.path.selected=false;
		project.activePlan.selectedDoor=null;
	};
	this.addPolygon=function(polygon) {
		if (!this.hasPolygon(polygon))
			this.polygons.push(polygon);
	};
	this.removePolygon=function(polygon) {
		for (var p = 0; p < this.polygons.length; p++) {
			if (this.polygons[p] == polygon) {
				this.polygons.splice(p, 1);
				return;
			}
		}
	};
	this.hasPolygon=function(polygon) {
		for (var p in this.polygons) {
			if (this.polygons[p] == polygon) return true;
		}
		return false;
	};
	this.hide=function(plan) {
		this.deselect();
		this.path.visible = false;
		this.pop(plan);
	};
	this.unhide=function(plan) {
		if (this.path.visible==false) {
			this.path.visible = true;
			plan.doors.push(this);
		}
	};
	
	this.remove=function(plan) {
		this.deselect();
		this.path.remove();
		this.path.door = null;
		var numPolygons = this.polygons.length;
		for (var i = 0; i < numPolygons; i++) {
			var polygon = this.polygons.pop();
			polygon.removeDoor(this);
		}
		this.pop(plan);
	};
	this.pop=function(plan) {
		for (var j in plan.doors) {
			if (this == plan.doors[j]) {
				plan.doors.splice(j, 1);
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
	this.serialize=function() {
        var serialized = {};
        serialized['pathPosition'] = {'x':this.path.position.x, 'y':this.path.position.y};
        serialized['orientation'] = this.orientation;
        return serialized;
    };
    this.deserialize=function(serialized) {
        this.path.position = new Point(serialized['pathPosition']);
        this.rotate(serialized['orientation']);
        this.finishDraw();
        for (var i in this.polygons) {
			var polygon = this.polygons[i];
			polygon.addDoor(this);
		}
    };
}
	
function Polygon(point) {
	var snappedPoint = snapToGrid(point);
	this.path = new Path({strokeWidth: ROOM_PROPS.strokeWidth, strokeColor: ROOM_PROPS.drawingStrokeColor});		
	this.isBeingDrawn = true;
	this.path.add(snappedPoint);
	this.path.add(snappedPoint);
	this.path.polygon = this;
	
	this.decorations = [];
	this.doors = [];
	this.roomNameText = null;
	
	
	/* 
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
	}; */
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
			this.addIntersectedDoors();
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
	this.addIntersectedDoors=function() {
		var plan = project.activePlan;
		for (var i in plan.doors) {
			var door = plan.doors[i];
			var intersections = this.path.getIntersections(door.path);
			if (intersections.length > 1) {
				this.addDoor(door);
				door.addPolygon(this);
			}
		}
	};
	this.hide=function(plan) {
		this.path.selected=false;
		this.path.visible = false;
		var numDecorations = this.decorations.length;
		for (var d = 0; d < numDecorations; d++){
			var decoration = this.decorations[d];
			decoration.visible = false;
		}
		var numDoors = this.doors.length
		for (var d = 0; d < numDoors; d++){
			var door = this.doors[d];
			door.removePolygon(this);
		}
		this.pop(plan);
	};
	this.unhide=function(plan) {
		if (this.path.visible==false) {
			this.path.visible = true;
			var numDecorations = this.decorations.length;
			for (var d = 0; d < numDecorations; d++){
				var decoration = this.decorations[d];
				decoration.visible = true;
			}
			var numDoors = this.doors.length
			for (var d = 0; d < numDoors; d++){
				var door = this.doors[d];
				door.addPolygon(this);
			}
			plan.polygons.push(this);
		}
	};
	
	
	this.remove=function(plan) {
		this.path.remove();
		var numDecorations = this.decorations.length;
		for (var d = 0; d < numDecorations; d++){
			var decoration = this.decorations.pop();
			decoration.remove();
		}
		this.path.polygon = null;
		this.path = null;
		this.pop(plan);
	};
	this.removeDoor=function(door) {
		for (var j in this.doors) {
			if (door == this.doors[j]) {
				this.doors.splice(j, 1);
				break;
			}
		}
	};
	this.addDoor=function(door) {
		if (!this.hasDoor(door))
			this.doors.push(door);
	};
	this.hasDoor=function(door) {
		for (var d in this.doors) {
			if (this.doors[d] == door) return true;
		}
		return false;
	};
	this.pop=function(plan) {
		for (var j in project.activePlan.polygons) {
			if (this == project.activePlan.polygons[j]) {
				project.activePlan.polygons.splice(j, 1);
				break;
			}
		}
	};
	this.popSelected=function() {
		for (var j in project.activePlan.selectedPolygons) {
			if (this == project.activePlan.selectedPolygons[j]) {
				project.activePlan.selectedPolygons.splice(j, 1);
				break;
			}
		}
	};

	this.select=function() {
		this.path.selected = true;
		project.activePlan.selectedPolygons.push(this);
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
		project.activePlan.decorationsLayer.activate();
		this.roomNameText = new PointText(minPoint);
		this.decorations.push(this.roomNameText);
		this.roomNameText.fillColor = 'black'; this.roomNameText.fontSize = 10; this.roomNameText.fontWeight= 'bold'; 
		this.roomNameText.content = ROOM_NAME;
		project.activePlan.polygonsLayer.activate();
	};
	this.changeRoomName = function(name) {
		this.roomNameText.content = name;
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
    this.serialize=function() {
        var serialized = {};
        serialized['path'] = [];
        for (var s in this.path.segments) {
            var segment = this.path.segments[s];
            var point = segment.point;
            serialized['path'].push({'x':point.x, 'y':point.y});
        }
        serialized['roomName'] = this.roomNameText.content;
        
        return serialized;
    };
    this.deserialize=function(serialized) {
        this.path.removeSegment(1);
        for (var p = 1; p < serialized.path.length; p++) {
            var point = serialized.path[p];
            this.path.add(point);
        }
        this.isBeingDrawn = false;
        this.path.fillColor = ROOM_PROPS.fillColor;
        this.path.strokeColor = ROOM_PROPS.strokeColor;
        this.addDecorationText();
        this.changeRoomName(serialized['roomName']);
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
		if (project.activePlan.motionPoint) {
			var delta = snapToGrid(event.point - project.activePlan.motionPoint);
			if (delta.x != 0 || delta.y != 0) {
				project.activePlan.motionPoint += delta;
				var moveAction = new MoveAction(project.activePlan.selectedPolygons, delta);
				project.do(moveAction);
			}
		}
	} else if (TOOL_TYPE == 'room') {
		var numPolygons = project.activePlan.polygons.length;
		if (numPolygons > 0) {
			project.activePlan.polygons[numPolygons-1].moveDraw(event.point);
		}
	} else if (TOOL_TYPE == 'door') {
		var lastDoor = project.activePlan.getLastDoor();
		var hit = project.activePlan.polygonsLayer.hitTest(event.point);
		if (hit && hit.item.polygon)
			var projectedPoint = hit.item.polygon.getProjection(event.point);
		if (hit && hit.item.polygon && projectedPoint) { //we're hitting a polygon
			if (!lastDoor || !lastDoor.isBeingDrawn) {
				var door = new Door(projectedPoint, projectedPoint.orientation);
				project.activePlan.doors.push(door);
			} else {
				lastDoor.moveDraw(projectedPoint);
			}	
		} else if ( lastDoor && lastDoor.isBeingDrawn) {
			lastDoor.remove(project.activePlan);
		}
	}
}

function onMouseDown(event) {
	if (TOOL_TYPE == 'move') {
		var hit = project.activePlan.doorsLayer.hitTest(event.point);
		if (hit) {
			if (!hit.item.selected) {
				project.activePlan.deselectAll();
				var door = hit.item.door;
				door.select();
			}
		} else {
			hit = project.activePlan.polygonsLayer.hitTest(event.point);
			if (hit) {
				project.activePlan.motionPoint = event.point;
				if (!hit.item.selected && !project.activePlan.multipleSelection) {
					project.activePlan.deselectAll();
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
		project.activePlan.motionPoint = null;
		if (pointEquals(event.point, event.downPoint)) {
			if (project.activePlan.selectedDoor) {
				var hit = project.activePlan.doorsLayer.hitTest(event.point);
				if (hit) {
					if (!hit.item.selected) {
						project.activePlan.deselectAll();
						var door = hit.item.door;
						door.select();
					}
				} else {
					project.activePlan.deselectAll();
				}
			} else {
				var hit = project.activePlan.polygonsLayer.hitTest(event.point);
				if (hit) {
					var polygon = hit.item.polygon;
					if (project.activePlan.multipleSelection) {
						if (hit.item.selected) polygon.deselect();
						else polygon.select();
					} else {
						project.activePlan.deselectAll();
						polygon.select();
					}
				} else if (!project.activePlan.multipleSelection) {
					project.activePlan.deselectAll(); 
				}
			}
		} else {
			project.finalizeMoveAction();
		}
	} else if (TOOL_TYPE == 'room') {
		var lastPolygon = project.activePlan.getLastPolygon();
		if (lastPolygon && lastPolygon.isBeingDrawn) {
			lastPolygon.addPoint(event.point);
			if (!lastPolygon.isBeingDrawn) { // finished drawing
				project.addPolygon(lastPolygon);
			}
		} else if (pointEquals(event.point, event.downPoint)) {
			var hit = project.activePlan.polygonsLayer.hitTest(event.point);
			if (!hit ) {
				var polygon = new Polygon(event.point);
				project.activePlan.polygons.push(polygon);
			}
		}
	} else if (TOOL_TYPE == 'door') {
		var lastDoor = project.activePlan.getLastDoor();
		if (lastDoor && lastDoor.isBeingDrawn) {
			if (lastDoor.finishDraw()) {
				var addDoorAction = new AddDoorAction(lastDoor, project.activePlan);
				project.do(addDoorAction);
			}
		}
	}
	
	/* console.log('project.activePlan.polygons:');
	console.log(project.activePlan.polygons);
	console.log('Selected project.activePlan.polygons: ');
	console.log(project.activePlan.selectedPolygons); */
}

var commandListener = false;
var shiftListener = false;
function onKeyDown(event) {
	if (event.key == 'delete') {
		project.delete();
	} else if (event.key == 'escape') {
		var lastPolygon = project.activePlan.getLastPolygon();
		if (lastPolygon && lastPolygon.isBeingDrawn) {
			lastPolygon.remove(project.activePlan);
			
		}
	} else if (event.key == 'shift') {
		project.activePlan.multipleSelection = true;
		shiftListener = true;
	} else if (event.key == 'control' || event.key == 'command') {
		commandListener = true;
	} else if (commandListener && shiftListener && event.key == 'z') {
		project.redo();
	} else if (commandListener && event.key == 'z') {
		project.undo();
	} else if (event.key == 'l') {
		console.log('Polygons');
		for (var p in project.activePlan.polygons)
			console.log(''+project.activePlan.polygons[p]);
		console.log('Doors');
		for (var d in project.activePlan.doors)
			console.log(''+project.activePlan.doors[d]);
	} else if (event.key == 's') {
        console.log(JSON.stringify(project.serialize()));
    }
}

function onKeyUp(event) {
	if (event.key == 'shift') {
		project.activePlan.multipleSelection = false;
		shiftListener = false;
	} else if (event.key == 'control' || event.key == 'command') {	
		commandListener = false;
	}
}

paperEvents.onRoomNameChange = function(newName) {
	ROOM_NAME = newName;
	if (project.activePlan.selectedPolygons.length > 0) {
		for (var i in project.activePlan.selectedPolygons){
			project.activePlan.selectedPolygons[i].changeRoomName(ROOM_NAME);
		}
	}
}

paperEvents.onDrawTypeChange = function(newType) {
	if (TOOL_TYPE == 'move') {
		project.activePlan.deselectAll(); //move to tool_type change
	}
	if (newType == 'door') {
		project.activePlan.doorsLayer.activate();
	} else {
		project.activePlan.polygonsLayer.activate();
	}
	TOOL_TYPE = newType;
}

paperEvents.onAddPlan=function() {
	return project.addPlan();
}

paperEvents.onActivatePlan=function(planId) {
	return project.activatePlan(planId);
}

paperEvents.onDeletePlan=function(planId) {
	return project.deletePlan(planId);
}
paperEvents.onUndo=function() {
	project.undo();
}
paperEvents.onRedo=function() {
	project.redo();
}
paperEvents.onSave=function() {
    return JSON.stringify(project.serialize());
}
paperEvents.onLoad=function(jsonStr) {
    project.deserialize(JSON.parse(jsonStr));
} 