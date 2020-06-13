function getTaskProgress() {
    $.ajax({
        url: "/task/getProgress?id=" + currentTaskId,
        success: function(result) {
            document.getElementById("task-progress-bar").textContent = result + "%";
            document.getElementById("task-progress-bar").setAttribute("style", "width: " + result + "%");
            $('#list-row').load(' #list-row > *');
        }
    });

    $.ajax({
        url: "/todo/getAll?id=" + currentTaskId,
        success: function(result) {
            $('#task-todo-list').empty();
            for (let i = 0; i < result.length; i++) {
                $('#task-todo-list').append(
                    '<li>' +
                    '<div style="width: 350px; margin-left: 2rem" class="round">' +
                    '<input type="checkbox" id="todo-checkbox-'+ result[i].id +'"/>' +
                    '<label for="todo-checkbox-'+ result[i].id +'"  onclick="updateTaskTodo(\'' + result[i].id + '\')"></label>' +
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

function addTaskTodo() {
    let todo = $('#new-task-todo').val();
    if (todo !== '') {
        $.post({
            url: "/todo/add?id=" + currentTaskId + '&description=' + todo,
            success: function() {
                $('#new-task-todo').val('');
                getTaskProgress();
                $('#list-row').load(' #list-row > *');
            }
        })
    }
}

function updateTaskTodo(id) {
    $.ajax({
        url: "/todo/update?id=" + id,
        type: 'PUT',
        success: function() {
            getTaskProgress();
            $('#list-row').load(' #list-row > *');
        }
    })
}