//
//  pcLocalViewController.h
//  phoneContact
//
//  Created by wangjian on 10/16/14.
//  Copyright (c) 2014 Advin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class pcLocalViewDetailController;

@interface pcLocalViewController : UIViewController<UISearchBarDelegate, UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>
{
    NSMutableArray *phoneContact;
    NSMutableArray *tableviewdata;
    CGPoint beginpoint;
    UIView *headerview ;
    UISearchBar *searchbar ;
    UINavigationBar *navbar;
}

@property(nonatomic,strong) UITableView *tableView;

- (void) filterSearch:(NSString *) searchtext;

- (void) tapanywheretodismisskeyboard: (UIGestureRecognizer*) UIGestureRecognizer;

- (NSString*) getDocumentPlsitfile;

- (void) setupfordismisskeyboard;

- (void) refresh;

- (void) add;

@end
