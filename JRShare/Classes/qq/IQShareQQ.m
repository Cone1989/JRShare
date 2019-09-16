//
//  IQShareQQ.m
//  IQShareComponent
//
//  Created by LQ on 2019/7/3.
//  Copyright © 2019 sd. All rights reserved.
//

#import "IQShareQQ.h"
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import "IQShareMessageObject.h"
#import "IQShareResponse.h"

@interface IQShareQQ ()
@property (nonatomic, copy) void (^completionHandler)(IQShareResponse *resp);
@end

@implementation IQShareQQ
#pragma mark - IQShareInterface
+ (BOOL)registerAppId:(NSString *)appid {
    TencentOAuth *auth = [[TencentOAuth alloc] initWithAppId:appid andDelegate:nil];
    return auth != nil;
}

+ (BOOL)isPlatformInstall {
    return [QQApiInterface isQQInstalled];
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
    QQApiTextObject *text = [[QQApiTextObject alloc] initWithText:textMsg.text];
    SendMessageToQQReq *req = [SendMessageToQQReq reqWithContent:text];
    QQApiSendResultCode sent = [self sendReq:req];
    return sent == EQQAPISENDSUCESS;
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
    QQApiImageObject *imageMsg = [[QQApiImageObject alloc] initWithData:imgObject.imgData previewImageData:imgObject.previewData title:imgObject.title description:imgObject.desc];
    SendMessageToQQReq *req = [SendMessageToQQReq reqWithContent:imageMsg];
    QQApiSendResultCode sent = [self sendReq:req];
    return sent == EQQAPISENDSUCESS;
}
- (BOOL)shareWebPageObject:(IQShareWebPageObject *)webpageObject {
    QQApiNewsObject *news = [[QQApiNewsObject alloc] initWithURL:[NSURL URLWithString:webpageObject.webPageUrl] title:webpageObject.title description:webpageObject.desc previewImageData:webpageObject.thumbnailData targetContentType:QQApiURLTargetTypeNews];
    
    SendMessageToQQReq *req = [SendMessageToQQReq reqWithContent:news];
    QQApiSendResultCode sent = [self sendReq:req];
    return sent == EQQAPISENDSUCESS;
}
- (QQApiSendResultCode)sendReq:(SendMessageToQQReq *)req {
    return [QQApiInterface sendReq:req];
}

#pragma mark - open url
- (BOOL)handleOpenURL:(NSURL *)url {
    return [QQApiInterface handleOpenURL:url delegate:(id<QQApiInterfaceDelegate>)self];
}
- (BOOL)openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    return [self handleOpenURL:url];
}
- (BOOL)openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options {
    return [self handleOpenURL:url];
}


#pragma mark - QQApiInterfaceDelegate
- (void)onReq:(QQBaseReq *)req {
    
}
- (void)onResp:(QQBaseResp *)resp {
    IQShareResponse *response = [[IQShareResponse alloc] init];
    if (resp.result.intValue == -4) {
        response.bizCode = IQShareBizCodeCanceled;
    }else if (resp.result.intValue == 0) {
        response.bizCode = IQShareBizCodeSuccess;
    }else{
        response.bizCode = IQShareBizCodeFailed;
    }
    response.bizResponse = [self model2JSON:resp];
    if (self.completionHandler) {
        self.completionHandler(response);
    }
}
- (void)isOnlineResponse:(NSDictionary *)response {
    
}
- (NSDictionary *)model2JSON:(QQBaseResp *)resp {
    NSMutableDictionary *result = [NSMutableDictionary dictionary];
    [result setValue:resp.result forKey:@"result"];
    [result setValue:resp.errorDescription forKey:@"errorDescription"];
    [result setValue:resp.extendInfo forKey:@"extendInfo"];
    [result setValue:@(resp.type) forKey:@"type"];
    return [result copy];
}


@end
