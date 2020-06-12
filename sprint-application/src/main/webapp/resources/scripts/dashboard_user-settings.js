function updateName() {
    let name = $("#account-name").val();

    $.ajax({
        url: "/user/updateName?name=" + name,
        type: 'PUT',
    });
}

function updateCompany() {
    let company = $("#account-company").val();

    $.ajax({
        url: "/user/updateCompany?company=" + company,
        type: 'PUT',
    });
}

function updateBio() {
    let bio = $("#account-bio").val();

    $.ajax({
        url: "/user/updateBio?bio=" + bio,
        type: 'PUT',
    });
}

function savePassword() {
    let newPassword, confirmPassword;

    newPassword = $("#account-new-password").val();
    confirmPassword = $("#account-confirm-password").val();

    if(newPassword === '') {
        alert("Password fields cannot be empty")
    }
    else if (confirmPassword === '') {
        alert("Password fields cannot be empty")
    }
    else {
        if(newPassword === confirmPassword) {
            $.post({
                url: "/user/update/password?newPassword=" + newPassword,
                success: function() {
                    $('#change-password').load(' #change-password-text');
                    alert("Password has been updated");
                }
            })
        }
        else {
            alert("Passwords do not match");
        }
    }
}