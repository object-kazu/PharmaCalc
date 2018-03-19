//
//  PharmaCalcViewController.m
//  PharmaCalc
//
//  Created by 清水 一征 on 10/06/24.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "PharmaCalcViewController.h"
#import "def.h"

@implementation PharmaCalcViewController 

@synthesize settingView;

-(IBAction)settingConf{
		
	//change view animation
	UIViewAnimationTransition transition = UIViewAnimationTransitionFlipFromLeft;
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDuration:1.0];
	settingView.hidden = NO;
	[UIView setAnimationTransition:transition forView:self.view cache:YES];
	[UIView commitAnimations];
	
}

//At setting configuration
-(IBAction)done{ // escape form setting conf.
	
	//function key title change
	[self functionKeyTitle];
	
	//change view animation
	UIViewAnimationTransition transition = UIViewAnimationTransitionFlipFromLeft;
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDuration:1.0];
	settingView.hidden = YES;
	[UIView setAnimationTransition:transition forView:self.view cache:YES];
	[UIView commitAnimations];
}

-(IBAction)selection:(id)sender{ // select button(function number)
	//11 ~ 15 >>>> data call
	//16(setting button) >>> save data
	
	switch ([sender tag]) {
			//data call
			//case 11 ~ 15は表示を更新
		case 11:
			[barTitle_1 setTitle:[setting_ display_title:[sender tag]]];
			[self expressions:[sender tag]];
			editingIndicator = 11;
			break;
		case 12:
			[barTitle_2 setTitle:[setting_ display_title:[sender tag]]];
			[self expressions:[sender tag]];
			editingIndicator = 12;
			break;
		case 13:
			[barTitle_3 setTitle:[setting_ display_title:[sender tag]]];
			[self expressions:[sender tag]];
			editingIndicator = 13;
			break;
		case 14:
			[barTitle_4 setTitle:[setting_ display_title:[sender tag]]];
			[self expressions:[sender tag]];
			editingIndicator = 14;
			break;
		case 15:
			[barTitle_5 setTitle:[setting_ display_title:[sender tag]]];
			[self expressions:[sender tag]];
			editingIndicator = 15;
			break;
			
			//setting button
			//save data
		case 16:
			if (editingIndicator == 0) {
				editingIndicator = 11; //default設定は11にする。
			}
			if (editingIndicator) {
				NSString *temp_label= expression_label.text;
				NSString *temp_a = expression_a.text;
				NSString *temp_b = expression_b.text;
				switch (editingIndicator) {
					case 11:
						[barTitle_1 setTitle:temp_label];
						[setting_ input:editingIndicator label:[temp_label copy] a:[temp_a copy] b:[temp_b copy]];
						break;
					case 12:
						[barTitle_2 setTitle:temp_label];
						[setting_ input:editingIndicator label:[temp_label copy] a:[temp_a copy] b:[temp_b copy]];
						break;
					case 13:
						[barTitle_3 setTitle:temp_label];
						[setting_ input:editingIndicator label:[temp_label copy] a:[temp_a copy] b:[temp_b copy]];
						break;
					case 14:
						[barTitle_4 setTitle:temp_label];
						[setting_ input:editingIndicator label:[temp_label copy] a:[temp_a copy] b:[temp_b copy]];
						break;
					case 15:
						[barTitle_5 setTitle:temp_label];
						[setting_ input:editingIndicator label:[temp_label copy] a:[temp_a copy] b:[temp_b copy]];
						break;
					default:
						NSLog(@"error at selection method");
						break;
				}
				[setting_ save];
				
				//formula表示更新
				formula.text = [NSString stringWithFormat:@"%@",[setting_ display_formula:editingIndicator]];
			}
			break;

		}
		
}
-(void)expressions:(NSInteger)tag{
	formula.text = [NSString stringWithFormat:@"%@",[setting_ display_formula:tag]];
	expression_label.text = [NSString stringWithFormat:@"%@",[setting_ display_title:tag]];
	expression_a.text = [NSString stringWithFormat:@"%@",[setting_ display_a:tag]];
	expression_b.text = [NSString stringWithFormat:@"%@",[setting_ display_b:tag]];
}

-(IBAction) press:(id)sender{
	//sound
	AudioServicesPlaySystemSound(soundID);

	//	AudioServicesPlayAlertSound(soundID);//バイブレーション付き
	
	// sender swich
	if ([sender tag] > 20 ) { //function keyを選択した場合（function key のtag は　２１−２５）
		//tagは10番大きい数字に設定しているので−１０とする。
		NSInteger temp = [sender tag] -10;
		[calc_ inputFunc:[sender titleForState:UIControlStateNormal] array:[self function:[setting_ display_title:temp] 
																						a:[setting_ display_a:temp] 
																						b:[setting_ display_b:temp]]];
	}else {
		[calc_ input:[sender titleForState:UIControlStateNormal]];
	}

	//sender tag == 19 (unit button) 表示を変更する
	if ([sender tag] == 19) {
//		float temp_unit = [[calc_ displayUnit] floatValue];*************
		NSInteger temp_unit = [[calc_ displayUnit] intValue];

		if (temp_unit == 0){
			unitFlag = YES;
		}else {
			unitFlag = NO;
		}		
		[self unitImageControl];
	}
	
	// sender tag  == 18 (unit clear button)
	if ([sender tag] == 18) {
		unitFlag = YES;
		[self unitImageControl];
	}
	
	//text display
	display.text = [NSString stringWithFormat:@"%@",[calc_ displayValue]];
	
	 //indicator display
	indicator.text = [NSString stringWithFormat:@"%@",[calc_ displayIndicator]];
	
	//unit display
	unitLabel.text =  [NSString stringWithFormat:@"%@",[calc_ displayUnit]];
	
	//answer display
	answer_stock.text = [NSString stringWithFormat:@"%@",[calc_ displayAnswer]];

	 
}

-(void)unitImageControl{
	if (unitFlag == NO) {
		[unitCalc_button setImage:unitCalc forState:UIControlStateNormal];
	}else {
		[unitCalc_button setImage:unitSet forState:UIControlStateNormal];
	}
	
}

#pragma mark -
#pragma mark UITextField Delete setting
//retuen key を押すとkeyboardを消す。
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
	[expression_label resignFirstResponder];
	[expression_a resignFirstResponder];
	[expression_b resignFirstResponder];
	
	//expression_a , expression_bには数字、expression_labelは文字数４であるか確認する
	//error message を表示・非表示
	
	
	return YES;
}

//setting 画面
//textFieldの入力確認（文字数・種類）
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
		
	if (textField.tag == 0) {		//Labelの場合
		int maxLength = MAX_label;
		NSMutableString *text = [[textField.text mutableCopy] autorelease];
		[text replaceCharactersInRange:range withString:string];
		return [text length] <= maxLength;
		
	}else if (textField.tag == 1) { //expression_aの場合
		//文字数の確認
		int maxLength = MAX_express_A;
		NSMutableString *text = [[textField.text mutableCopy] autorelease];
		[text replaceCharactersInRange:range withString:string];
		return [text length] <= maxLength;
		
	}else if (textField.tag == 2) {	//expression_bの場合
		//文字数の確認
		int maxLength = MAX_express_B;
		NSMutableString *text = [[textField.text mutableCopy] autorelease];
		[text replaceCharactersInRange:range withString:string];
		return [text length] <= maxLength;
	}else {
		return NO;
	}	
}

//value_A, value_B is number or $. when these are number, ?
-(NSMutableArray*) function:(NSString*)label a:(NSString*)value_A b:(NSString*)value_B{
	NSMutableArray *array = [[[NSMutableArray alloc]init]autorelease];
	[array addObject:label];
	[array addObject:value_A];
	[array addObject:value_B];
	return array;
}

//function key titleを設定する
-(void)functionKeyTitle{
	
	function_1.text = [NSString stringWithFormat:@"%@",[setting_ display_title:11]];
	function_2.text = [NSString stringWithFormat:@"%@",[setting_ display_title:12]];
	function_3.text = [NSString stringWithFormat:@"%@",[setting_ display_title:13]];
	function_4.text = [NSString stringWithFormat:@"%@",[setting_ display_title:14]];
	function_5.text = [NSString stringWithFormat:@"%@",[setting_ display_title:15]];
	
}

-(void)imageInit{
	unitSet = [UIImage imageNamed:@"ButtonUnitSet.png"];
	unitCalc = [UIImage imageNamed:@"ButtonUnitCalc.png"];
	
	//retain しておかないと落ちる可能性あり
	[unitSet retain];
	[unitCalc retain];
	
	[unitCalc_button setImage:unitSet forState:UIControlStateNormal];
	
}

#pragma mark -
- (void)viewDidLoad {
    [super viewDidLoad];
	
	//sound effect
	NSString* path = [[NSBundle mainBundle] pathForResource:@"b10" ofType:@"caf"];

	NSURL *url = [NSURL fileURLWithPath:path];
	AudioServicesCreateSystemSoundID((CFURLRef)url, &soundID);
	
	//settingView hidden
	settingView.hidden = YES;
	error_.hidden = YES;		//error message was hidden at normal state
	
	//tag を明示的にセットする時にコメントオフand add setting tag
	[expression_label setTag:0];
	[expression_a setTag:1];
	[expression_b setTag:2];
	
	
	//for setting Class
	setting_ = [[setting alloc]init];
	
	//setting data load
	[setting_ load];
	
	//setting view 初期値を設定
	[barTitle_1 setTitle:[setting_ display_title:11]];
	[barTitle_2 setTitle:[setting_ display_title:12]];
	[barTitle_3 setTitle:[setting_ display_title:13]];
	[barTitle_4 setTitle:[setting_ display_title:14]];
	[barTitle_5 setTitle:[setting_ display_title:15]];
	[self expressions:11];
	
	//function key title setting
	[self functionKeyTitle];
	
	//unit calc image initialize and setting
	[self imageInit];
	[unitCalc_button setTag:19];
	[unitClear_button setTag:18];//invisible button
	unitFlag = NO;
	
	//calc class
	calc_ =[[Calc alloc]init];
	
	//for showing at display
	display.text = [NSString stringWithFormat:@"0"];
	display.font = [UIFont systemFontOfSize:48];

	indicator.text = [NSString stringWithFormat:@""];
	indicator.font = [UIFont systemFontOfSize:38];
	
	unitLabel.text = [NSString stringWithFormat:@""];
	unitLabel.font = [UIFont systemFontOfSize:20];
	
	answer_stock.text = [NSString stringWithFormat:@""];
	answer_stock.font =	[UIFont systemFontOfSize:20];
}



/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
    
    [self.settingView release];
    
}


- (void)dealloc {
	[calc_ release];
	[setting_ release];
	[settingView release];
	
	[unitSet release];
	[unitCalc release];
	
    [super dealloc];
}

@end
