
var exec = require('cordova/exec');

var authStorage = {
	storeData: function(serverURL, authToken, onSuccess, onError) {
		console.log('AuthStorage plugin: calling storeData...');
		cordova.exec(onSuccess, onError, 'AuthStorage', 'storeData', []);
	}
};

module.exports = authStorage;