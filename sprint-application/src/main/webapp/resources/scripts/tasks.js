// Tasks
function tasks() {
    $('#content-container').load(' #content-container > *');
}

function reloadLists() {
    $('#list-row').load(' #list-row > *');
}

function deleteTask(id) {
    $.ajax({
        url: "/tasks/delete?id=" + id,
        success: function(result) {
            reloadLists();
        }
    })
}

function addToBacklog() {
    var backlogTask = document.getElementById("new-backlog-task").value;
    if(backlogTask.length !== 0) {
        $.ajax({
            url: "/tasks/add/backlog?name=" + backlogTask,
            success: function(result) {
                reloadLists();
            }
        })
    }
}

function addToTodo() {
    var todoTask = document.getElementById("new-todo-task").value;
    if(todoTask.length !== 0) {
        $.ajax({
            url: "/tasks/add/todo?name=" + todoTask,
            success: function (result) {
                reloadLists();
            }
        })
    }
}

function addToInprogress() {
    var inprogressTask = document.getElementById("new-inprogress-task").value;
    if(inprogressTask.length !== 0) {
        $.ajax({
            url: "/tasks/add/inprogress?name=" + inprogressTask,
            success: function (result) {
                reloadLists();
            }
        })
    }
}

function addToComplete() {
    var completeTask = document.getElementById("new-complete-task").value;
    if(completeTask.length !== 0) {
        $.ajax({
            url: "/tasks/add/complete?name=" + completeTask,
            success: function (result) {
                reloadLists();
            }
        })
    }
}

function getTaskId(id) {
    $(".ul-list").attr('spid', id);
}

$('#list-row').hover(function(){
    var backlog, todo, inprogress, complete;

    backlog = document.getElementById("backlog-list");
    todo = document.getElementById("todo-list");
    inprogress = document.getElementById("inprogress-list");
    complete = document.getElementById("complete-list");

    var sortable = Sortable.create(backlog, {
        group: "lists",
        animation: 300,
        onEnd: function (evt) {
            var id, from, to, pos;

            id = $('.ul-list').attr('spid');
            from = evt.from.id;
            to = evt.to.id;
            pos = evt.newIndex;

            if (from === to) {
                movePosition(id, pos, to);
            }
            else {
                moveTask(id, pos, to);
            }
        }
    });
    var sortable1 = Sortable.create(todo, {
        group: "lists",
        animation: 300,
        onEnd: function (evt) {
            var id, from, to, pos;

            id = $('.ul-list').attr('spid');
            from = evt.from.id;
            to = evt.to.id;
            pos = evt.newIndex;

            if (from === to) {
                movePosition(id, pos, to);
            }
            else {
                moveTask(id, pos, to);
            }
        }
    });
    var sortable2 = Sortable.create(inprogress, {
        group: "lists",
        animation: 300,
        onEnd: function (evt) {
            var id, from, to, pos;

            id = $('.ul-list').attr('spid');
            from = evt.from.id;
            to = evt.to.id;
            pos = evt.newIndex;

            if (from === to) {
                movePosition(id, pos, to);
            }
            else {
                moveTask(id, pos, to);
            }
        }
    });
    var sortable3 = Sortable.create(complete, {
        group: "lists",
        animation: 300,
        onEnd: function (evt) {
            var id, from, to, pos;

            id = $('.ul-list').attr('spid');
            from = evt.from.id;
            to = evt.to.id;
            pos = evt.newIndex;

            if (from === to) {
                movePosition(id, pos, to);
            }
        }
    });
});

function movePosition(id, pos, list) {
    $.ajax({
        url: "/tasks/position?id=" + id + "&position=" + pos + "&list=" + list,
        success: function (result) {
            reloadLists();
        }
    })
}

function moveTask(id, pos, list) {
    $.ajax({
        url: "/tasks/move?id=" + id + "&position=" + pos + "&list=" + list,
        success: function(result) {
            reloadLists();
        }
    })
}

// Task Overlay
function taskOverlayOn(id) {
    if($(".page-wrapper").hasClass("toggled") === true) {
        $(".page-wrapper").removeClass("toggled");
    }

    $.ajax({
            url: "/tasks/get?id=" + id,
            success: function(result) {
                // Details Panel
                document.getElementById("card-overlay-taskid").textContent = id;
                document.getElementById("task-overlay-name").value = result.name;
                document.getElementById("task-overlay-description").value = result.description;

                if (result.dod) {
                    $("#task-overlay-dod").prop("checked", true);
                }
                else {
                    $("#task-overlay-dod").prop("checked", false);
                }

                if (result.complete) {
                    $("#task-overlay-complete").prop("checked", true);
                }
                else {
                    $("#task-overlay-complete").prop("checked", false);
                }

                document.getElementById("task-progress-bar").textContent = result.progress + "%";
                document.getElementById("task-progress-bar").setAttribute("style", "width: " + result.progress + "%");
                document.getElementById("due-date").value = result.due;
                // Activity Panel
                $('#task-new-comment').val('');
                $('#task-comment-list').empty();
                for(let step=0; step<result.comments.length; step++) {
                    $("#task-comment-list").append('<li>\n' +
                        '<div class="commenterImage">\n' +
                        '<i class="material-icons">account_circle</i>\n' +
                        '</div>\n' +
                        '<div style="text-align: left" class="commentText">\n' +
                        '<p style="word-break: break-word" class="">' + result.comments[step].description + '</p>\n' +
                        '<span class="date sub-text">\n' +
                        '<p>' + result.comments[step].username + '</p>\n' +
                        '' + result.comments[step].formattedDate + '\n' +
                        '</span>\n' +
                        '</div>\n' +
                        '</li>');
                }
            }
        });
    document.getElementById("task-overlay").style.display = "block";
}
function taskOverlayOff() {
    document.getElementById("task-overlay").style.display = "none";
    document.getElementById("task-progress-bar").textContent = 0 + "%";
    document.getElementById("task-progress-bar").setAttribute("style", "width: " + 0 + "%");
}

function taskOverlayViewOnly(id) {
    if($(".page-wrapper").hasClass("toggled") === true) {
        $(".page-wrapper").removeClass("toggled");
    }
    $.ajax({
        url: "/tasks/get?id=" + id,
        success: function(result) {
            // Details Panel
            document.getElementById("card-overlay-vo-taskid").textContent = id;
            document.getElementById("task-overlay-vo-name").value = result.name;
            document.getElementById("task-overlay-vo-description").value = result.description;

            if (result.dod) {
                $("#task-overlay-vo-dod").prop("checked", true);
            }
            else {
                $("#task-overlay-vo-dod").prop("checked", false);
            }

            if (result.complete) {
                $("#task-overlay-vo-complete").prop("checked", true);
            }
            else {
                $("#task-overlay-vo-complete").prop("checked", false);
            }

            document.getElementById("task-progress-vo-bar").textContent = result.progress + "%";
            document.getElementById("task-progress-vo-bar").setAttribute("style", "width: " + result.progress + "%");
            document.getElementById("due-date-vo").value = result.due;
            // Activity Panel
            $('#task-vo-new-comment').val('');
            $('#task-vo-comment-list').empty();
            for(let step=0; step<result.comments.length; step++) {
                $("#task-vo-comment-list").append('<li>\n' +
                    '<div class="commenterImage">\n' +
                    '<i class="material-icons">account_circle</i>\n' +
                    '</div>\n' +
                    '<div style="text-align: left" class="commentText">\n' +
                    '<p style="word-break: break-word" class="">' + result.comments[step].description + '</p>\n' +
                    '<span class="date sub-text">\n' +
                    '<p>' + result.comments[step].username + '</p>\n' +
                    '' + result.comments[step].formattedDate + '\n' +
                    '</span>\n' +
                    '</div>\n' +
                    '</li>');
            }
        }
    });
    document.getElementById("task-overlay-view-only").style.display = "block";
}

function taskOverlayViewOnlyOff() {
    document.getElementById("task-overlay-view-only").style.display = "none";
    document.getElementById("task-progress-vo-bar").textContent = 0 + "%";
    document.getElementById("task-progress-vo-bar").setAttribute("style", "width: " + 0 + "%");
}

function saveTask() {
    let id, name, description, dod, complete;

    id = $("#card-overlay-taskid").html();
    name = $("#task-overlay-name").val();
    description = $("#task-overlay-description").val();

    dod = !!$('#task-overlay-dod').is(":checked");
    complete = !!$('#task-overlay-complete').is(":checked");

    $.ajax({
        url: "/tasks/save?id=" + id + "&name=" + name + "&description=" + description + "&dod=" + dod + "&complete=" + complete,
        success: function(result) {
            document.getElementById("task-progress-bar").textContent = result + "%";
            document.getElementById("task-progress-bar").setAttribute("style", "width: " + result + "%");
            reloadLists();
        }
    })
}

$( function() {
    $( "#due-date" ).datepicker();
});

function setTaskDueDate() {
    var id, date;
    id = $('#card-overlay-taskid').html();
    date = $('#due-date').val();

    $.ajax({
        url: "/tasks/date?id=" + id + "&date=" + date,
    });
}

function commentOnTask() {
    let id, comment;

    id = $("#card-overlay-taskid").html();
    comment = $('#task-new-comment').val();
    if (comment !== "") {
        $.ajax({
            url: "/tasks/comment?id=" + id + "&comment=" + comment,
            success: function(result) {
                $('#task-new-comment').val('');
                $("#task-comment-list").prepend('<li>\n' +
                    '<div class="commenterImage">\n' +
                    '<i class="material-icons">account_circle</i>\n' +
                    '</div>\n' +
                    '<div style="text-align: left" class="commentText">\n' +
                    '<p style="word-break: break-word" class="">' + result.description + '</p>\n' +
                    '<span class="date sub-text">\n' +
                    '<p>' + result.username + '</p>\n' +
                    '' + result.formattedDate + '\n' +
                    '</span>\n' +
                    '</div>\n' +
                    '</li>');
            }
        })
    }
}

function commentOnTaskViewOnly() {
    let id, comment;

    id = $("#card-overlay-vo-taskid").html();
    comment = $('#task-vo-new-comment').val();
    if (comment !== "") {
        $.ajax({
            url: "/tasks/comment?id=" + id + "&comment=" + comment,
            success: function(result) {
                $('#task-vo-new-comment').val('');
                $("#task-vo-comment-list").prepend('<li>\n' +
                    '<div class="commenterImage">\n' +
                    '<i class="material-icons">account_circle</i>\n' +
                    '</div>\n' +
                    '<div style="text-align: left" class="commentText">\n' +
                    '<p style="word-break: break-word" class="">' + result.description + '</p>\n' +
                    '<span class="date sub-text">\n' +
                    '<p>' + result.username + '</p>\n' +
                    '' + result.formattedDate + '\n' +
                    '</span>\n' +
                    '</div>\n' +
                    '</li>');
            }
        })
    }
}

function commentOnBoard() {
    let comment = $("#new-comment").val();
    if (comment !== "") {
        $.ajax({
            url: "/boards/comment?comment=" + comment,
            success: function(result) {
                $('#new-comment').val('');
                $('#comment-list').load(' #comment-list > *')
            }
        })
    }
}

function searchUserTask() {
    var email = document.getElementById("board-modal-search-bar").value;
    if(email !== '') {
        $.ajax({
            url: "/boards/users/search?email=" + email,
            success: function(result) {
                if (result === "fail") {
                    $('#board-modal-search-list').empty();
                }
                else {
                    $('#board-modal-search-list').empty();
                    $('#board-modal-search-list').append('<li class="list-group-item friend-overlay-list-item" onclick="addUserTask(\'' + result + '\')"> ' + result + "</li>");
                }

            }
        })
    }
}

function addUserTask(email) {
    var id = $("#board-modal-id").val();
    $.ajax({
        url: "/boards/users/add?id=" + id + "&email=" + email,
        success: function (result) {
            $('#board-modal-search-bar').val('');
            $('#board-modal-search-list').empty();
            $("#board-page-table").load(" #board-page-table > *");
        }
    })
}

function removeUserTask(email) {
    $.ajax({
        url: "/boards/users/remove?email=" + email,
        success: function (result) {
            $("#board-page-table").load(" #board-page-table > *");
        }
    })
}

function commentWithUsername(username) {
    $('#users-modal').modal('hide');
    $('#activity-modal').modal('show');
    $('#new-comment').html('@' + username + ' ');
}


// Polls
function polls() {
    $('#content-container').load(' #poll-row > *');
}

function createPoll() {
    var question, list;

    question = $('#create-poll-question').val();
    list = $('#create-poll-select').val();

    if(question  === '') {
        alert("Must enter a question.")
    }
    else {
        if(list === 'Choose from lists') {
            alert('Choose a list.')
        }
        else {
            $.ajax({
                url: "/poll/create?question=" + question + "&list=" + list,
                success: function (result) {
                    $('#poll-list').load(' #poll-list > *');
                    $('#create-poll-question').val('');
                    $('#create-poll-select').val('Choose from lists')
                }
            })
        }
    }
}

function getPoll(id) {
    $('#results').remove();
    $('#poll-id').text(id);
    $.ajax({
        url: "/poll/get?id=" + id,
        success: function (result) {
            $('#poll-question').text(result.question);
            $('#choices-list').empty();
            for (let i = 0; i < result.choices.length; i++) {
                $('#choices-list').append(
                    '<li>\n' +
                    '<div class="card list-card" onclick="vote(\'' + result.choices[i].id + '\')">\n' +
                    '<div class="card-body">\n' +
                    '<p class="card-text">' + result.choices[i].description + '</p>\n' +
                    '</div>\n' +
                    '</div>\n' +
                    '</li>'
                );
            }
        }
    })
}

function getResults(id) {
    $('#results').remove();
    var choices = [];
    var votes = [];

    $.ajax({
        url: "/poll/get?id=" + id,
        success: function (result) {
            $('#results-question').text(result.question);
            for (let i = 0; i < result.choices.length; i++) {
                choices.push(result.choices[i].description);
                votes.push(result.choices[i].votes);
            }
        }
    });
    $('#results-modal').modal('show');
    $('#chart-container').append('<canvas id="results" width="600" height="600"></canvas>');
    var ctx = document.getElementById('results');
    var myChart = new Chart(ctx, {
        type: 'horizontalBar',
        data: {
            labels: choices,
            datasets: [{
                label: '# of Votes',
                data: votes,
                backgroundColor:
                    'rgba(54, 162, 235, 0.2)',
                borderColor:
                    'rgba(54, 162, 235, 1)',
                borderWidth: 1
            }]
        },
        options: {
            scales: {
                xAxes: [{
                    ticks: {
                        beginAtZero: true,
                        precision: 0
                    }
                }]
            }
        }
    });
}

function vote(id) {
    $.ajax({
        url: "/poll/vote?poll= " + $('#poll-id').text() + "&id=" + id,
        success: function (result) {
            $('#poll-list').load(' #poll-list > *');
            results();
        }
    })
}

function results() {
    var id = $('#poll-id').text();
    var choices = [];
    var votes = [];

    $.ajax({
        url: "/poll/get?id=" + id,
        success: function (result) {
            for (let i = 0; i < result.choices.length; i++) {
                choices.push(result.choices[i].description);
                votes.push(result.choices[i].votes);
            }
        }
    });
    $('#poll-modal').modal('hide');
    $('#results-modal').modal('show');
    $('#chart-container').append('<canvas id="results" width="600" height="600"></canvas>');
    var ctx = document.getElementById('results');
    var myChart = new Chart(ctx, {
        type: 'horizontalBar',
        data: {
            labels: choices,
            datasets: [{
                label: '# of Votes',
                data: votes,
                backgroundColor:
                    'rgba(54, 162, 235, 0.2)',
                borderColor:
                    'rgba(54, 162, 235, 1)',
                borderWidth: 1
            }]
        },
        options: {
            scales: {
                xAxes: [{
                    ticks: {
                        beginAtZero: true,
                        precision: 0
                    }
                }]
            }
        }
    });
}

function deletePoll(id) {
    $.ajax({
        url: "/poll/delete?id=" + id,
        success: function (result) {
            $('#poll-list').load(' #poll-list > *');
        }
    })
}

// Documents
function documents() {
    $('#content-container').load(' #document-row > *');
}

