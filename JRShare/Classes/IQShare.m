//
//  IQShare.m
//  IQShareComponent
//
//  Created by LQ on 2019/7/3.
//  Copyright © 2019 sd. All rights reserved.
//

#import "IQShare.h"


IQSharePlatform const IQSharePlatformQQ = @"IQShareQQ";
IQSharePlatform const IQSharePlatformQZone = @"IQShareQZone";
IQSharePlatform const IQSharePlatformWechat = @"IQShareWeChat";
IQSharePlatform const IQSharePlatformTimeline = @"IQShareTimeLine";

@interface IQShare ()
@property (nonatomic, copy) IQSharePlatform platform;
@property (nonatomic, strong) id<IQShareInterface> currentPlatform;
@end

@implementation IQShare

+ (instancetype)defaultShare {
    static IQShare *shareInstance = NULL;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareInstance = [[IQShare alloc] init];
    });
    return shareInstance;
}


- (BOOL)registerAppId:(NSString *)appid platform:(nonnull IQSharePlatform)platform {
    Class cls = NSClassFromString(platform);
    id<IQShareInterface> pf = (id<IQShareInterface>)cls;
    return [pf registerAppId:appid];
}

- (BOOL)shareToPlatform:(IQSharePlatform)platform messageObject:(IQShareMessageObject *)messageObject completion:(void (^)(IQShareResponse *_Nonnull))completion {
    _platform = platform;
    Class cls = NSClassFromString(platform);
    id<IQShareInterface> pf = [[cls alloc] init];
    self.currentPlatform = pf;
    return [pf shareMessageObject:messageObject completion:^(IQShareResponse * _Nonnull response) {
        if (completion) {
            completion(response);
        }
        self.currentPlatform = nil;
        self.platform = nil;
    }];
}

@end

@implementation IQShare (HandlerOpenURL)

- (BOOL)handleOpenURL:(NSURL *)url
{
    id<IQShareInterface> platform = self.currentPlatform;
    return [platform handleOpenURL:url];
}
- (BOOL)openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    id<IQShareInterface> platform = self.currentPlatform;
    return [platform openURL:url sourceApplication:sourceApplication annotation:annotation];
}
- (BOOL)openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options
{
    id<IQShareInterface> platform = self.currentPlatform;
    return [platform openURL:url options:options];
}

@end

@implementation IQShare (PlatformInstall)

+ (BOOL)isPlatformInstall:(IQSharePlatform)platform {
    Class cls = NSClassFromString(platform);
    id<IQShareInterface> pf = (id<IQShareInterface>)cls;
    return [pf isPlatformInstall];
}

@end

