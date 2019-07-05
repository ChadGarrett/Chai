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

#import "AardvarkDefines.h"
#import "ARKDataArchive.h"
#import "ARKExceptionLogging.h"
#import "ARKLogDistributor.h"
#import "ARKLogDistributor_Protected.h"
#import "ARKLogging.h"
#import "ARKLogMessage.h"
#import "ARKLogObserver.h"
#import "ARKLogStore.h"
#import "ARKLogTypes.h"
#import "CoreAardvark.h"

FOUNDATION_EXPORT double CoreAardvarkVersionNumber;
FOUNDATION_EXPORT const unsigned char CoreAardvarkVersionString[];

