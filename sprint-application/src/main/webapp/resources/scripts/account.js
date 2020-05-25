function saveDetails() {
    let fullname, company, bio;

    fullname = $("#account-fullname").val();
    company = $("#account-company").val();
    bio = $("#account-bio").val();

    $.ajax({
        url: "/account/save?fullname=" + fullname + "&company=" + company + "&bio=" + bio,
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

    if(newPassword || confirmPassword === '') {
        alert("Password fields cannot be empty")
    }
    else {
        if(newPassword === confirmPassword) {
            $.ajax({
                url: "/account/password?new=" + newPassword,
                success: function(result) {
                    alert("Password has been updated")
                }
            })
        }
        else {
            alert("Passwords do not match");
        }
    }
}