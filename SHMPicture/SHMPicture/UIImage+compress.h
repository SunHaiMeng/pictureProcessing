//
//  UIImage+compress.h
//  MinSu
//
//  Created by apple on 2018/11/13.
//  Copyright © 2018年 GXT. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (compress)
- (NSData *)compressQualityWithMaxLength:(NSInteger)maxLength;
@end

NS_ASSUME_NONNULL_END
