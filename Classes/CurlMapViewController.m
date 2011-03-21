//
//  Copyright (c) 2011, Fairfax Media Publications Pty Limited
//  All rights reserved.
//
//  Redistribution and use in source and binary forms, with or without
//  modification, are permitted provided that the following conditions are met:
//		* Redistributions of source code must retain the above copyright
//		  notice, this list of conditions and the following disclaimer.
//		* Redistributions in binary form must reproduce the above copyright
//		  notice, this list of conditions and the following disclaimer in the
//		  documentation and/or other materials provided with the distribution.
//		* Neither the name of the Fairfax Media nor the
//		  names of its contributors may be used to endorse or promote products
//		  derived from this software without specific prior written permission.
//
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
//  AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
//  THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
//  PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR
//  CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
//  EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
//  PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS;
//  OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
//  WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
//  OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
//  ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//

#import "CurlMapViewController.h"
#import <MapKit/MapKit.h>
#import "FDCurlViewControl.h"

@implementation CurlMapViewController

@synthesize mapView = mapView_;
@synthesize optionsView = optionsView_;
@synthesize curlButton = curlButton_;

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
	[self setCurlButton:nil];
	
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
	[mapView setMapType:MKMapTypeStandard];
	self.mapView = mapView;
	[self.view addSubview:self.mapView];
	[mapView release];
	
	CurlMapOptionsView *optionsView = [[CurlMapOptionsView alloc] initWithFrame:self.view.bounds];
	[optionsView setPaddingTop:round(CGRectGetHeight(self.view.frame)/2.0f)];
	[optionsView setMapView:self.mapView];
	[optionsView setDelegate:self];
	[optionsView setAutoresizingMask:UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth];
	self.optionsView = optionsView;
	[self.view insertSubview:self.optionsView belowSubview:self.mapView];
	[optionsView release];
	
	FDCurlViewControl *curlButton = [[FDCurlViewControl alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 30.0f, 30.0f)];
	[curlButton setAutoresizingMask:UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth];
	[curlButton setHidesWhenAnimating:NO];
	[curlButton setTargetView:self.mapView];
	UIBarButtonItem *curlButtonItem = [[UIBarButtonItem alloc] initWithCustomView:curlButton];
	self.curlButton = curlButton;
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

#pragma mark -
#pragma mark CurlMapOptionsViewDelegate methods
- (void)curlMapOptionsViewDidCaptureTouchOnPaddingRegion:(CurlMapOptionsView *)curlMapOptionsView {
	[self.curlButton curlViewDown];
}


@end
