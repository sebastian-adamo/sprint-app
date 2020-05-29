let teamId;

function displayTeams() {
    $('#content-container').load(' #teams-row > *');
}

function displayTeamDetails(id) {
    teamId = id;
    getTeamBoards();
    $('#content-container').load(' #team-details-row > *');
}

function createTeam() {
    let name, description;

    name = $('#create-team-name');
    description = $('#create-team-description');


    if (name !== '') {
        $.ajax({
            url: "/team/create?name=" + name.val() + "&description=" + description.val(),
            success: function() {
                $('#content-container').load(' #teams-row > *');
                name.val('');
                description.val('');
                $('.close-modal').trigger('click');
            }
        })
    }
}

function getTeamBoards() {
    $.ajax({
        url: "/team/getBoards?id=" + teamId,
        success: function(result) {
            $('#team-boards-grid').empty();
            for (let i = 0; i < result.length; i++) {
                $('#team-boards-grid').prepend(
                    '<div class="module">\n' +
                    '<div style="width: 100%; height: 100%" class="card list-card boards-card">\n' +
                    '<a href="/tasks?id=' + result[i].id + '" style="text-decoration: none; color: #0f0f0f; display: block; height: 100%">\n' +
                    '<div style="height: 75%; text-align: center; padding-top: 30%" class="card-body">\n' +
                    '<p class="card-text">' + result[i].name + '</p>\n' +
                    '</div>\n' +
                    '</a>\n' +
                    '<div class="card-footer">\n' +
                    '<a class="material-icons" style="text-decoration: none; color: black" href="#edit-my-board-modal" rel="modal:open"><i class="material-icons">create</i></a>\n' +
                    '<i class="material-icons" onclick="deleteTeamBoard(\'' + result[i].id + '\')">delete</i>\n' +
                    '</div>\n' +
                    '</div>\n' +
                    '</div>'
                );
            }
        }
    })
}

function createTeamBoard() {
    var name, description, dod;

    name = $('#create-team-board-name');
    description = $('#create-team-board-description');
    dod = $('#create-team-board-dod');

    if (name !== '') {
        $.ajax({
            url: "/team/createBoard?id=" + teamId +  "&name=" + name.val() + "&description=" + description.val() + "&dod=" + dod.val(),
            success: function() {
                getTeamBoards();
                name.val('');
                description.val('');
                dod.val('');
                $('.close-modal').trigger('click');
            }
        })
    }
    else {
        // Change
        alert("Please enter a board name.")
    }
}

function deleteTeamBoard(id) {
    $.ajax({
        url: "/boards/delete?id=" + id,
        success: function() {
            getTeamBoards();
        }
    })
}

function getTeamDetails() {
    $.ajax({
        url: "/team/getDetails?id=" + teamId,
        success: function(result) {
            $('#team-name').val(result.name);
            $('#team-description').val(result.description);
        }
    })
}

function saveTeamDetails() {
    let name, description;

    name = $('#team-name').val();
    description = $('#team-description').val();

    $.ajax({
        url: "/team/saveDetails?id=" + teamId + "&name=" + name + "&description=" + description,
        success: function() {
            alert("Team details have been saved.")
        }
    })
}

function deleteTeam() {
    $.ajax({
        url: "/team/delete?id=" + teamId ,
        success: function() {
            $('#content-container').load(' #teams-row > *');
        }
    })
}

function getTeamMembers() {
    $.ajax({
        url: "/team/getMembers?id=" + teamId,
        success: function(result) {
            $('#team-members-table').empty();
            for (let i = 0; i < result.length; i++) {
                $('#team-members-table').append(
                    '<tr>' +
                    '<th scope="row">Pic</th>' +
                    '<td>' + result[i].name + '</td>' +
                    '<td>' + result[i].username + '</td>' +
                    '<td>' + result[i].role + '</td>' +
                    '<td>Active</td>' +
                    '</tr>'
                );
            }
        }
    })

}