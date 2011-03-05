//
//  HighScores.m
//  Brain Numbers
//
//  Created by Patrick Santana on 27/03/10.
//  Copyright 2010 Moogu. All rights reserved.
//

#import "HighScores.h"

@implementation HighScores

const int HIGH_SCORE_COUNT = 10;
NSString * const HIGH_SCORE_OPERATION_ALL = @"HighScoresAll";
NSString * const HIGH_SCORE_OPERATION_PLUS = @"HighScoresPlus";
NSString * const HIGH_SCORE_OPERATION_DIVIDE = @"HighScoresDivide";
NSString * const HIGH_SCORE_OPERATION_MINUS = @"HighScoresMinus";
NSString * const HIGH_SCORE_OPERATION_MULTIPLY = @"HighScoresMultiply";

+ (BOOL) isNewHighScore:(NSNumber *)score Operation:(NSString *)operation{
	int totalScore = [score intValue];
	if (totalScore <1){
		// if user did nothing, don't save it 
		return NO;
	}
	
	/** get the lowest value in the array */
	NSMutableArray *locals = [HighScores getLocalHighScores: operation];
	
	/** first register */
	if (locals == nil){
		return YES;
	}
	
	int size = [locals count];
	if ( size <10 ){
		/** record is new or does not exist, can be added */
		return YES;
	}
	
	NSUInteger lastIdx = size-1;
	HighScoreRecord *lastRecord = [locals objectAtIndex:lastIdx];
	
	/** validate if can be saved */
	if ( totalScore >= [lastRecord.totalScore intValue]){
		return YES;
	}
	
	return NO;
}

+ (void)addNewHighScore:(HighScoreRecord *)score Operation:(NSString *)operation{
	NSLog(@"Executing method addNewHighScore score = %@ operation = %@",score,operation);
	NSMutableArray *locals = [HighScores getLocalHighScores: operation];
	
	/** this is only valid for the first register */
	if (locals == nil){
		NSLog(@"First register for operation %@",operation);
		NSMutableArray *array = [[NSMutableArray alloc] init]; 
		[array addObject:score];
		locals = [[[NSMutableArray alloc] initWithArray:array copyItems:NO] autorelease];
		[HighScores saveLocalHighScores:locals Operation:operation];
		return;
	}
	
	int totalScore = [score.totalScore intValue];
	if (locals.count < HIGH_SCORE_COUNT){
		[locals addObject:score];
		NSMutableArray *sortedLocals = [HighScores sortHighScoreDictionaryArray:locals];
		[HighScores saveLocalHighScores:sortedLocals Operation:operation];
		[sortedLocals release];
	} else {
		NSUInteger lastIdx = HIGH_SCORE_COUNT-1;
		HighScoreRecord *lastRecord = [locals objectAtIndex:lastIdx];
		if (totalScore > [lastRecord.totalScore intValue]){
			[locals addObject:score];
			NSMutableArray *sortedLocals = [HighScores sortHighScoreDictionaryArray:locals];
			[sortedLocals removeLastObject];
			
			[HighScores saveLocalHighScores:sortedLocals Operation:operation];
			
			[sortedLocals release];
		}
	}
}

+ (NSString *)highScoresFilePath:(NSString *)operation {
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	
	if (operation == HIGH_SCORE_OPERATION_ALL){
	return [documentsDirectory stringByAppendingPathComponent:@"HighScoresFile"];	
	}else if (operation == HIGH_SCORE_OPERATION_MULTIPLY){
		return [documentsDirectory stringByAppendingPathComponent:@"HighScoresFileMultiply"];	
	}else if (operation == HIGH_SCORE_OPERATION_DIVIDE){
		return [documentsDirectory stringByAppendingPathComponent:@"HighScoresFileDivide"];	
	}else if (operation == HIGH_SCORE_OPERATION_PLUS){
		return [documentsDirectory stringByAppendingPathComponent:@"HighScoresFilePlus"];	
	}else if (operation == HIGH_SCORE_OPERATION_MINUS){
		return [documentsDirectory stringByAppendingPathComponent:@"HighScoresFileMinus"];	
	}
	
	return nil;
}

+ (NSMutableArray *)getLocalHighScores:(NSString *)operation {
	NSLog(@"Executing method getLocalHighScores for operation %@",operation);
	
	NSData *data = [[NSMutableData alloc] initWithContentsOfFile:[HighScores highScoresFilePath:operation]];
	NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
	NSArray *highScores = [unarchiver decodeObjectForKey:@"highScore"];
	
	if (highScores == nil){
		NSLog(@"Local high score is null for operation %@. Add the first element.",operation);
		[highScores autorelease];
		[unarchiver release];
		[data release];
		return nil;
	}
	
	
	return [[[NSMutableArray alloc] initWithArray:highScores copyItems:NO] autorelease];
}

+ (void)saveLocalHighScores:(NSArray *)highScoreArray Operation:(NSString *)operation{
	NSLog(@"Executing method saveLocalHighScores for highScoreArray %@ and for operation %@",highScoreArray, operation);
	
	NSMutableData *data = [[NSMutableData alloc] init];
	NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
	
	[archiver encodeObject:highScoreArray forKey:@"highScore"];
	[archiver finishEncoding];
	
	[data writeToFile:[HighScores highScoresFilePath:operation] atomically:YES];
	[archiver release];
	[data release];
}

+ (NSMutableArray *)sortHighScoreDictionaryArray:(NSMutableArray *)highScoreArray {
	NSLog(@"Executing method sortHighScoreDictionaryArray");
	
	
	NSString *SORT_KEY = @"totalScore";
	NSSortDescriptor *scoreDescriptor = [[[NSSortDescriptor alloc] initWithKey:SORT_KEY ascending:NO selector:@selector(compare:)] autorelease];
	NSArray *sortDescriptors = [NSArray arrayWithObjects:scoreDescriptor, nil];
	
	NSArray *sortedArray = [highScoreArray sortedArrayUsingDescriptors:sortDescriptors];
	
	NSLog(@"Array is sorted!");
	
	return [[NSMutableArray alloc] initWithArray:sortedArray copyItems:NO];
}

@end