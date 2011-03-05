//
//  HighScoreRecord.h
//  Brain Numbers
//
//  Created by Patrick Santana on 27/03/10.
//  Copyright 2010 Moogu. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface HighScoreRecord : NSObject <NSCoding, NSCopying> {

	/** name of the user */
	NSString *name;
	/** the score */
	NSNumber *totalScore;
	/** the fail */
	NSNumber *totalFailScore;
	/** date record */
	NSDate *dateRecorded;
}

- (id) initWithScore:(NSString *)name TotalScore:(NSNumber *)totalScore TotalFailScore:(NSNumber *) totalFailScore;

@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSNumber *totalScore;
@property (nonatomic, retain) NSNumber *totalFailScore;
@property (nonatomic, retain) NSDate *dateRecorded;

- (NSComparisonResult) compare:(id)other;

@end
