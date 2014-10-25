//
//  pcTabbarViewController.m
//  phoneContact
//
//  Created by wangjian on 10/4/14.
//  Copyright (c) 2014 Advin. All rights reserved.
//

#import "pcTabbarViewController.h"

@interface pcTabbarViewController ()

@end

@implementation pcTabbarViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
        //   [self.tabBar.items[0] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys: [UIColor blackColor], NSForegroundColorAttributeName, [UIFont fontWithName:@"Courier" size:16.0], NSFontAttributeName,nil]];
   /*
    for (NSUInteger index =0; index < [self.tabBar.items count];index++)
    {
        [[self.tabBar.items objectAtIndex:index] setTitlePositionAdjustment:UIOffsetMake(0, -20)];


    }
    */
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}



@end
