//
//  PharmaCalcAppDelegate.h
//  PharmaCalc
//
//  Created by 清水 一征 on 10/06/24.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PharmaCalcViewController;

@interface PharmaCalcAppDelegate : NSObject <UIApplicationDelegate,UITextFieldDelegate> {
    UIWindow *window;
    PharmaCalcViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet PharmaCalcViewController *viewController;

@end

