//
//  PharmaCalcAppDelegate.m
//  PharmaCalc
//
//  Created by 清水 一征 on 10/06/24.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "PharmaCalcAppDelegate.h"
#import "PharmaCalcViewController.h"

@implementation PharmaCalcAppDelegate

@synthesize window;
@synthesize viewController;


- (void)applicationDidFinishLaunching:(UIApplication *)application {    
    
    // Override point for customization after app launch    
    [window addSubview:viewController.view];
    [window makeKeyAndVisible];
}


- (void)dealloc {
    [viewController release];
    [window release];
    [super dealloc];
}


@end
