//
//  CurlMapViewController.h
//  FDCatalog
//
//  Created by Virgilio Neto on 21/03/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MKMapView;

@interface CurlMapViewController : UIViewController {
	MKMapView *mapView_;
	UIView *optionsView_;
}

@property (nonatomic, retain) MKMapView *mapView;
@property (nonatomic, retain) UIView *optionsView;

@end
