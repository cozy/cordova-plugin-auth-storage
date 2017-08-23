// TODO comments, header
#import <Cordova/CDV.h>

@interface AuthStorage : CDVPlugin <NSURLSessionDelegate, NSURLSessionTaskDelegate, NSURLSessionDataDelegate>

- (void)pluginInitialize;
- (void)storeData:(CDVInvokedUrlCommand *)command;
- (void)removeData:(CDVInvokedUrlCommand *)command;
@end
