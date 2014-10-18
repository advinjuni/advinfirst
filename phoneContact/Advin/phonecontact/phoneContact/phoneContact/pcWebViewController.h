//
//  pcViewController.h
//  phoneContact
//
//  Created by wangjian on 10/8/14.
//  Copyright (c) 2014 Advin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <CoreLocation/CLLocationManagerDelegate.h>
#import <AddressBook/AddressBook.h>

@class Reachability;

@interface pcWebViewController : UIViewController <UITextFieldDelegate,UIWebViewDelegate,UIScrollViewDelegate,CLLocationManagerDelegate>
{
    BOOL IsOn;
    NSString *locate;
    CLLocation *currentlocation;
}
#pragma websearch
@property (weak, nonatomic) IBOutlet UIScrollView *scrollview;
@property (weak, nonatomic,readwrite) UIButton *StopButton;
@property (weak, nonatomic) IBOutlet UITextField *SearchFiled;
@property (weak, nonatomic) IBOutlet UIWebView *WebView;
-(void) reloadorstop:(id) sender;

#pragma location
@property (weak, nonatomic) IBOutlet UIButton *locateswitch;
@property (weak, nonatomic) IBOutlet UILabel *locatelabel;
@property (nonatomic,strong) CLLocationManager *LocationManager;
-(void) reverseGeocdeLocation:(CLLocation *) location;
- (IBAction)locate:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *Home;
- (IBAction)backHome:(id)sender;
-(void) GOHomePage;
//-(void) goBack;
//-(void) HandlePinch:(UIPinchGestureRecognizer *) recognizer;

@end
