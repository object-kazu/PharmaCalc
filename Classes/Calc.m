//
//  calc.m
//  PharmaCalc
//
//  Created by 清水 一征 on 10/06/24.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Calc.h"
#import "def.h"

// These string constants contain the characters that the input: method accepts.
const NSString *Operators = @"+-x/";
const NSString *Equals    = @"=";
const NSString *Digits    = @"0123456789.";
const NSString *Period    = @".";
const NSString *Delete    = @"D";
const NSString *Clear     = @"C";
const NSString *Unit	  =@"unit";
const NSString *UnitClear = @"uc";
const NSString *Answer		=@"ans";
const NSString *Functions = @"BPJTA";//@"Bis Ana Pak Jei Tori";
const NSString *specical_Charactor = @"$$";


@implementation Calc

#pragma mark Lifecycle

- init{
		if (self = [super init]) {
			display_Values = [[NSMutableString stringWithCapacity:20]retain];
			operator_ = nil;
		}
	return self;
}

- (void)dealloc{
	[display_Values release];
	[operator_ release];
	[super dealloc];
}

#pragma mark -
#pragma mark for Functions
-(void)inputFunc:(NSString*)input_character array:(NSMutableArray*)value_sets{
	static BOOL last_charactor = NO;
	
	//input_charctor is Digits?
	if ([Digits rangeOfString:input_character].length) {
		if (last_charactor) {
			[display_Values setString:input_character];
			last_charactor = NO;
		}
		else if(![input_character isEqualToString:(NSString	*)Period] || [display_Values rangeOfString:(NSString*)Period].location == NSNotFound ){
			[display_Values appendString:input_character];
		}
	}
	//in case of Function key
	else if([Functions rangeOfString:input_character].length) {
		float constant_A=0;
		float constant_B=0;
	
		constant_A = [[value_sets objectAtIndex:1]floatValue];
		constant_B = [[value_sets objectAtIndex:2]floatValue];
		
		//when SPECIAL_CHARACTOR is active (when expression_B = $)
		if([[value_sets objectAtIndex:2] isEqualToString:@"$"] ){
		
			constant_A = [[value_sets objectAtIndex:1]floatValue];
		
			float operand_func = [[self displayValue] floatValue];
			operand_func = operand_func * constant_A + operand_func;
			NSString* temp_display = [NSString stringWithFormat:@"%0.3f",operand_func];
			[display_Values setString:temp_display];
			
		}else{
			
			float operand_func = [[self displayValue] floatValue];
			operand_func = operand_func * constant_A + constant_B;
			NSString* temp_display = [NSString stringWithFormat:@"%0.3f",operand_func];
			[display_Values setString:temp_display];
		}
	}	
	else { // unexpected charactor
		[display_Values setString:[NSString string]];
	}
	
}

#pragma mark -
#pragma mark calc operation

- (void) input:(NSString *) input_character {

//	[displayValues setString:input_character];
	
	/* last_chactor is not degit and peropd */
	/* if last_chactor is true >>> call other function */
	static BOOL last_charactor = NO;
	
	//input_charctor is Digits?
	if ([Digits rangeOfString:input_character].length) {
		if (last_charactor) {
			[display_Values setString:input_character];
			last_charactor = NO;
		}
		else if(![input_character isEqualToString:(NSString	*)Period] || [display_Values rangeOfString:(NSString*)Period].location == NSNotFound ){
			[display_Values appendString:input_character];
		}
	}
	//input_charactor is Operators or Equal?
	else if([Operators rangeOfString:input_character].length || [input_character isEqualToString:(NSString *)Equals]){

		if (!operator_ && ![input_character isEqualToString:(NSString*)Equals]) {//this "if" statement is error treatment!
			//SAVE the operand and operator

			operand_ = [[self displayValue] floatValue];
			operator_ = input_character;
			
		
		}else {	
			// input_charactor is Operators or Equals
			//calc do
			//display results
			
			if (operator_) {

				float operand2 = [[self displayValue] floatValue];
				switch ([Operators rangeOfString:operator_].location) {
				case 0:
					operand_ = operand_ + operand2;
					break;
				case 1:
					operand_ = operand_ - operand2;
					break;
				case 2:
					operand_ = operand_ * operand2;
					break;
				case 3:
					operand_ = operand_ / operand2;
					break;
				}
				[display_Values setString:[[NSNumber numberWithFloat:operand_] stringValue]];
			}
			//SAVE the operation
			operator_ = ([input_character isEqualToString:(NSString *)Equals])? nil : input_character;
			}
		last_charactor = YES;
	}
	// in case of Delete
	else if ([input_character isEqualToString:(NSString*)Delete]){
		//remove the rightmost charactor from display_values
		NSInteger indexOfCharToRemove = [display_Values length] -1;
		if (indexOfCharToRemove >= 0) {
			[display_Values deleteCharactersInRange:NSMakeRange(indexOfCharToRemove,1)];
			last_charactor = NO;
		}
	}
	//in case of Clear
	else if([input_character isEqualToString:(NSString*)Clear]) {
		//if there's something in display_values, clear it
		if ([display_Values length]) {
			[display_Values setString:[NSString string]];
		}else{
			operator_ = nil;
			answer_ = 0;
		}
	
	}
	//in case of Unit key
	else if([input_character isEqualToString:(NSString*)Unit]){
		if ([display_Values length] && unit_ <= 0 ) {
			unit_ = [[self displayValue] intValue];
			operator_ = nil;
			[display_Values setString:[NSString string]];
		}else if ([display_Values length] && unit_ >0) {
			//unit calc start
			//整数のみに対応する
			
			int operand_base = [[self displayValue] intValue];
			
			//modf(整数部と小数部に分ける）を使用するためにdoubleに変換しておく
			//operand_base = (number_int * unit_) + number_odd(あまり）
			
			//number_odd（あまり）をもとめる
			NSInteger number_odd = operand_base % unit_;
			
			//number_intをもとめる
			NSInteger number_int = operand_base / unit_;
			
			//検算補助用（表示用）
			NSInteger number_times = number_int * unit_;
			
			//表示形式
			if (operand_base > 1000000000 || operand_base < -100000000) {
				//%e:指数表示では、正確な計算にならないときがある。
				//表示文字の色を変えて注意を喚起する必要がある	
				NSString *temp_display = [NSString stringWithFormat:@"<CAUTION> VALUE UNDER 1,000,000,000"];
				[display_Values setString:temp_display];
			
			}else{
				NSString* temp_display = [NSString stringWithFormat:@"(%d) = %d u(%d) + %d",operand_base, number_int, number_times, number_odd];
				[display_Values setString:temp_display];
			}
		}
	}
	// in case of unit clear key
	else if([input_character isEqualToString:(NSString*)UnitClear]){
		unit_ = 0;
		[display_Values setString:[NSString string]];

	}
	
	// in case of Answer key
	else if	([input_character isEqualToString:(NSString*)Answer]){
		if (answer_ == 0) {
			answer_ = [[self displayValue] floatValue];
			operator_ = nil;
			[display_Values setString:[NSString string]];			
		}
		else {
			NSString *temp_answer = [NSString stringWithFormat:@"%0.2f",answer_];
			[display_Values setString:temp_answer];
			answer_ = 0;
		}

	}

	else { // unexpected charactor
		[display_Values setString:[NSString string]];
	}
}

/*
 * The displayValue method rerutns a copy of _display.
 */

-(NSString *) displayValue {
	if ([display_Values length]) {
		return [[display_Values copy] autorelease];
	}
	return @"0";
}

-(NSString*) displayIndicator{
	if ([operator_ length]) {
		NSString *operator_now = [NSString stringWithFormat:@"%@", operator_];
		return [[operator_now copy]autorelease]; 
	}
	return @"";
}

-(NSString*) displayUnit{
	if (unit_ > 0) {
		if (unit_ > 100000) {
			NSString* unitForString = [NSString stringWithFormat:@"%1.4e",unit_];
			return [[unitForString copy]autorelease];
		}else {
			NSString* unitForString = [NSString stringWithFormat:@"%d",unit_];
			return [[unitForString copy]autorelease];
		}
	}
	return @"";
}

-(NSString*) displayAnswer{
	if (answer_ > 0) {
		NSString* answerForString = [NSString stringWithFormat:@"%0.2f",answer_];
		return [[answerForString copy]autorelease];
	}
	return @"";
}

@end
