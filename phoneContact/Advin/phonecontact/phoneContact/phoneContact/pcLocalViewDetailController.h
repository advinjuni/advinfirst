//
//  AddContactTableViewController.h
//  phoneContact
//
//  Created by wangjian on 10/3/14.
//  Copyright (c) 2014 Advin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class pcLocalViewController;

@interface pcLocalViewDetailController : UITableViewController <UITextFieldDelegate>
{
    UINavigationBar *uinav;
    UINavigationItem *uinavitem;
    UIView *headerview ;
}

@property (weak, nonatomic) IBOutlet UILabel *NameLabel;
@property (weak, nonatomic) IBOutlet UILabel *AgeLabel;
@property (weak, nonatomic) IBOutlet UITextField *NameText;
@property (weak, nonatomic) IBOutlet UITextField *AgeText;
@property (weak, nonatomic) IBOutlet UITextField *numbertext;
@property (weak, nonatomic) IBOutlet UILabel *numberlabel;

-(void) customnavigationbar:(BOOL) add_detail;

-(NSString*) copyfileifneed;

-(void)textfieldchange;

-(IBAction)Text_field_did_end_on:(id)sender;

-(void) Done;

-(void) Save;

@end
