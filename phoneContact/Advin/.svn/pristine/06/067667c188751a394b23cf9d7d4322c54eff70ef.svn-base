//
//  AddContactTableViewController.m
//  phoneContact
//
//  Created by wangjian on 10/3/14.
//  Copyright (c) 2014 Advin. All rights reserved.
//

#import "pcLocalViewDetailController.h"
#import "pcLocalViewController.h"
#import "pcAppDelegate.h"

@interface pcLocalViewDetailController ()

@end

@implementation pcLocalViewDetailController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
   headerview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 100)];
    // make nav bar
    uinav = [[UINavigationBar alloc]initWithFrame:CGRectMake(0, 20, 320, 40)];
    uinavitem = [[UINavigationItem alloc]init];
    UIBarButtonItem *leftitem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(Done)];
    UIBarButtonItem *rightitem =[[ UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(Save)];
    [uinavitem setTitle:@"Add"];
    uinavitem.leftBarButtonItem =leftitem;
    uinavitem.rightBarButtonItem =rightitem;
    [uinav pushNavigationItem:uinavitem animated:YES];
    [headerview addSubview:uinav];
    self.tableView.tableHeaderView =headerview;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textfieldchange) name:UITextFieldTextDidEndEditingNotification object:self.NameText];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textfieldchange) name:UITextFieldTextDidEndEditingNotification object:self.AgeText];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textfieldchange) name:UITextFieldTextDidEndEditingNotification object:self.numbertext];


#pragma keyboardtype
    self.numbertext.keyboardType=UIKeyboardTypeNumberPad;

    // Uncomment the following line to preserve selection between presentations.
}
-(void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration

{
    if (UIInterfaceOrientationIsLandscape(toInterfaceOrientation))
    {
        headerview.frame = CGRectMake(0, 0, 568, 100);
        uinav.frame = CGRectMake(0, 20, 568, 40);
        
    }
    else
    {
        headerview.frame = CGRectMake(0, 0, 320, 100);
        uinav.frame = CGRectMake(0, 20, 320, 40);
        
    }
    
}


-(void) customnavigationbar:(BOOL) add_detail
{
    if (!add_detail)
    {
        [uinavitem setTitle:@"Add"];

    }
    else
    {
        [uinavitem setTitle:@"Info"];
    }
    
}

-(void)viewDidAppear:(BOOL)animated
{
    pcAppDelegate *appdelegate =[[UIApplication sharedApplication] delegate];
    [self customnavigationbar:appdelegate.add_detail];
    if (appdelegate.add_detail) {
        NSString *plistpath=[self copyfileifneed];
        NSMutableArray *array = [[NSMutableArray alloc] initWithContentsOfFile:plistpath];
        NSDictionary *dict=[array objectAtIndex:appdelegate.row];
        self.NameText.text=[ dict objectForKey:@"Name"];
        self.AgeText.text=[dict objectForKey:@"age"];
        self.numbertext.text=[dict objectForKey:@"phonenumber"];
    }
    if (self.interfaceOrientation ==UIInterfaceOrientationLandscapeLeft)
    {
        headerview.frame = CGRectMake(0, 0, 568, 100);
        uinav.frame = CGRectMake(0, 20, 568, 40);    }
    else if (self.interfaceOrientation ==UIInterfaceOrientationLandscapeRight)
    {
        headerview.frame = CGRectMake(0, 0, 568, 100);
        uinav.frame = CGRectMake(0, 20, 568, 40);    }
    else
    {
        headerview.frame = CGRectMake(0, 0, 320, 100);
        uinav.frame = CGRectMake(0, 20, 320, 40);
    }

}

-(void) Done
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void) Save
{
    
    pcAppDelegate *appdelegate =[[UIApplication sharedApplication] delegate];
    if (appdelegate.add_detail) {
    }
    else
    {
    NSString *plistpath=[self copyfileifneed];
    NSMutableArray *array = [[NSMutableArray alloc] initWithContentsOfFile:plistpath];
    NSString *name      = self.NameText.text;
    NSString *age       = self.AgeText.text;
    NSString *number    = self.numbertext.text;
    NSDictionary *dict=[NSDictionary dictionaryWithObjects:@[number,name,age] forKeys:@[@"phonenumber",@"Name",@"age"]];
    [array addObject:dict];
    [array writeToFile:plistpath atomically:YES];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
    
    
}

-(void)textfieldchange
{
    NSLog(@"observer open");
    pcAppDelegate *appdelegate =[[UIApplication sharedApplication] delegate];
    if (!appdelegate.add_detail) {
        
    } else {
        pcAppDelegate *appdelegate =[[UIApplication sharedApplication] delegate];
        NSString *plistpath=[self copyfileifneed];
        NSMutableArray *array = [[NSMutableArray alloc] initWithContentsOfFile:plistpath];
        NSDictionary *dict = [array objectAtIndex:appdelegate.row];
        [ dict setValue:self.NameText.text forKey:@"Name"];
        [ dict setValue:self.AgeText.text forKey:@"age"];
        [ dict setValue:self.numbertext.text forKey:@"phonenumber"];
        
        [array replaceObjectAtIndex:appdelegate.row withObject:dict];
        NSLog(@"%@",self.NameText.text);
        [array writeToFile:plistpath atomically:YES];
    }
    

}

-(NSString*) copyfileifneed
{
    NSString *resourcepath= [[NSBundle mainBundle] pathForResource:@"phoneContact" ofType:@"plist"];
    NSString *plistpath=[[[pcLocalViewController alloc] init] getDocumentPlsitfile];
    if ([[NSFileManager defaultManager] fileExistsAtPath:plistpath ]== NO) {
        NSLog(@"no file exists");
        NSError *error =nil;
        [[NSFileManager defaultManager] copyItemAtPath:resourcepath toPath:plistpath error:&error];
        if (error != nil ) {
            NSLog(@"copy file error %@",error);
        }
    }
    return plistpath;
    
}

#pragma mark - Table view data source

- (IBAction)Text_field_did_end_on:(id)sender
{
    [sender resignFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
