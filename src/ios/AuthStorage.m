
#import "AuthStorage.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import <Security/Security.h>
#import "SAMKeychain.h"

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
    token = [@"Bearer " stringByAppendingString:token];
    
    // store this in keychain
    NSData * url_data = [url dataUsingEncoding:NSUTF8StringEncoding];
    NSData * token_data = [token dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary * keychain_query = [NSDictionary dictionaryWithObjects:@[(NSString *)kSecClass, (NSString *)kSecClassGenericPassword, (NSString *)kSecAttrService, (NSString *)kSecValueData]
                                                                forKeys:@[(NSString *)kSecClassGenericPassword, url_data, @"io.cozy.drive.mobile", token_data]];
    SecItemDelete((__bridge CFDictionaryRef)keychain_query);
    SecItemAdd((__bridge CFDictionaryRef)keychain_query, nil);

    
    
    
    [SAMKeychain deletePasswordForService:@"io.cozy.drive.mobile" account:url];
    BOOL result = [SAMKeychain setPassword:token forService:@"io.cozy.drive.mobile" account:url];
    [self returnResult:result payload:[NSDictionary dictionaryWithObject:result ? @"ok" : @"error" forKey:@"result"] command:command];
}


@end
