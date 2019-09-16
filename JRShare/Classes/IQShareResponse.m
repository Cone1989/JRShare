//
//  IQShareResponse.m
//  IQShareComponent
//
//  Created by LQ on 2019/7/8.
//  Copyright © 2019 sd. All rights reserved.
//

#import "IQShareResponse.h"

@implementation IQShareResponse
- (instancetype)init
{
    self = [super init];
    if (self) {
        _bizCode = IQShareBizCodeFailed;
        _bizResponse = nil;
    }
    return self;
}
@end
