//
//  IQShareWeChat.m
//  IQShareComponent
//
//  Created by LQ on 2019/7/3.
//  Copyright © 2019 sd. All rights reserved.
//

#import "IQShareWeChat.h"
#import "WXApi.h"
#import "IQShareMessageObject.h"
#import "IQShareResponse.h"

@interface IQShareWeChat ()
@property (nonatomic, copy) void (^completionHandler)(IQShareResponse *resp);
@end

@implementation IQShareWeChat
#pragma mark - IQShareInterface
+ (BOOL)registerAppId:(NSString *)appid {
    return [WXApi registerApp:appid];
}

+ (BOOL)isPlatformInstall {
    return [WXApi isWXAppInstalled];
}

- (BOOL)shareMessageObject:(IQShareMessageObject *)messageObject completion:(nonnull void (^)(IQShareResponse * _Nonnull))completion {
    _completionHandler = completion;
    if (messageObject.msgType == IQShareMessageTypeText) {
       return [self sharePureTextMsg:(IQShareTextObject *)messageObject];
    }else {
       return [self shareMediaMsg:messageObject];
    }
}

#pragma mark - custom
- (BOOL)sharePureTextMsg:(IQShareTextObject *)textMsg {
    SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
    req.text = textMsg.text;
    req.scene = [self scene];
    return [WXApi sendReq:req];
}
- (BOOL)shareMediaMsg:(IQShareMessageObject *)mediaMsg {
    if (mediaMsg.msgType == IQShareMessageTypeImage) {
        return [self shareImageObject:(IQShareImageObject *)mediaMsg];
    }else if (mediaMsg.msgType == IQShareMessageTypeWebPage) {
        return [self shareWebPageObject:(IQShareWebPageObject *)mediaMsg];
    }
    return NO;
}
- (BOOL)shareImageObject:(IQShareImageObject *)imgObject {
    WXMediaMessage *imgMSg = [WXMediaMessage message];
    imgMSg.title = imgObject.title;
    imgMSg.description = imgObject.desc;
    
    WXImageObject *imgObj = [[WXImageObject alloc] init];
    imgObj.imageData = imgObject.imgData;
    imgMSg.mediaObject = imgObj;
    
    SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
    req.bText = NO;
    req.message = imgMSg;
    req.scene = [self scene];
    return [WXApi sendReq:req];
}
- (BOOL)shareWebPageObject:(IQShareWebPageObject *)webpageObject {
    WXWebpageObject *wpObject = [WXWebpageObject object];
    wpObject.webpageUrl = webpageObject.webPageUrl;
    
    WXMediaMessage *message = [WXMediaMessage message];
    message.title = webpageObject.title;
    message.description = webpageObject.desc;
    message.thumbData = webpageObject.thumbnailData;
    message.mediaObject = wpObject;
    
    SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
    req.bText = NO;
    req.message = message;
    req.scene = [self scene];
    return [WXApi sendReq:req];
}
- (enum WXScene)scene {
    return WXSceneSession;
}
#pragma mark - open url
- (BOOL)handleOpenURL:(NSURL *)url {
    return [WXApi handleOpenURL:url delegate:(id<WXApiDelegate>)self];
}
- (BOOL)openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    return [self handleOpenURL:url];
}
- (BOOL)openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options {
    return [self handleOpenURL:url];
}

#pragma mark - QQApiInterfaceDelegate
- (void)onReq:(BaseReq*)req {
    
}

- (void)onResp:(BaseResp*)resp {
    IQShareResponse *response = [[IQShareResponse alloc] init];
    if (resp.errCode == -2) {
        response.bizCode = IQShareBizCodeCanceled;
    }else if (resp.errCode == 0) {
        response.bizCode = IQShareBizCodeSuccess;
    }else{
        response.bizCode = IQShareBizCodeFailed;
    }
    response.bizResponse = [self model2JSON:resp];
    if (self.completionHandler) {
        self.completionHandler(response);
    }
}
- (NSDictionary *)model2JSON:(BaseResp *)resp {
    NSMutableDictionary *result = [NSMutableDictionary dictionary];
    [result setValue:resp.errStr forKey:@"errStr"];
    [result setValue:@(resp.type) forKey:@"type"];
    [result setValue:@(resp.errCode) forKey:@"errCode"];
    return [result copy];
}
@end
