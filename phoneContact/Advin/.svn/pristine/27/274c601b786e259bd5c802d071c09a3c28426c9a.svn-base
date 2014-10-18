//
//  pcWebViewDetailController.m
//  phoneContact
//
//  Created by wangjian on 10/17/14.
//  Copyright (c) 2014 Advin. All rights reserved.
//

#import "pcWebViewDetailController.h"

@interface pcWebViewDetailController ()

@end

@implementation pcWebViewDetailController

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
    _mapview.mapType=MKMapTypeStandard;
    _mapview.delegate=self;
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated
{
    CLLocation *location=[[CLLocation alloc]initWithLatitude:40 longitude:100];
    MKCoordinateRegion viewregion = MKCoordinateRegionMakeWithDistance( location.coordinate, 1000, 1000);
    [_mapview setRegion:viewregion animated:YES];
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) mapViewDidFailLoadingMap:(MKMapView *)mapView withError:(NSError *)error
{
    NSLog(@"error: %@",[error description]);
}

- (IBAction)GoBack:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
