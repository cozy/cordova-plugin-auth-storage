
#import "AuthStorage.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import <Security/Security.h>
#import <SAMKeychain/SAMKeychain.h>

#define KEYCHAIN_NAME       @"io.cozy.drive.mobile"


@implementation AuthStorage
 
- (void)pluginInitialize {
	// Plugin specific initialize login goes here
}

- (void)returnResult:(BOOL)aSuccess payload:(NSDictionary *)aJSON command:(CDVInvokedUrlCommand *)aCommand {
    if(aJSON == nil) {
        aJSON = [NSDictionary dictionary];
    }
    CDVPluginResult * pluginResult = [CDVPluginResult resultWithStatus:(aSuccess ? CDVCommandStatus_OK : CDVCommandStatus_ERROR) messageAsDictionary:aJSON];
    [[self commandDelegate] sendPluginResult:pluginResult callbackId:[aCommand callbackId]];
}


- (void)storeData:(CDVInvokedUrlCommand *)command {
    
    NSString * url = command.arguments[0];
    NSString * token = command.arguments[1];
    
    BOOL result = [SAMKeychain setPassword:token forService:KEYCHAIN_NAME account:url];
    [self returnResult:result payload:[NSDictionary dictionaryWithObject:result ? @"ok" : @"error" forKey:@"result"] command:command];
}


- (void)removeData:(CDVInvokedUrlCommand *)command {

    NSArray * accounts = [SAMKeychain accountsForService:KEYCHAIN_NAME];
    for(NSString * account in accounts) {
        [SAMKeychain deletePasswordForService:KEYCHAIN_NAME account:account];
    }
    [self returnResult:YES payload:[NSDictionary dictionaryWithObject:@"ok" forKey:@"result"] command:command];
}
@end
