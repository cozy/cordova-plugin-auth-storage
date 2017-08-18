var exec = require('cordova/exec');

var authStorage = {
    storeData: function(serverURL, authToken, onSuccess, onError) {
        console.log('AuthStorage plugin: calling storeData w/' + serverURL + " / " + authToken);
        cordova.exec(onSuccess, onError, 'AuthStorage', 'storeData', [serverURL, authToken]);
    }
};

module.exports = authStorage;