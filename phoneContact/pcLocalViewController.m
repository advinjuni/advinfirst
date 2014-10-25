//  pcLocalViewController.m
//  phoneContact
//
//  Created by wangjian on 9/30/14.
//  Copyright (c) 2014 Advin. All rights reserved.
//
#import "pcLocalViewController.h"
#import "pcLocalViewDetailController.h"
#import "pcAppDelegate.h"
#import "SharedInstanceClass.h"
@interface pcLocalViewController ()

@end

@implementation pcLocalViewController

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
    [self setupfordismisskeyboard];
    self.tableView =[[UITableView alloc] initWithFrame:CGRectMake(0, 60, 320, 568)];
    [self.tableView setDelegate:self];
    [self.tableView setDataSource:self];
    //self.tableView.delegate=self;
    //self.tableView.dataSource=self;
    
  //   headerview = [[UIView alloc] initWithFrame:CGRectMake(0, 60, 320, 40)];
     searchbar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 20, 320, 40)];
    [searchbar sizeToFit];
    searchbar.barTintColor = [UIColor whiteColor];
    searchbar.delegate=self;
   // [searchbar setPlaceholder:@"search                                                       "];
    //[headerview addSubview:searchbar];
     //self.tableView.tableHeaderView =headerview;

    // make nav bar
    navbar = [[UINavigationBar alloc]initWithFrame:CGRectMake(0, 20, 320, 40)];
    UINavigationItem *navtitle = [[UINavigationItem alloc]initWithTitle:@"通讯录"];
    [navbar pushNavigationItem:navtitle animated:YES];
    
    UIBarButtonItem *leftitem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refresh)];
    UIBarButtonItem *rightitem =[[ UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(add)];
    navtitle.leftBarButtonItem =leftitem;
    navtitle.rightBarButtonItem =rightitem;
    
    [self.view addSubview:navbar];
    [self.view addSubview:self.tableView];

}

-(NSString*) getDocumentPlsitfile
{
    NSArray *documentpath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *temppath = [documentpath objectAtIndex:0];
    NSString *plistpath =    [temppath stringByAppendingPathComponent:@"phoneContact.plist"];
    return plistpath;
}

#pragma button method
-(void) refresh
{

    NSString *plistpath= [self getDocumentPlsitfile];
    tableviewdata = [[NSMutableArray alloc] initWithContentsOfFile:plistpath];
    [self.tableView reloadData];
    
}

-(void) add
{
   // pcAppDelegate *appdelegate= [[UIApplication sharedApplication] delegate];
    //appdelegate.add_detail =NO;
    [SharedInstanceClass sharedinstance].add_detail=NO;
    [self performSegueWithIdentifier:@"addContactDetail" sender:self];
}

#pragma searchbar dismiss keyboard
-(void) setupfordismisskeyboard
{
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    UITapGestureRecognizer *singletaptd= [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapanywheretodismisskeyboard:)];
    NSOperationQueue *mainqueue = [NSOperationQueue mainQueue];
    [nc addObserverForName:UIKeyboardWillShowNotification object:nil queue:mainqueue usingBlock:^( NSNotification *note){[self.view addGestureRecognizer:singletaptd];}];
    [nc addObserverForName:UIKeyboardWillHideNotification object:nil queue:mainqueue usingBlock:^( NSNotification *note){[self.view removeGestureRecognizer:singletaptd];}];
    
}

- (void) tapanywheretodismisskeyboard:(UIGestureRecognizer*) UIGestureRecognizer
{
   // NSLog(@"tapwork");
    [self.view endEditing:YES];
    [searchbar removeFromSuperview];
}
/*
-(void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration

{
    if (UIInterfaceOrientationIsLandscape(toInterfaceOrientation))
    {
        _tableView.frame= CGRectMake(0, 60, 568, 220);
        navbar.frame = CGRectMake(0, 20, 568, 40);
      //  searchbar.frame=CGRectMake(0, 0, 568, 20);
    }
    else
    {
        _tableView.frame= CGRectMake(0, 60, 320, 468);
        navbar.frame = CGRectMake(0, 20, 320, 40);
      //  searchbar.frame=CGRectMake(0, 0, 320, 20);
        
    }
    
}
*/
-(void)viewDidAppear:(BOOL)animated
{
   /*
    if (self.interfaceOrientation ==UIInterfaceOrientationLandscapeLeft)
    {
        navbar.frame = CGRectMake(0, 20, 568, 220);
        _tableView.frame= CGRectMake(0, 60, 568, 40);
        searchbar.frame=CGRectMake(0, 0, 568, 20);

    }
    else if (self.interfaceOrientation ==UIInterfaceOrientationLandscapeRight)
    {

        navbar.frame = CGRectMake(0, 20, 568, 220);
        _tableView.frame= CGRectMake(0, 60, 568, 40);
        searchbar.frame=CGRectMake(0, 0, 568, 20);


    }
    else
    {
        navbar.frame = CGRectMake(0, 20, 320, 468);
        _tableView.frame= CGRectMake(0, 60, 320, 40);
        searchbar.frame=CGRectMake(0, 0, 320, 20);
    }
    */
}


- (void)viewWillAppear:(BOOL)animated
{
    NSString *plistpath= [self getDocumentPlsitfile];
    phoneContact = [[NSMutableArray alloc] initWithContentsOfFile:plistpath];
    tableviewdata = [NSMutableArray arrayWithArray:phoneContact];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma searchbar

- (void) filterSearch:(NSString *)searchtext
{
    
    NSPredicate *filterpredicate;
    
    if ([searchtext length]==0) {
        tableviewdata = [NSMutableArray arrayWithArray:phoneContact];
        return;
    } else {
        filterpredicate= [NSPredicate predicateWithFormat:@"SELF.Name contains[c] %@",searchtext];
        NSArray *temp = [phoneContact filteredArrayUsingPredicate:filterpredicate];
        tableviewdata = [NSMutableArray arrayWithArray:temp];
        
    }
    
}

- (void) searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    [self filterSearch:searchText];
    [self.tableView reloadData];
}

#pragma searchbar hidden and show
/*
 - (void) scrollViewWillBeginDragging:(UIScrollView *)scrollView
 {
 beginpoint =self.tableView.contentOffset;
     NSLog(@"offset y %f ",beginpoint.y);

 }
 

-(void)scrollViewDidScroll:(UIScrollView*)scrollView
{
    NSLog(@"End Decelerating");
    CGFloat end =self.tableView.contentOffset.y;
    NSLog(@"offset y %f %f",beginpoint.y,end);
    
    if (beginpoint.y < end)
    {
       [self.tableView setContentOffset:CGPointMake(0, 40)];
        NSLog(@"offset y %f %f",beginpoint.y,self.tableView.contentOffset.y);
    }
}
 */
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self.view addSubview:searchbar];
    NSLog(@"end Decelarating");
}
#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [tableviewdata count];
//    NSInteger he= [ tableviewdata count];
//    NSLog(@"%d",he);
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
 
    static NSString *CellIdentifier = @"CellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell= [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    NSUInteger Row= [indexPath row];
    NSDictionary *rowDict= [tableviewdata objectAtIndex:Row];
    cell.textLabel.text=[rowDict objectForKey:@"Name"];
    cell.accessoryType =UITableViewCellAccessoryDisclosureIndicator;
  
    return cell;
  
}


-(UITableViewCellEditingStyle) tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        [tableviewdata removeObjectAtIndex:indexPath.row];
        [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [phoneContact removeObjectAtIndex:indexPath.row];
        
        NSString *temp=[self getDocumentPlsitfile];
        [phoneContact writeToFile:temp atomically:YES];
        
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
    }
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [self performSegueWithIdentifier:@"addContactDetail" sender:self];
  //  pcAppDelegate *appdelegate= [[UIApplication sharedApplication] delegate];
    [SharedInstanceClass sharedinstance].add_detail=YES;
    [SharedInstanceClass sharedinstance].row=indexPath.row;
    //appdelegate.add_detail =YES;
    //appdelegate.row=indexPath.row;
}



@end

