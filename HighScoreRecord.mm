//
//  HighScoreRecord.m
//  Brain Numbers
//
//  Created by Patrick Santana on 27/03/10.
//  Copyright 2010 Moogu. All rights reserved.
//

#import "HighScoreRecord.h"

@implementation HighScoreRecord

@synthesize name;
@synthesize totalScore;
@synthesize totalFailScore;
@synthesize dateRecorded;

- (id) initWithScore:(NSString *)playerName TotalScore:(NSNumber *)score TotalFailScore:(NSNumber *) failScore{
    if (self = [super init])
	{
		name = playerName;
		totalScore = score;
		totalFailScore = failScore;
		/** actual date */
		dateRecorded = [NSDate date];
	}
    return self;
}

- (NSComparisonResult) compare:(id)other {
	return [self.totalScore compare:other];
}

#pragma mark NSCoding
- (void)encodeWithCoder:(NSCoder *)encoder {
	[encoder encodeObject:name forKey:@"Name"];
	[encoder encodeObject:totalScore forKey:@"TotalScore"];
	[encoder encodeObject:totalFailScore forKey:@"TotalFailScore"];
	[encoder encodeObject:dateRecorded forKey:@"DateRecorded"];
}

- (id)initWithCoder:(NSCoder *)decoder {
	if(self = [super init]) {
		self.name = [decoder decodeObjectForKey:@"Name"];
		self.totalScore = [decoder decodeObjectForKey:@"TotalScore"];
		self.totalFailScore = [decoder decodeObjectForKey:@"TotalFailScore"];
		self.dateRecorded = [decoder decodeObjectForKey:@"DateRecorded"];
	}
	return self;
}

#pragma mark -
#pragma mark NSCopying
- (id)copyWithZone:(NSZone *)zone {
	HighScoreRecord *copy = [[[self class] allocWithZone:zone] init];
	name = [self.name copy];
	totalScore = [self.totalScore copy];
	totalFailScore = [self.totalFailScore copy];
	dateRecorded = [self.dateRecorded copy];
	
	return copy;
}
#pragma mark -

- (void)dealloc {
	[name release];
	[totalScore release];
	[totalFailScore release];
	[dateRecorded release];
	
    [super dealloc];
}

@end
