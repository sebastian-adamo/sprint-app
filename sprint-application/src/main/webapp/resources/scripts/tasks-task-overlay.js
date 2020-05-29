let currentTaskId;

function getTaskDetails(id) {
    currentTaskId = id;
    $.ajax({
        url: "/tasks/get?id=" + id,
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

function saveTaskName() {
    let name = $('#task-name').val();

    $.ajax({
        url: "/tasks/saveName?id=" + currentTaskId + "&name=" + name,
        success: function() {
            $('#list-row').load(' #list-row > *');
        }
    })
}

function saveTaskDescription() {
    let description = $('#task-description').val();

    $.ajax({
        url: "/tasks/saveDescription?id=" + currentTaskId + "&description=" + description,
        success: function() {
            $('#list-row').load(' #list-row > *');
        }
    })
}

function updateDod() {
    $.ajax({
        url: "/tasks/updateDod?id=" + currentTaskId,
    })
}

function setTaskDueDate() {
    let due = $('#task-due-date').val();

    $.ajax({
        url: "/tasks/setDue?id=" + currentTaskId + '&due=' + due,
        success: function() {
            $('#list-row').load(' #list-row > *');
        }
    })
}

function getTaskProgress() {
    $.ajax({
        url: "/tasks/getProgress?id=" + currentTaskId,
        success: function(result) {
            document.getElementById("task-progress-bar").textContent = result + "%";
            document.getElementById("task-progress-bar").setAttribute("style", "width: " + result + "%");
            $('#list-row').load(' #list-row > *');
        }
    });

    $.ajax({
        url: "/tasks/getTodos?id=" + currentTaskId,
        success: function(result) {
            $('#task-todo-list').empty();
            for (let i = 0; i < result.length; i++) {
                $('#task-todo-list').append(
                '<li>' +
                    '<div style="width: 350px; margin-left: 2rem" class="round">' +
                        '<input type="checkbox" id="todo-checkbox-'+ result[i].id +'"/>' +
                        '<label for="todo-checkbox-'+ result[i].id +'"  onclick="updateTodo(\'' + result[i].id + '\')"></label>' +
                        '<span style="float: left; margin-left: 2.5rem; padding-top: 3px">' + result[i].description + '</span>' +
                    '</div>' +
                '</li>'
                );

                if (result[i].complete) {
                    $("#todo-checkbox-" + result[i].id).prop("checked", true);

                }
                else {
                    $("#todo-checkbox-" + result[i].id).prop("checked", false);
                }
            }
        }
    })
}

function updateTodo(id) {
    $.ajax({
        url: "/tasks/updateTodo?id=" + id,
        success: function() {
            getTaskProgress();
            $('#list-row').load(' #list-row > *');
        }
    })
}

function addTaskTodo() {
    let todo = $('#new-task-todo').val();
    if (todo !== '') {
        $.ajax({
            url: "/tasks/addTodo?id=" + currentTaskId + '&description=' + todo,
            success: function() {
                $('#new-task-todo').val('');
                getTaskProgress();
                $('#list-row').load(' #list-row > *');
            }
        })
    }
}

function getTaskActivity() {
    $.ajax({
        url: "/tasks/getActivity?id=" + currentTaskId,
        success: function(result) {
            $('#task-comment-list').empty();
            for (let i = 0; i < result.length; i++) {
                $('#task-comment-list').prepend(
                    '<li>' +
                    '<div class="commenterImage">' +
                    '<i class="material-icons">account_circle</i>' +
                    '</div>' +
                    '<div class="commentText">' +
                    '<span class="date sub-text">' +
                    '<p style="text-align: left">' + result[i].username + '</p>' +
                    '</span>' +
                    '<p style="word-break: break-word; text-align: left">' + result[i].description + '</p>' +
                    '<span class="date sub-text">' +
                    '<p style="text-align: left">' + result[i].formattedDate + '</p>' +
                    '</span>' +
                    '</div>' +
                    '</li>'
                );
            }
        }
    })
}

function addTaskComment() {
    let description = $('#task-activity-comment').val();

    console.log(description);

    $.ajax({
        url: "/tasks/addComment?id=" + currentTaskId + "&description=" + description,
        success: function(result) {
            $('#task-activity-comment').val('');
            $('#task-comment-list').prepend(
                '<li>' +
                '<div class="commenterImage">' +
                '<i class="material-icons">account_circle</i>' +
                '</div>' +
                '<div class="commentText">' +
                '<p style="word-break: break-word; text-align: left">' + result.description + '</p>' +
                '<span class="date sub-text">' +
                '<p style="text-align: left">' + result.username + '</p>' +
                '<p style="text-align: left">' + result.formattedDate + '</p>' +
                '</span>' +
                '</div>' +
                '</li>'
            );
        }
    })
}