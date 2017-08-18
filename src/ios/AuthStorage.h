// TODO comments, header
#import <Cordova/CDV.h>

@interface AuthStorage : CDVPlugin <NSURLSessionDelegate, NSURLSessionTaskDelegate, NSURLSessionDataDelegate>

- (void)pluginInitialize;
- (void)isAuthorized:(CDVInvokedUrlCommand *)command;
- (void)listItems:(CDVInvokedUrlCommand *)command;
- (void)uploadItem:(CDVInvokedUrlCommand *)command;
- (void)requestReadAuthorization:(CDVInvokedUrlCommand *)command;
@end
