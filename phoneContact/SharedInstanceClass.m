//
//  SharedInstanceClass.m
//  phoneContact
//
//  Created by wangjian on 10/25/14.
//  Copyright (c) 2014 Advin. All rights reserved.
//

#import "SharedInstanceClass.h"

@implementation SharedInstanceClass

static SharedInstanceClass *sharedmanger=nil;

+ (SharedInstanceClass*) sharedinstance;
{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        sharedmanger = [[self alloc] init];
    });
    return  sharedmanger;

}

@end
