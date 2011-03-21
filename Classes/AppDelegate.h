//
//  FDCatalogAppDelegate.h
//  FDCatalog
//
//  Created by Virgilio Neto on 18/03/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RootViewController;

@interface AppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window_;
    RootViewController *rootViewController_;
}

@property (nonatomic, retain) UIWindow *window;
@property (nonatomic, retain) RootViewController *rootViewController;

@end

