//
//  IQShareQZone.m
//  IQShareComponent
//
//  Created by LQ on 2019/7/3.
//  Copyright © 2019 sd. All rights reserved.
//

#import "IQShareQZone.h"
#import <TencentOpenAPI/QQApiInterface.h>
@implementation IQShareQZone
- (QQApiSendResultCode)sendReq:(SendMessageToQQReq *)req {
    return [QQApiInterface SendReqToQZone:req];
}
@end
