$(".dropdown-menu a").click(function(){
	var gradeText = $(this).parents(".dropdown").find('.gradeChosen').text($(this).text());
	
});

function deleteTab(event) {
	var planId = $(this).prev('.tabBtn').attr('id');
	planId = parseInt(planId.substring(planId.search('-')+1, planId.length));
	$(this).parent().remove();
	var activatePlanId = paperEvents.onDeletePlan(planId);
	if (activatePlanId != -1) {
		var tabBtn = $('#plan-'+activatePlanId);
		if (!tabBtn.hasClass('active')) tabBtn.addClass('active');
	}
	
}
$('#undoBtn').click(function(event) {
	paperEvents.onUndo();
});

$('#redoBtn').click(function(event) {
	paperEvents.onRedo();
});

$(".tabOptionBtn.delete").click(deleteTab);
var planHtml = "<div class=\"btn btn-secondary planTab\"> \
				<span class=\"btn btn-secondary tabBtn\" id=\"plan-planid\" autocomplete=\"off\"> <input type=\"text\" name=\"planName\" value=\"planname\" />	</span>	\
				<span class=\"btn-secondary tabOptionBtn delete\" autocomplete=\"off\"> <i class=\"fa fa-trash\">&nbsp;</i></span> \
			</div>";
$(".tabOptionBtn.add").click(function(event) {
	var planId = paperEvents.onAddPlan();
	$(".tabBtn.active").removeClass("active");
	var planTab = $(planHtml.replace(/planid/g, '' + planId).replace(/planname/g, 'Plan-' + planId));
    planTab.insertBefore(this);
	var tabBtn = planTab.children('.tabBtn');
    tabBtn.addClass('active');
	tabBtn.click(activateTab);
	var tabBtnDelete = planTab.children(".delete");
	tabBtnDelete.click(deleteTab);
	event.stopPropagation();
});

function activateTab(event) {
	$(".tabBtn.active").removeClass("active");
	$(this).addClass("active");
	var planId = $(this).attr('id');
	planId = parseInt(planId.substring(planId.search('-')+1, planId.length));
	paperEvents.onActivatePlan(planId);
}
paperEvents['activatePlanById'] = function(id) {
    $(".tabBtn.active").removeClass("active");
	var tabBtn = $('.tabBtn#plan-'+id);
    tabBtn.addClass("active");
	paperEvents.onActivatePlan(id);
};
paperEvents['getPlanNameById'] = function(id) {
    return $('.tabBtn#plan-'+id).children('input').val();
};
paperEvents['deletePlanTabById'] = function(id) {
	$('.tabBtn#plan-'+id).parent().remove();
};
paperEvents['addPlanTab'] = function(id, name, activate) {
	var planId = id;
    var addButton = $(".tabOptionBtn.add");
    var planTab = $(planHtml.replace(/planid/g, '' + planId).replace(/planname/g, name));
	planTab.insertBefore(addButton);
	var tabBtn = planTab.children('.tabBtn');
    if (activate) {
        $(".tabBtn.active").removeClass("active");
        tabBtn.addClass('active');
    }
	tabBtn.click(activateTab);
	var tabBtnDelete = planTab.children(".delete");
	tabBtnDelete.click(deleteTab);
};

$(".tabBtn").click(activateTab);
