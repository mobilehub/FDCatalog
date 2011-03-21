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

#import "CurlMapOptionsView.h"
#import <MapKit/MKMapView.h>

@implementation CurlMapOptionsView

@synthesize segmentedControl = segmentedControl_;
@synthesize paddingTop = paddingTop_;
@synthesize mapView = mapView_;
@synthesize delegate = delegate_;

- (void)dealloc {
	[self setSegmentedControl:nil];
	[self setMapView:nil];
	
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
		[self setBackgroundColor:[UIColor grayColor]];
		
		UISegmentedControl *segmentedControl = [[UISegmentedControl alloc] initWithItems:
												[NSArray arrayWithObjects:
												 NSLocalizedString(@"Standard", nil),
												 NSLocalizedString(@"Satelite", nil),
												 NSLocalizedString(@"Hybrid", nil),
												 nil]];
		[segmentedControl setSelectedSegmentIndex:0];
		[segmentedControl addTarget:self
							 action:@selector(changeMapViewType)
				   forControlEvents:UIControlEventValueChanged];
		[self addSubview:segmentedControl];
		self.segmentedControl = segmentedControl;
		[segmentedControl release];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
	NSString *text = NSLocalizedString(@"Use this space to show any information or other controls related to the curled view, on this example we use it to present a segmented control to select the mapView type.", nil);
	
	CGRect segmentedControlFrame = self.segmentedControl.frame;
	segmentedControlFrame.origin.y = self.paddingTop;
	segmentedControlFrame.size.width = MAX(CGRectGetWidth(segmentedControlFrame), CGRectGetWidth(self.frame)/1.5f);
	segmentedControlFrame.origin.x = (CGRectGetWidth(self.frame) - CGRectGetWidth(segmentedControlFrame)) / 2.0f;
	self.segmentedControl.frame = CGRectIntegral(segmentedControlFrame);	
}

- (void)changeMapViewType {
	[self.mapView setMapType:self.segmentedControl.selectedSegmentIndex];
}

- (void)touchesBegan:(NSSet*)touches withEvent:(UIEvent*)event {
	for (UITouch *touch in touches) {
		CGPoint point = [touch locationInView:self];
		if (point.y < self.paddingTop) {
			if ([self.delegate respondsToSelector:@selector(curlMapOptionsViewDidCaptureTouchOnPaddingRegion:)]) {
				[self.delegate curlMapOptionsViewDidCaptureTouchOnPaddingRegion:self];
			}
		}
	}
}

@end
