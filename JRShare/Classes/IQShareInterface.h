//
//  IQShareInterface.h
//  IQShareComponent
//
//  Created by LQ on 2019/7/9.
//  Copyright © 2019 sd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class IQShareMessageObject;
@class IQShareResponse;

NS_ASSUME_NONNULL_BEGIN

@protocol IQShareInterface <NSObject>

#pragma mark - register
+ (BOOL)registerAppId:(NSString *)appid;

+ (BOOL)isPlatformInstall;

#pragma mark - share
- (BOOL)shareMessageObject:(IQShareMessageObject *)messageObject completion:(void(^)(IQShareResponse *response))completion;

#pragma mark - open url
- (BOOL)handleOpenURL:(NSURL *)url;
- (BOOL)openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation;
- (BOOL)openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options;
@end

NS_ASSUME_NONNULL_END
