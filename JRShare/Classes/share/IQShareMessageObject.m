//
//  IQShareMessageObject.m
//  IQShareComponent
//
//  Created by LQ on 2019/7/3.
//  Copyright © 2019 sd. All rights reserved.
//

#import "IQShareMessageObject.h"



@implementation IQShareMessageObject
- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}
@end

@implementation IQShareTextObject
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.msgType = IQShareMessageTypeText;
    }
    return self;
}
@end



@implementation IQShareMediaObject
- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}
@end



@implementation IQShareImageObject
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.msgType = IQShareMessageTypeImage;
    }
    return self;
}
@end



@implementation IQShareWebPageObject
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.msgType = IQShareMessageTypeWebPage;
    }
    return self;
}
@end
