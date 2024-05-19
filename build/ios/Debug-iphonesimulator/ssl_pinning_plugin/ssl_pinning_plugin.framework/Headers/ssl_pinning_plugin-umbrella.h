#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "SslPinningPlugin.h"

FOUNDATION_EXPORT double ssl_pinning_pluginVersionNumber;
FOUNDATION_EXPORT const unsigned char ssl_pinning_pluginVersionString[];

