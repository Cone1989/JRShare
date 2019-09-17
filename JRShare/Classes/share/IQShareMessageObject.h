//
//  IQShareMessageObject.h
//  IQShareComponent
//
//  Created by LQ on 2019/7/3.
//  Copyright © 2019 sd. All rights reserved.
//

#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger,IQShareMessageType) {
    IQShareMessageTypeText,
    IQShareMessageTypeImage,
    IQShareMessageTypeWebPage,
};
// 消息基类
@interface IQShareMessageObject : NSObject
@property (nonatomic, assign) IQShareMessageType msgType;
@end

// 文本
@interface IQShareTextObject : IQShareMessageObject
@property (nonatomic, copy) NSString *text;
@end

// 媒体
@interface IQShareMediaObject : IQShareMessageObject
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *desc;
@end

// 图片
@interface IQShareImageObject : IQShareMediaObject
@property (nonatomic, copy) NSData *imgData;
@property (nonatomic, copy) NSData *previewData;
@end

// web网页
@interface IQShareWebPageObject : IQShareMediaObject
@property (nonatomic, copy) NSString *webPageUrl;
@property (nonatomic, strong) NSData *thumbnailData;
@end


NS_ASSUME_NONNULL_END
