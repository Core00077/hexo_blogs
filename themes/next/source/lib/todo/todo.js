$(".post-body #todo ul li").addClass("md-task-list-item task-list-item")
$(".post-body #todo ul li").find("input").filter("[checked]").parent().addClass("task-list-done")
$(".post-body #todo ul li").find("input").not("[checked]").parent().addClass("task-list-not-done")