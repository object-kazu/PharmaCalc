//
//  setting.h
//  PharmaCalc
//
//  Created by kazuyuki shimizu on 10/12/23.
//  Copyright 2010 momiji-mac.com. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface setting : NSObject {
@private
	NSMutableString *displayValue;
	double value_A, value_B;

	NSString *title_1,*title_2,*title_3,*title_4,*title_5;
	NSString *formula_label_1, *formula_label_2,*formula_label_3,*formula_label_4,*formula_label_5;
	//NSString *label_1,*label_2, *label_3, *label_4, *label_5;
	NSString *value_a1,*value_a2,*value_a3,*value_a4,*value_a5;
	NSString *value_b1,*value_b2,*value_b3,*value_b4,*value_b5;
	double a1,a2,a3,a4,a5;
	double b1,b2,b3,b4,b5;
}

-init;
-(void)dataCheck;
-(void)save;
-(NSString*)dataFilePath;
-(void)load;
-(void)input:(NSInteger)editing label:(NSString*)label a:(NSString*)valueA b:(NSString*)valueB;
-(NSString*)display_title:(NSInteger)sender;
-(NSString*)display_formula:(NSInteger)sender;
-(NSString*)display_formula_label:(NSInteger)sender;
//-(NSString*)display_label:(NSInteger)sender;
-(NSString*)display_a:(NSInteger)sender;
-(NSString*)display_b:(NSInteger)sender;

@end
