//
//  PharmaCalcViewController.h
//  PharmaCalc
//
//  Created by 清水 一征 on 10/06/24.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Calc.h"
#import "setting.h"
#import <AudioToolbox/AudioToolbox.h>


@interface PharmaCalcViewController : UIViewController {

	
	Calc *calc_;
	setting *setting_;
	
	//setting view
	IBOutlet UIView *settingView;
	IBOutlet UIBarItem *barTitle_1, *barTitle_2, *barTitle_3, *barTitle_4, *barTitle_5;
	IBOutlet UILabel *formula_label,*formula,*error_;
	IBOutlet UITextField *expression_label;
	IBOutlet UITextField *expression_a, *expression_b;
	NSInteger editingIndicator;
	
	//calc view
	IBOutlet UILabel *indicator;
    IBOutlet UILabel *display;	//display results
	IBOutlet UILabel *unitLabel;	//unit_Display
	IBOutlet UILabel *answer_stock;  // answer stock temporary
	
	//function key
	IBOutlet UILabel *function_1, *function_2, *function_3, *function_4, *function_5;
	
	//unit calc image
	UIImage *unitSet, *unitCalc;
	IBOutlet UIButton *unitCalc_button, *unitClear_button;
	Boolean unitFlag; //unitFlag = yes のときは　unitCalc, No のときはunitSet
	
	//sound effect
	SystemSoundID soundID;

}

@property (nonatomic,retain) IBOutlet UIView *settingView;

-(IBAction)settingConf;
-(IBAction)done;

-(IBAction)selection:(id)sender;
-(void)expressions:(NSInteger)tag;
-(IBAction) press:(id)sender;
-(void)functionKeyTitle;
-(void)imageInit;
-(void)unitImageControl;
-(NSMutableArray*) function:(NSString*)label a:(NSString*)value_A b:(NSString*)value_B;

@end

