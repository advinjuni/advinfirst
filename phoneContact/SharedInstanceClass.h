//
//  SharedInstanceClass.h
//  phoneContact
//
//  Created by wangjian on 10/25/14.
//  Copyright (c) 2014 Advin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SharedInstanceClass : NSObject
+ (SharedInstanceClass*) sharedinstance;

@property BOOL add_detail;

@property NSUInteger row;

@end
