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

#import "RootViewController.h"
#import "CurlMapViewController.h"

@implementation RootViewController

@synthesize rows = rows_;

#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}

- (void)dealloc {
	[self setRows:nil];
	
    [super dealloc];
}

#pragma mark -
- (id)init {
	self = [super initWithStyle:UITableViewStylePlain];
	
	if (self) {
		self.title = NSLocalizedString(@"FDCatalog", nil);
		
		self.rows = [NSArray arrayWithObjects:
					 [NSDictionary dictionaryWithObjectsAndKeys:
					  @"FDCurlViewControl", @"title",
					  @"loadCurlViewControlSample", @"selectorString",
					  nil],
					 //[NSDictionary dictionaryWithObjectsAndKeys:
//					  @"FDSpeechBubble", @"title",
//					  @"loadSpeechBubbleSample", @"selectorString",
//					  nil],
					 nil];
	}
	
	return self;
}

- (void)loadView {
	[super loadView];
	
	self.tableView.delegate = self;
	self.tableView.dataSource = self;
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	
	[self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow]
								  animated:animated];
}

#pragma mark -
#pragma mark UITableViewDelegate methods
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
	NSDictionary *dictionary = [self.rows objectAtIndex:indexPath.row];
	
	[cell.textLabel setText:[dictionary objectForKey:@"title"]];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	NSDictionary *dictionary = [self.rows objectAtIndex:indexPath.row];
	
	SEL selector = NSSelectorFromString([dictionary objectForKey:@"selectorString"]);
	
	if ([self respondsToSelector:selector]) {
		[self performSelector:selector];
	}
}

#pragma mark -
#pragma mark UITableViewDataSource methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [self.rows count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {	
	static NSString *const reuseIdentifier = @"UITableViewCellIdentifier";
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
	if (!cell) {
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
									  reuseIdentifier:reuseIdentifier] autorelease];
		
		[cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
	}
	
	return cell;
}

#pragma mark -
#pragma mark cells methods
- (void)loadCurlViewControlSample {
	CurlMapViewController *viewController = [[CurlMapViewController alloc] init];
	[self.navigationController pushViewController:viewController animated:YES];
	[viewController release];
}

- (void)loadSpeechBubbleSample {

}

@end
