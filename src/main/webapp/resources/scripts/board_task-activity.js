function getTaskActivity() {
    $.ajax({
        url: "/comment/getAll?id=" + currentTaskId,
        success: function(result) {
            $('#task-comment-list').empty();
            for (let i = 0; i < result.length; i++) {
                prependMyComment(result[i]);
            }
        }
    })
}

function prependMyComment(comment) {
    $('#task-comment-list').prepend(
        '<li>' +
        '<div class="commenterImage">' +
        '<i class="material-icons">account_circle</i>' +
        '</div>' +
        '<div class="commentText">' +
        '<span class="date sub-text">' +
        '<p style="text-align: left">' + comment.username + ' on ' + comment.formattedDate + '</p>' +
        '</span>' +
        '<p style="word-break: break-word; text-align: left">' + comment.description + '</p>' +
        '<span class="date sub-text">' +
        '<p style="text-align: left"><span class="comment-edit">Edit</span> - <span class="comment-edit" onclick="deleteTaskComment(\'' + comment.id + '\')">Delete</span></p>' +
        '</span>' +
        '</div>' +
        '</li>'
    );
}

function prependComment(comment) {
    $('#task-comment-list').prepend(
        '<li>' +
        '<div class="commenterImage">' +
        '<i class="material-icons">account_circle</i>' +
        '</div>' +
        '<div class="commentText">' +
        '<span class="date sub-text">' +
        '<p style="text-align: left">' + comment.username + ' on ' + comment.formattedDate + '</p>' +
        '</span>' +
        '<p style="word-break: break-word; text-align: left">' + comment.description + '</p>' +
        '<span class="date sub-text">' +
        '</span>' +
        '</div>' +
        '</li>'
    );
}

function addTaskComment() {
    let description = $('#task-activity-comment');

    if (description.val() !== '') {
        $.post({
            url: "/comment/add?id=" + currentTaskId + "&description=" + description.val(),
            success: function() {
                description.val('');
                getTaskActivity();
            }
        })
    }
}

function deleteTaskComment(id) {
    $.ajax({
        url: "/comment/delete?id=" + id,
        type: 'DELETE',
        success: function() {
            getTaskActivity();
        }
    })
}