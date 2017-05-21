//
//  UIImageView+wllieImage.m
//  RunTimeTest
//
//  Created by wangwei on 2017/5/18.
//  Copyright © 2017年 wangwei. All rights reserved.
//

#import "UIImageView+wllieImage.h"
#import <objc/message.h>
@implementation UIImageView (wllieImage)
+(void)load{
    
    Method imageNameMethod = class_getClassMethod([UIImage class], @selector(imageNamed:));
    // 获取第二个类方法
    Method xx_ccimageNameMrthod = class_getClassMethod([UIImage class], @selector(xx_ccimageNamed:));
    // 交换两个方法的实现 方法一 ，方法二。
    method_exchangeImplementations(imageNameMethod, xx_ccimageNameMrthod);
    // IMP其实就是 implementation的缩写：表示方法实现
    
}

+ (nullable UIImage *)xx_ccimageNamed:(NSString *)name
{
    // 加载图片    如果图片不存在则提醒或发出异常
    UIImage *image = [UIImage imageNamed:name];
    if (image == nil) {
        NSLog(@"图片不存在");
    }
    return image;
}

@end
