//
//  IQShare.h
//  IQShareComponent
//
//  Created by LQ on 2019/7/3.
//  Copyright © 2019 sd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "IQShareResponse.h"
#import "IQShareMessageObject.h"
#import "IQShareInterface.h"

NS_ASSUME_NONNULL_BEGIN
typedef NSString *IQSharePlatform;

extern IQSharePlatform const IQSharePlatformQQ;
extern IQSharePlatform const IQSharePlatformQZone;
extern IQSharePlatform const IQSharePlatformWechat;
extern IQSharePlatform const IQSharePlatformTimeline;


@interface IQShare : NSObject
/**
 单例
 */
+ (instancetype)defaultShare;
/**
 注册appid

 @param appid 第三方平台申请的appid
 @param platform 平台类型
 */
- (BOOL)registerAppId:(NSString *)appid platform:(IQSharePlatform)platform;
/**
 分享消息。


 @param platform 分享到的平台
 @param messageObject 消息实体
 @param completion 回调
 @return 是否调起分享成功
 */
- (BOOL)shareToPlatform:(IQSharePlatform)platform messageObject:(IQShareMessageObject *)messageObject completion:(void(^)(IQShareResponse *response))completion;
@end

@interface IQShare (HandlerOpenURL)
- (BOOL)handleOpenURL:(NSURL *)url;
- (BOOL)openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation;
- (BOOL)openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options;
@end

@interface IQShare (PlatformInstall)
+ (BOOL)isPlatformInstall:(IQSharePlatform)platform;
@end

NS_ASSUME_NONNULL_END
