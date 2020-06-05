function saveDetails() {
    let fullname, company, bio;

    fullname = $("#account-fullname").val();
    company = $("#account-company").val();
    bio = $("#account-bio").val();

    $.ajax({
        url: "/user/update/details?fullname=" + fullname + "&company=" + company + "&bio=" + bio,
        type: 'PUT',
        success: function() {
            alert("Details have been updated")
        }
    });

    tippy('#save-account-details', {
        content: "Details Saved!",
        trigger: 'click',
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
                    alert("Password has been updated")
                }
            })
        }
        else {
            alert("Passwords do not match");
        }
    }
}