
function inviteUser(email) {
    var id = $("#board-overlay-id").val();
    $.ajax({
        url: "/boards/users/invite?id=" + id + "&email=" + email,
        success: function (result) {
            $('#board-search-bar').val('');
            $('#board-overlay-search-list').empty();
        }
    })
}

function acceptInvitation(id) {
    $.ajax({
        url: "/boards/accept?id=" + id,
        success: function (result) {
            $('#notification-list').load(' #notification-list > *');
            reloadBoards();
        }
    })
}

function declineInvitation(id) {
    $.ajax({
        url: "/boards/decline?id=" + id,
        success: function (result) {
            $('#notification-list').load(' #notification-list > *');
        }
    })
}

function removeUser(email) {
    $.ajax({
        url: "/boards/users/remove?email=" + email,
        success: function (result) {
            let id = document.getElementById('board-overlay-id').value;
            $('#board-overlay-table').empty();
            // Appending Details to Overlay
            $.ajax({
                url: "/boards/get?id=" + id,
                success: function (result) {
                    for (let step = 0; step < result.users.length; step++) {
                        if (result.users[step].fullname === null) {
                            result.users[step].fullname = "";
                        }
                        $('#board-overlay-table').append('<tr><th scope="row">' + result.users[step].username + '</th> <td>' + result.users[step].fullname + '</td> <td>' + result.users[step].email + '</td> <td><select class="custom-select custom-select-sm">\n' +
                            '  <option onclick="changeRole(\'' + result.users[step].email + ',' + result.users[step].role + '\')" selected>' + result.users[step].role + '</option>\n' +
                            '  <option onclick="changeRole(\'' + result.users[step].email + ',' + result.users[step].roleAlt + '\')" value="1">' + result.users[step].roleAlt + '</option>\n' +
                            '  <option onclick="changeRole(\'' + result.users[step].email + ',' + result.users[step].roleAlt1 + '\')" value="2">' + result.users[step].roleAlt1 + '</option>\n' +
                            '</select></td> ' +
                            '<td><i style="padding-left: 25%" class="material-icons" onclick="removeUser(\'' + result.users[step].email + '\')">delete_outline</i></td>');

                    }
                }
            })
        }
    });
}

// Sidebar functions
function toggleSidebar() {
    if($(".page-wrapper").hasClass("toggled") === false) {
        $("#show-sidebar").click(function() {
            $(".page-wrapper").addClass("toggled");
        });
    }
    else if ($(".page-wrapper").hasClass("toggled") === true) {
        $("#show-sidebar").click(function() {
            $(".page-wrapper").removeClass("toggled");
        });
    }
}

jQuery(function ($) {

    $(".sidebar-dropdown > a").click(function() {
        $(".sidebar-submenu").slideUp(200);
        if (
            $(this)
                .parent()
                .hasClass("active")
        ) {
            $(".sidebar-dropdown").removeClass("active");
            $(this)
                .parent()
                .removeClass("active");
        } else {
            $(".sidebar-dropdown").removeClass("active");
            $(this)
                .next(".sidebar-submenu")
                .slideDown(200);
            $(this)
                .parent()
                .addClass("active");
        }
    });

    $("#close-sidebar").click(function() {
        $(".page-wrapper").removeClass("toggled");
    });
    $("#show-sidebar").click(function() {
        $(".page-wrapper").addClass("toggled");
    });
});

function refreshNotification(id) {
    $.ajax({
        url: "/notifications/refresh?id=" + id,
    })
}

$(document).ready(function () {
    $('#notifications-dropdown').on('hide.bs.dropdown', function () {
        $("#notifications-dropdown").load(" #notifications-dropdown > *");
    });
});

$(document).on('click','#clear-notifications', function(){
    $.ajax({
        url: "/notifications/clear",
        success: function (result) {
            $('#notification-list').load(' #notification-list > *');
        }
    })
});

