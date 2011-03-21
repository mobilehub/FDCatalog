//
//  RootViewController.m
//  FDCatalog
//
//  Created by Virgilio Neto on 18/03/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "RootViewController.h"

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
		self.rows = [NSArray arrayWithObjects:
					 [NSDictionary dictionaryWithObjectsAndKeys:
					  @"FDCurlViewButton", @"title",
					  @"loadCurlViewButtonSample", @"selectorString",
					  nil],
					 [NSDictionary dictionaryWithObjectsAndKeys:
					  @"FDSpeechBubble", @"title",
					  @"loadSpeechBubbleSample", @"selectorString",
					  nil],
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
- (void)loadCurlViewButtonSample {

}

- (void)loadSpeechBubbleSample {

}

@end
