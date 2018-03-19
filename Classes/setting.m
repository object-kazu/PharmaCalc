//
//  setting.m
//  PharmaCalc
//
//  Created by kazuyuki shimizu on 10/12/23.
//  Copyright 2010 momiji-mac.com. All rights reserved.
//

#import "setting.h"
#define kFilename	@"data.plist"
#import "def.h"

@implementation setting


-init{
	if (self = [super init]) {
		displayValue = [[NSMutableString stringWithCapacity:20]retain];
		//必要な初期化を行う。
		a1 = a2 =a3 = a4 = a5 = 1;
		b1 = b2 = b3 = b4 = b5 = 0;
	}
	return self;
	
}

-(void)dataCheck{
	if (title_1 == NULL) {title_1 = @"firs";}
	if (title_2 == NULL) {title_2 = @"seco";}
	if (title_3 == NULL) {title_3 = @"thir";}
	if (title_4 == NULL) {title_4 = @"fore";}
	if (title_5 == NULL) {title_5 = @"fift";}

	if (formula_label_1 == NULL) {formula_label_1 = @"ffi";}
	if (formula_label_2 == NULL) {formula_label_2 = @"fse";}
	if (formula_label_3 == NULL) {formula_label_3 = @"fth";}
	if (formula_label_4 == NULL) {formula_label_4 = @"ffo";}
	if (formula_label_5 == NULL) {formula_label_5 = @"ffi";}
}
-(void)save{
	//data が有るかどうか確認してからsave

	NSMutableArray *array = [[NSMutableArray alloc]init];
//index:0-4
	[array addObject:title_1];
	[array addObject:title_2];
	[array addObject:title_3];
	[array addObject:title_4];
	[array addObject:title_5];
	
//index 5-9
	[array addObject:formula_label_1];
	[array addObject:formula_label_2];
	[array addObject:formula_label_3];
	[array addObject:formula_label_4];
	[array addObject:formula_label_5];
	
//aとｂは数値なのでNSNumberで保存する
	NSNumber *num_a_1 = [NSNumber numberWithDouble:a1];
	NSNumber *num_a_2 = [NSNumber numberWithDouble:a2];
	NSNumber *num_a_3 = [NSNumber numberWithDouble:a3];
	NSNumber *num_a_4 = [NSNumber numberWithDouble:a4];
	NSNumber *num_a_5 = [NSNumber numberWithDouble:a5];
	
//index 10-14
	[array addObject:num_a_1];
	[array addObject:num_a_2];
	[array addObject:num_a_3];
	[array addObject:num_a_4];
	[array addObject:num_a_5];
	
	
	NSNumber *num_b_1 = [NSNumber numberWithDouble:b1];
	NSNumber *num_b_2 = [NSNumber numberWithDouble:b2];
	NSNumber *num_b_3 = [NSNumber numberWithDouble:b3];
	NSNumber *num_b_4 = [NSNumber numberWithDouble:b4];
	NSNumber *num_b_5 = [NSNumber numberWithDouble:b5];
	
//index 15- 19
	[array addObject:num_b_1];
	[array addObject:num_b_2];
	[array addObject:num_b_3];
	[array addObject:num_b_4];
	[array addObject:num_b_5];
	
	[array writeToFile:[self dataFilePath] atomically:YES];
	[array release];
}

-(NSString*)dataFilePath{
	NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentDirectory = [path objectAtIndex:0];
	return [documentDirectory stringByAppendingFormat:kFilename];
}
-(void)load{
	
	NSString *filePath = [self dataFilePath];
	if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
		NSArray *array = [[NSArray alloc] initWithContentsOfFile:filePath];
		
		title_1 = [[array objectAtIndex:0]retain];
		title_2 = [[array objectAtIndex:1]retain];
		title_3= [[array objectAtIndex:2]retain];
		title_4= [[array objectAtIndex:3]retain];
		title_5= [[array objectAtIndex:4]retain];

		formula_label_1 = [[array objectAtIndex:5]retain];
		formula_label_2 = [[array objectAtIndex:6]retain];
		formula_label_3 = [[array objectAtIndex:7]retain];
		formula_label_4 = [[array objectAtIndex:8]retain];
		formula_label_5 = [[array objectAtIndex:9]retain];
		
		a1 = [[array objectAtIndex:10]doubleValue];
		a2 = [[array objectAtIndex:11]doubleValue];
		a3 = [[array objectAtIndex:12]doubleValue];
		a4 = [[array objectAtIndex:13]doubleValue];
		a5 = [[array objectAtIndex:14]doubleValue];
		
		b1 = [[array objectAtIndex:15]doubleValue];
		b2 = [[array objectAtIndex:16]doubleValue];
		b3 = [[array objectAtIndex:17]doubleValue];
		b4 = [[array objectAtIndex:18]doubleValue];
		b5 = [[array objectAtIndex:19]doubleValue];
		
		[array release];
	}else {
		[self dataCheck];			
	}

}

-(void)input:(NSInteger)editing label:(NSString *)label a:(NSString *)valueA b:(NSString *)valueB{
	const NSString *specialCharactor = @"$";

#pragma mark -
#pragma mark Now editing
	if ([valueB isEqualToString:(NSString*)specialCharactor]) {
		NSLog(@"$");

		//$が入っているばあいは特別な数字を代入しておく。
		NSString*temp = [NSString stringWithFormat:@"%f",SPECIAL_CHARACTOR];
		valueB = temp;
	}
	
	
	switch (editing) {
		case 11:
			title_1 = label;
			a1 = [valueA doubleValue];
			b1 = [valueB doubleValue];
			break;
		case 12:
			title_2 = label;
			a2 = [valueA doubleValue];
			b2 = [valueB doubleValue];
			break;
		case 13:
			title_3 = label;
			a3 = [valueA doubleValue];
			b3 = [valueB doubleValue];
			break;
		case 14:
			title_4 = label;
			a4 = [valueA doubleValue];
			b4 = [valueB doubleValue];
			break;
		case 15:
			title_5 = label;
			a5 = [valueA doubleValue];
			b5 = [valueB doubleValue];
			break;
		default:
			NSLog(@"ERROR:input");
				  break;
	}
}
-(NSString*)display_title:(NSInteger)sender{
	switch (sender) {
		case 11:
			return [[title_1 copy]autorelease];	break;
		case 12:
			return [[title_2 copy]autorelease];	break;
		case 13:
			return [[title_3 copy]autorelease];	break;
		case 14:
			return [[title_4 copy]autorelease];	break;
		case 15:
			return [[title_5 copy]autorelease];	break;
		default:
			return @"ERROR:display_title";
	}
}

-(NSString*)display_formula:(NSInteger)sender{
	double temp_a, temp_b;
	NSString *temp;
	
#pragma mark NOW editing
	
	switch (sender) {
		case 11:
			if (b1 == SPECIAL_CHARACTOR) {
				temp_a = a1;
				temp = [NSString stringWithFormat:@"y = %0.2f x + x", temp_a];
				return temp;	
				
			}else{
				temp_a = a1;
				temp_b = b1;
				temp = [NSString stringWithFormat:@"y = %0.2f x + %0.2f", temp_a, temp_b];
				return temp;	
			}
			break;
		case 12:
			if (b2 == SPECIAL_CHARACTOR) {
				temp_a = a2;
				temp = [NSString stringWithFormat:@"y = %0.2f x + x", temp_a];
				return temp;	
				
			}else{
			temp_a = a2;
			temp_b = b2;
			temp = [NSString stringWithFormat:@"y = %0.2f x + %0.2f", temp_a, temp_b];
			return temp;
			}
			break;
		case 13:
			if (b3 == SPECIAL_CHARACTOR) {
				temp_a = a3;
				temp = [NSString stringWithFormat:@"y = %0.2f x + x", temp_a];
				return temp;	
				
			}else{
			temp_a = a3;
			temp_b = b3;
			temp = [NSString stringWithFormat:@"y = %0.2f x + %0.2f", temp_a, temp_b];
				return temp;
			}
			break;
		case 14:
			if (b4 == SPECIAL_CHARACTOR) {
				temp_a = a4;
				temp = [NSString stringWithFormat:@"y = %0.2f x + x", temp_a];
				return temp;	
				
			}else{
			temp_a = a4;
			temp_b = b4;
			temp = [NSString stringWithFormat:@"y = %0.2f x + %0.2f", temp_a, temp_b];
			}
			return temp;	
			break;
		case 15:
			if (b5 == SPECIAL_CHARACTOR) {
				temp_a = a5;
				temp = [NSString stringWithFormat:@"y = %0.2f x + x", temp_a];
				return temp;	
				
			}else{
			temp_a = a5;
			temp_b = b5;
			temp = [NSString stringWithFormat:@"y = %0.2f x + %0.2f", temp_a, temp_b];
			return temp;	
			}
			break;
			
		default:
			temp_a = 30;
			temp_b = 34;
			temp = [NSString stringWithFormat:@"y = %0.2f x + %0.2f", temp_a, temp_b];
			return temp;
			break;
	}
	
}

#pragma mark -
#pragma mark remove!
//remove 
-(NSString*)display_formula_label:(NSInteger)sender{
	switch (sender) {
		case 11:
			return [[formula_label_1 copy]autorelease];	break;
		case 12:
			return [[formula_label_2 copy]autorelease];	break;
		case 13:
			return [[formula_label_3 copy]autorelease];	break;
		case 14:
			return [[formula_label_4 copy]autorelease];	break;
		case 15:
			return [[formula_label_5 copy]autorelease];	break;
		default:
			return @"ERROR:display_formula_label";
	}
	
}

-(NSString*)display_a:(NSInteger)sender{
	NSNumber *temp;
	switch (sender) {
		case 11:
			temp = [NSNumber numberWithDouble:a1];
			return [[temp copy]autorelease];	break;
		case 12:
			temp = [NSNumber numberWithDouble:a2];
			return [[temp copy]autorelease];	break;
		case 13:
			temp = [NSNumber numberWithDouble:a3];
			return [[temp copy]autorelease];	break;
		case 14:
			temp = [NSNumber numberWithDouble:a4];
			return [[temp copy]autorelease];	break;
		case 15:
			temp = [NSNumber numberWithDouble:a5];
			return [[temp copy]autorelease];	break;
		default:
			return @"ERROR:display_a";
	}
}

-(NSString*)display_b:(NSInteger)sender{
	NSString *temp;
	switch (sender) {
		case 11:
			if (b1 == SPECIAL_CHARACTOR) {
				return @"$";
			}
			temp = [NSString stringWithFormat:@"%.3f",b1];
			//temp = [NSNumber numberWithDouble:b1];
			return [[temp copy]autorelease];	break;
		case 12:
			if (b2 == SPECIAL_CHARACTOR) {
				return @"$";
			}
			temp = [NSString stringWithFormat:@"%.3f",b2];
			//temp = [NSNumber numberWithDouble:b2];
			return [[temp copy]autorelease];	break;
		case 13:
			if (b3 == SPECIAL_CHARACTOR) {
				return @"$";
			}
			temp = [NSString stringWithFormat:@"%.3f",b3];
			//temp = [NSNumber numberWithDouble:b3];
			return [[temp copy]autorelease];	break;
		case 14:
			if (b4 == SPECIAL_CHARACTOR) {
				return @"$";
			}
			temp = [NSString stringWithFormat:@"%.3f",b4];
			//temp = [NSNumber numberWithDouble:b4];
			return [[temp copy]autorelease];	break;
		case 15:
			if (b5 == SPECIAL_CHARACTOR) {
				return @"$";
			}
			temp = [NSString stringWithFormat:@"%.3f",b5];
			//temp = [NSNumber numberWithDouble:b5];
			return [[temp copy]autorelease];	break;
		default:
			return @"ERROR:display_b";
	}
}


@end
