function getTaskDetails(id) {
    currentTaskId = id;
    $.ajax({
        url: "/task/get?id=" + id,
        success: function(result) {
            $('#task-name').val(result.name);
            $('#task-description').val(result.description);

            if (result.dod) {
                $("#task-dod").prop("checked", true);
            }
            else {
                $("#task-dod").prop("checked", false);
            }

            $('#task-due-date').val(result.due);
        }
    })
}

function updateTaskName() {
    let name = $('#task-name').val();

    $.ajax({
        url: "/task/updateName?id=" + currentTaskId + "&name=" + name,
        type: 'PUT',
        success: function() {
            $('#list-row').load(' #list-row > *');
        }
    })
}

function updateTaskDescription() {
    let description = $('#task-description').val();

    $.ajax({
        url: "/task/updateDescription?id=" + currentTaskId + "&description=" + description,
        type: 'PUT',
        success: function() {
            $('#list-row').load(' #list-row > *');
        }
    })
}

function updateTaskDoD() {
    $.ajax({
        url: "/task/updateDod?id=" + currentTaskId,
        type: 'PUT',
    })
}

function updateTaskDueDate() {
    let due = $('#task-due-date').val();

    $.ajax({
        url: "/task/updateDue?id=" + currentTaskId + '&due=' + due,
        type: 'PUT',
        success: function() {
            $('#list-row').load(' #list-row > *');
        }
    })
}