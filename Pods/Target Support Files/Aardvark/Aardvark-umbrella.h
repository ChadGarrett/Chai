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

#import "Aardvark.h"
#import "ARKBugReporter.h"
#import "ARKDefaultLogFormatter.h"
#import "ARKEmailAttachment.h"
#import "ARKEmailBugReportConfiguration.h"
#import "ARKEmailBugReportConfiguration_Protected.h"
#import "ARKEmailBugReporter.h"
#import "ARKIndividualLogViewController.h"
#import "ARKLogDistributor+UIAdditions.h"
#import "ARKLogFormatter.h"
#import "ARKLogTableViewController.h"
#import "ARKScreenshotLogging.h"
#import "ARKScreenshotViewController.h"

FOUNDATION_EXPORT double AardvarkVersionNumber;
FOUNDATION_EXPORT const unsigned char AardvarkVersionString[];

