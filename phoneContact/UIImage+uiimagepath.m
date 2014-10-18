//
//  UIImage+uiimagepath.m
//  phoneContact
//
//  Created by wangjian on 10/8/14.
//  Copyright (c) 2014 Advin. All rights reserved.
//

#import "UIImage+uiimagepath.h"

@implementation UIImage (uiimagepath)

- (UIImage *) customimage:(NSString *) name;
{
    NSString *imagepath =[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"custom.bundle/image/"];
    NSString *image = [imagepath stringByAppendingPathComponent:name];
    return [ UIImage imageWithContentsOfFile:image];
}

@end
