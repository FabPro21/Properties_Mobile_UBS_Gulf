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

#import "HttpProxyPlugin.h"

FOUNDATION_EXPORT double http_proxyVersionNumber;
FOUNDATION_EXPORT const unsigned char http_proxyVersionString[];

