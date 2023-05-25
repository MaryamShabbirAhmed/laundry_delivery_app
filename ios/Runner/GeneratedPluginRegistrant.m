//
//  Generated file. Do not edit.
//

// clang-format off

#import "GeneratedPluginRegistrant.h"

#if __has_include(<mobile_scanner/MobileScannerPlugin.h>)
#import <mobile_scanner/MobileScannerPlugin.h>
#else
@import mobile_scanner;
#endif

#if __has_include(<smart_auth/SmartAuthPlugin.h>)
#import <smart_auth/SmartAuthPlugin.h>
#else
@import smart_auth;
#endif

@implementation GeneratedPluginRegistrant

+ (void)registerWithRegistry:(NSObject<FlutterPluginRegistry>*)registry {
  [MobileScannerPlugin registerWithRegistrar:[registry registrarForPlugin:@"MobileScannerPlugin"]];
  [SmartAuthPlugin registerWithRegistrar:[registry registrarForPlugin:@"SmartAuthPlugin"]];
}

@end
