//
//  IQShareResponse.h
//  IQShareComponent
//
//  Created by LQ on 2019/7/8.
//  Copyright © 2019 sd. All rights reserved.
//

#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger,IQShareBizCode) {
    IQShareBizCodeSuccess = 0,
    IQShareBizCodeCanceled = 1,
    IQShareBizCodeFailed = 2
};

@interface IQShareResponse : NSObject
// 各平台分享结果状态码（简化版，具体返回数据请参考bizResponse）
@property (nonatomic, assign) IQShareBizCode bizCode;
/**
 各平台返回的数据
 */
@property (nonatomic, copy) NSDictionary *bizResponse;
@end

NS_ASSUME_NONNULL_END
