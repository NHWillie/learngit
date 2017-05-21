//
//  UIImage+willie.m
//  RunTimeTest
//
//  Created by wangwei on 2017/5/18.
//  Copyright © 2017年 wangwei. All rights reserved.
//

#import "UIImage+willie.h"
#import <objc/message.h>

@implementation UIImage (willie)



+(void)load{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        SEL originalInitSelector = @selector(imageNamed:);
        Method originalInitMethod = class_getInstanceMethod([UIImage class], originalInitSelector);
        SEL swizzledInitSelector = @selector(xx_ccimageNamed:);
        Method swizzledInitMethod = class_getInstanceMethod([UIImage class], swizzledInitSelector);
        BOOL didInitAddMethod =
        class_addMethod([UIImage class],
                        originalInitSelector,
                        method_getImplementation(swizzledInitMethod),
                        method_getTypeEncoding(swizzledInitMethod));
        
        if (didInitAddMethod) {
            class_replaceMethod([UIImage class],
                                swizzledInitSelector,
                                method_getImplementation(originalInitMethod),
                                method_getTypeEncoding(originalInitMethod));
            
        } else {
            method_exchangeImplementations(originalInitMethod, swizzledInitMethod);
        }

    });
    
    
}

+ (nullable UIImage *)xx_ccimageNamed:(NSString *)name
{
    // 加载图片    如果图片不存在则提醒或发出异常
    UIImage *image = [self xx_ccimageNamed:name];
    if (image == nil) {
        NSLog(@"图片不存在");
    }
    
    return image;
}
@end
