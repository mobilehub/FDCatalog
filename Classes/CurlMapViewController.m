    //
//  CurlMapViewController.m
//  FDCatalog
//
//  Created by Virgilio Neto on 21/03/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CurlMapViewController.h"
#import <MapKit/MapKit.h>
#import "FDCurlViewControl.h"

@implementation CurlMapViewController

@synthesize mapView = mapView_;
@synthesize optionsView = optionsView_;

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)dealloc {
	[self setMapView:nil];
	[self setOptionsView:nil];
	
	[super dealloc];
}

- (id)init {
	self = [super init];
	if (self) {
		self.title = NSLocalizedString(@"FDCurlViewControl", nil);
	}
	
	return self;
}

- (void)loadView {
	[super loadView];
	
	MKMapView *mapView = [[MKMapView alloc] initWithFrame:self.view.bounds];
	[mapView setAutoresizingMask:UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth];
	self.mapView = mapView;
	[self.view addSubview:self.mapView];
	[mapView release];
	
	UIView *optionsView = [[UIView alloc] initWithFrame:self.view.bounds];
	[optionsView setAutoresizingMask:UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth];
	self.optionsView = optionsView;
	[self.view insertSubview:self.optionsView belowSubview:self.mapView];
	[optionsView release];
	
	FDCurlViewControl *curlButton = [[FDCurlViewControl alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 30.0f, 30.0f)];
	[curlButton setAutoresizingMask:UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth];
	[curlButton setHidesWhenAnimating:NO];
	[curlButton setTargetView:self.mapView];
	UIBarButtonItem *curlButtonItem = [[UIBarButtonItem alloc] initWithCustomView:curlButton];
	[curlButton release];
	UIBarButtonItem *spacerItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
																				target:nil
																				action:nil];
	[self setToolbarItems:[NSArray arrayWithObjects:
						   spacerItem,
						   curlButtonItem,
						   nil]];
	[spacerItem release];
	[curlButtonItem release];
}

- (void)viewDidLoad {

}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	
	[self.navigationController setToolbarHidden:NO];
}

- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
	
	[self.navigationController setToolbarHidden:YES];
}

@end
