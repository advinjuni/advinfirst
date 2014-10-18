//
//  pcWebViewDetailController.h
//  phoneContact
//
//  Created by wangjian on 10/17/14.
//  Copyright (c) 2014 Advin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface pcWebViewDetailController : UIViewController <MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapview;
@property (retain, nonatomic) IBOutlet UIBarButtonItem *back;
- (IBAction)GoBack:(id)sender;

@end