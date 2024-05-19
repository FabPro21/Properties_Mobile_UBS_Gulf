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

#import "SystemProxyPlugin.h"

FOUNDATION_EXPORT double system_proxyVersionNumber;
FOUNDATION_EXPORT const unsigned char system_proxyVersionString[];

