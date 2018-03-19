//
//  calc.h
//  PharmaCalc
//
//  Created by 清水 一征 on 10/06/24.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Calc : NSObject {
@private
	NSMutableString *display_Values;
	float operand_;
	NSString *operator_;
	NSInteger unit_;
	float answer_;
}

-init;
-(void)dealloc;
-(void)inputFunc:(NSString*)input_character array:(NSMutableArray*)value_sets;
- (void) input:(NSString *) input_character;
- (NSString*) displayValue;
-(NSString*) displayUnit;
-(NSString*) displayIndicator;
-(NSString*) displayAnswer;
@end
