function createMyBoard() {
    var name, description, dod;

    name = $('#my-board-name');
    description = $('#my-board-description');
    dod = $('#my-board-dod');

    if (name.val() !== '') {
        $.ajax({
            url: "/board/add?name=" + name.val() + "&description=" + description.val() + "&dod=" + dod.val(),
            success: function() {
                $('#content-container').load(' #my-boards-row > *');
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

function getMyBoard(id) {
    $.ajax({
        url: "/board/get?id=" + id,
        success: function(result) {
            $('#my-board-id').val(id);
            $('#edit-my-board-name').val(result.name);
            $('#edit-my-board-description').val(result.description);
            $('#edit-my-board-dod').val(result.dod);
        }
    })
}

function saveMyBoard() {
    let id, name, description, dod;

    id = $('#my-board-id').val();
    name = $('#edit-my-board-name').val();
    description = $('#edit-my-board-description').val();
    dod = $('#edit-my-board-dod').val();

    if (name !== '') {
        $.ajax({
            url: "/board/update?id= " + id + "&name=" + name + "&description=" + description + "&dod=" + dod,
            success: function() {
                $('#content-container').load(' #my-boards-row > *');
            }
        })
    }
}

function deleteMyBoard(id) {
    $.ajax({
        url: "/board/delete?id=" + id,
        success: function() {
            $('#content-container').load(' #my-boards-row > *');
        }
    })
}