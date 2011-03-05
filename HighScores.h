//
//  HighScores.h
//  Brain Numbers
//
//  Created by Patrick Santana on 27/03/10.
//  Copyright 2010 Moogu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HighScoreRecord.h"

@interface HighScores : NSObject {}

+ (void) addNewHighScore:(HighScoreRecord *)score Operation:(NSString *)operation;
+ (void) saveLocalHighScores:(NSArray *)highScoreArray Operation:(NSString *)operation;
+ (BOOL) isNewHighScore:(NSNumber *)score Operation:(NSString *)operation;

+ (NSString *)highScoresFilePath:(NSString *)operation;
+ (NSMutableArray *)getLocalHighScores:(NSString *)operation;
+ (NSMutableArray *)sortHighScoreDictionaryArray:(NSMutableArray *)highScoreArray;


// constants
extern NSString *const HIGH_SCORE_OPERATION_ALL;
extern NSString *const HIGH_SCORE_OPERATION_PLUS;
extern NSString *const HIGH_SCORE_OPERATION_DIVIDE;
extern NSString *const HIGH_SCORE_OPERATION_MINUS;
extern NSString *const HIGH_SCORE_OPERATION_MULTIPLY;
@end