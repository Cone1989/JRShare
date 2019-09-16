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

#import "IQShare.h"
#import "IQShareInterface.h"
#import "IQShareMessageObject.h"
#import "IQShareResponse.h"
#import "IQShareQQ.h"
#import "IQShareQZone.h"
#import "QQApiInterface.h"
#import "QQApiInterfaceObject.h"
#import "sdkdef.h"
#import "TencentOAuth.h"
#import "IQShareTimeLine.h"
#import "IQShareWeChat.h"
#import "WechatAuthSDK.h"
#import "WXApi.h"
#import "WXApiObject.h"

FOUNDATION_EXPORT double JRShareVersionNumber;
FOUNDATION_EXPORT const unsigned char JRShareVersionString[];

