// Board Functions
function addBoard() {
    var name = document.getElementById("new-board-text").value;
    if(name.length !== 0) {
        $.ajax({
            url: "/boards/add?name=" + name,
            success: function(result) {
                reloadBoards();
            }
        })
    }
}

function deleteBoard(id) {
    $.ajax({
        url: "/boards/delete?id=" + id,
        success: function(result) {
            reloadBoards();
        }
    })
}

function reloadBoards() {
    $('#board-grid').load(' #board-grid > *');
    $('#navbar-boards').load(' #navbar-boards > *');
}

function boardOverlayViewOnly(id) {

    // Closing sidebar
    if($(".page-wrapper").hasClass("toggled") == true) {
        $(".page-wrapper").removeClass("toggled");
    }

    // Appending Details to Overlay
    $.ajax({
        url: "/boards/get?id=" + id,
        success: function(result) {
            $('#board-overlay-vo-table').empty();
            for(let step=0; step<result.users.length; step++) {
                if(result.users[step].fullname === null) {
                    result.users[step].fullname = "";
                }
                $('#board-overlay-vo-table').append('<tr><th scope="row">' + result.users[step].username + '</th> <td>' + result.users[step].fullname + '</td> <td>' + result.users[step].email + '</td> <td>' + result.users[step].role + '</td>');
            }
            document.getElementById('board-overlay-vo-id').value = id;
            document.getElementById('board-overlay-vo-name').value = result.name;
            document.getElementById('board-overlay-vo-description').value = result.description;
            document.getElementById('board-overlay-vo-dod').textContent = result.dod;
        }
    });

    $('#board-overlay-view-only').show();
}

function boardOverlayOn(id) {

    // Closing sidebar
   if($(".page-wrapper").hasClass("toggled") == true) {
       $(".page-wrapper").removeClass("toggled");
   }

   // Appending Details to Overlay
   $.ajax({
       url: "/boards/get?id=" + id,
       success: function(result) {
           $('#board-overlay-table').empty();
           for(let step=0; step<result.users.length; step++) {
               if(result.users[step].fullname === null) {
                   result.users[step].fullname = "";
               }
               if(result.users[step].username === result.owner) {
                   $('#board-overlay-table').append('<tr><th scope="row">' + result.users[step].username + '</th> <td>' + result.users[step].fullname + '</td> <td>' + result.users[step].email + '</td> <td><select class="custom-select custom-select-sm">\n' +
                       '  <option onclick="changeRole(\'' + result.users[step].email + ',' + result.users[step].role +'\')" selected>' + result.users[step].role + '</option>\n' +
                       '  <option onclick="changeRole(\'' + result.users[step].email + ',' + result.users[step].roleAlt + '\')" value="1">' + result.users[step].roleAlt + '</option>\n' +
                       '  <option onclick="changeRole(\'' + result.users[step].email + ',' + result.users[step].roleAlt1 + '\')" value="2">' + result.users[step].roleAlt1 + '</option>\n' +
                       '</select></td> ');
               }
               else {
                   $('#board-overlay-table').append('<tr><th scope="row">' + result.users[step].username + '</th> <td>' + result.users[step].fullname + '</td> <td>' + result.users[step].email + '</td> <td><select class="custom-select custom-select-sm">\n' +
                       '  <option onclick="changeRole(\'' + result.users[step].email + ',' + result.users[step].role +'\')" selected>' + result.users[step].role + '</option>\n' +
                       '  <option onclick="changeRole(\'' + result.users[step].email + ',' + result.users[step].roleAlt + '\')" value="1">' + result.users[step].roleAlt + '</option>\n' +
                       '  <option onclick="changeRole(\'' + result.users[step].email + ',' + result.users[step].roleAlt1 + '\')" value="2">' + result.users[step].roleAlt1 + '</option>\n' +
                       '</select></td> ' +
                       '<td><i style="padding-left: 25%" class="material-icons" onclick="removeUser(\'' + result.users[step].email + '\')">delete_outline</i></td>');
               }
           }
           document.getElementById('board-overlay-id').value = id;
           document.getElementById('board-overlay-name').value = result.name;
           document.getElementById('board-overlay-description').value = result.description;
           document.getElementById('board-overlay-dod').textContent = result.dod;
       }
   });

   $('#board-overlay').show();
}

function changeRole(value) {
    var string = value.split(",");
    $.ajax({
        url: "/boards/users/role?email=" + string[0] + "&role=" + string[1],
    })
}

function saveBoard() {
    let id, name, description, dod;

    id = $("#board-overlay-id").val();
    name = $("#board-overlay-name").val();
    description = $("#board-overlay-description").val();
    dod = $("#board-overlay-dod").val();

    console.log(id);
    console.log(name);
    console.log(description);
    console.log(dod);

    $.ajax({
        url: "/boards/save?id=" + id + "&name=" + name + "&description=" + description + "&dod=" + dod,
        success: function(result) {
            reloadBoards();
        }
    })
}

function searchUser() {
    var email = document.getElementById("board-search-bar").value;
    if(email !== '') {
        $.ajax({
            url: "/boards/users/search?email=" + email,
            success: function(result) {
                if (result === "fail") {
                    $('#board-overlay-search-list').empty();
                }
                else {
                    $('#board-overlay-search-list').empty();
                    $('#board-overlay-search-list').append('<li class="list-group-item friend-overlay-list-item" onclick="inviteUser(\'' + result + '\')"> ' + result + "</li>");
                }

            }
        })
    }
}

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
    if($(".page-wrapper").hasClass("toggled") == false) {
        $("#show-sidebar").click(function() {
            $(".page-wrapper").addClass("toggled");
        });
    }
    else if ($(".page-wrapper").hasClass("toggled") == true) {
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

function clearNotifications() {

}
$(document).on('click','#clear-notifications', function(){
    $.ajax({
        url: "/notifications/clear",
        success: function (result) {
            $('#notification-list').load(' #notification-list > *');
        }
    })
});

