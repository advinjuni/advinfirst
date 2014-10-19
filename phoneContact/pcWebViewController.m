//
//  pcViewController.m
//  phoneContact
//
//  Created by wangjian on 10/8/14.
//  Copyright (c) 2014 Advin. All rights reserved.
//

#import "pcWebViewController.h"
#import "UIImage+uiimagepath.h"
#import "Reachability.h"

@interface pcWebViewController ()

@end

@implementation pcWebViewController

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
    
    IsOn=NO;
    
    #pragma SearchFiled
    _SearchFiled.keyboardType=UIKeyboardTypeURL;
    _SearchFiled.returnKeyType=UIReturnKeyGo;
    _SearchFiled.clearButtonMode=UITextFieldViewModeWhileEditing;

    UIImage *image =[[UIImage alloc] init];
    _StopButton= [UIButton buttonWithType:UIButtonTypeCustom];
    _StopButton.bounds=CGRectMake(0, 0, 26, 30);
    [ _StopButton setImage:[image customimage:@"AddressViewStop.png"] forState:UIControlStateNormal];
    [ _StopButton addTarget:self action:@selector(reloadorstop:) forControlEvents:UIControlEventTouchUpInside];
    _SearchFiled.rightView=_StopButton;
    _SearchFiled.rightViewMode =UITextFieldViewModeUnlessEditing;
    
    _WebView.scrollView.pagingEnabled =YES;
    _WebView.scalesPageToFit=YES;
    _WebView.multipleTouchEnabled=YES;
    _WebView.scrollView.showsHorizontalScrollIndicator=YES;
    _WebView.scrollView.showsVerticalScrollIndicator=YES;
    _WebView.scrollView.scrollEnabled=YES;
    [_scrollview setMaximumZoomScale:1.2];
    [_scrollview setMinimumZoomScale:0.25];
    
    [self GOHomePage];
    
    #pragma Location
    _LocationManager =[[CLLocationManager alloc] init];
    _LocationManager.delegate=self;
    _LocationManager.desiredAccuracy=kCLLocationAccuracyBest;
    _LocationManager.distanceFilter=100.f;
    
    _locatelabel.font=[UIFont fontWithName:@"Courier" size:9];
    _locateswitch.titleLabel.font=[UIFont fontWithName:@"Courier" size:9];
    [_locateswitch setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    [_locateswitch setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _Home.titleLabel.font=[UIFont fontWithName:@"Courier" size:9];
    [_Home setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    [_Home setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

}
-(void) GOHomePage
{
    NSURL *initurl= [NSURL URLWithString:@"http://www.t.tt"];
    NSURLRequest *request=[NSURLRequest requestWithURL:initurl];
    [_WebView loadRequest:request];
}
-(void)viewDidAppear:(BOOL)animated
{
    Reachability *reach =[Reachability reachabilityForInternetConnection];
    NetworkStatus status=[reach currentReachabilityStatus];
    if (status == NotReachable) {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"ConnectionFail" message:@"Not Reachble" delegate:self cancelButtonTitle:nil otherButtonTitles:@"ok", nil];
        [alert show];
    }
    UISwipeGestureRecognizer *swipeLeft= [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(goBack)];
    swipeLeft.direction=UISwipeGestureRecognizerDirectionLeft;
    UISwipeGestureRecognizer *swiperight= [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(goForward)];
    swipeLeft.direction=UISwipeGestureRecognizerDirectionRight;
    [_WebView addGestureRecognizer:swipeLeft];
    [_WebView addGestureRecognizer:swiperight];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [_LocationManager stopUpdatingLocation];
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    NSLog(@"zoom receive");
    return _WebView;
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(float)scale
{
    NSLog(@"zoom end");
    [_scrollview setZoomScale:scale animated:NO];
}



#pragma webview delegate
- (void) webViewDidStartLoad:(UIWebView *)webView
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible =YES;
    UIImage *image =[[UIImage alloc] init];
    [ _StopButton setImage:[image customimage:@"AddressViewStop.png"] forState:UIControlStateNormal];

}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible=NO;
    UIImage *image =[[UIImage alloc] init];
    [ _StopButton setImage:[image customimage:@"AddressViewReload.png"] forState:UIControlStateNormal];
}

-(void) webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible=NO;
    NSString *errorstring= [error localizedDescription];
    NSString *errortitle =[NSString stringWithFormat:@"Error (%d)",error.code];
    UIAlertView *errorview =[[ UIAlertView alloc] initWithTitle:errortitle message:errorstring delegate:self cancelButtonTitle:nil otherButtonTitles:@"ok", nil];
    [errorview show];
    
}

#pragma searchfiled operation
- (void) reloadorstop:(id)sender
{
    
    if (_WebView.loading) {
        [_WebView stopLoading];
    } else {
        [_WebView reload];
    }
    
}
-(void) textFieldDidEndEditing:(UITextField *)textField
{
    NSString *url= _SearchFiled.text;
    NSString *final;
    if ([url hasPrefix:@"www."]) {
        final = [NSString stringWithFormat:@"http://%@",url];
    } else {
        final = [NSString stringWithFormat:@"http://www.%@",url];
    }
    
    NSURL *initurl= [NSURL URLWithString:final];
    NSURLRequest *request=[NSURLRequest requestWithURL:initurl];
    [_WebView loadRequest:request];
}

-  (BOOL) textFieldShouldReturn:(UITextField *)textField
{
    [self.SearchFiled resignFirstResponder];
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma locate delegate
-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"error: %@",error);
    [_LocationManager stopUpdatingLocation];

}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    currentlocation=[locations lastObject];
    [self reverseGeocdeLocation:currentlocation];
    _locatelabel.text=locate;

}

- (IBAction)locate:(id)sender {
    IsOn=!IsOn;
    if (IsOn) {
        [_locateswitch setTitle:@"ON" forState:UIControlStateNormal];
        [_locateswitch setTitle:@"ON" forState:UIControlStateHighlighted];
        [_LocationManager startUpdatingLocation];
    }
    else
    {
        [_locateswitch setTitle:@"OFF" forState:UIControlStateNormal];
        [_locateswitch setTitle:@"OFF" forState:UIControlStateHighlighted];
        [_LocationManager stopUpdatingLocation];
        _locatelabel.text=@"default location is advin's home";

    }
    
}
-(void) reverseGeocdeLocation:(CLLocation *) location
{
    CLGeocoder *gecoder= [[CLGeocoder alloc]init];
    NSLog(@"%3.5f,%3.5f,%3.5f",location.coordinate.latitude,location.coordinate.longitude,location.altitude);
    [gecoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error){
        NSLog(@"gecode start");
        
        if ([placemarks count] >0) {
            NSLog(@"placement find");
            CLPlacemark *placemark= placemarks[0];
            NSDictionary *addressDictionary= placemark.addressDictionary;
            NSString *address=[addressDictionary objectForKey:(NSString *)kABPersonAddressStreetKey];
            address=address==nil?@"":address;
            NSString *state=[addressDictionary objectForKey:(NSString *)kABPersonAddressStateKey];
            state=state==nil?@"":state;
            NSString *city=[addressDictionary objectForKey:(NSString *)kABPersonAddressCityKey];
            city=city==nil?@"":city;
            locate= [NSString stringWithFormat:@"%@,%@,%@",state,address,city];
            NSLog(@"%@",locate);
        }
        
    }];
}
- (IBAction)backHome:(id)sender
{
    [self GOHomePage];
}
@end
