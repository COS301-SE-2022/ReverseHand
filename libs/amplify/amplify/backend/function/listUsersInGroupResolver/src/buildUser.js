//helper function
function buildUser(prefix, user) {
    let userInfo = {};
    user.Attributes.forEach(function (attr) {
        switch (attr.Name) {
            case 'sub':
                userInfo.id = prefix + attr.Value;
                break;
            case 'email':
                userInfo.email = attr.Value;
                break;
            default:
                // code
        }
    });
    userInfo.enabled = user.Enabled;
    return userInfo;
}

module.exports = buildUser;