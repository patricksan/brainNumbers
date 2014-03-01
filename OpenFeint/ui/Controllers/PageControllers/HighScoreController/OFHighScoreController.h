//  Copyright 2009-2010 Aurora Feint, Inc.
// 
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//  
//  	http://www.apache.org/licenses/LICENSE-2.0
//  	
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.

#import "OFTableSequenceControllerHelper.h"
#import "OFTabBar.h"
#import "OFProfileFrame.h"
#import <CoreLocation/CoreLocation.h>
#import "OFImportFriendsController.h"

@class OFLeaderboard;
@class OFGameProfilePageInfo;
@class OFHighScore;

@interface OFHighScoreController : OFTableSequenceControllerHelper<OFProfileFrame, UINavigationControllerDelegate>
{
@package
	OFLeaderboard* leaderboard;
	NSString* noDataFoundMessage;
	OFGameProfilePageInfo* gameProfileInfo;
    
    OFPaginatedSeries* friendResources;
    OFPaginatedSeries* globalResources;
    BOOL gameCenterLoadFinished;
    NSUInteger timeScope;  //this matches the gameCenter timescope for easier processing (0=today, 1=week, 2=allTime)
    BOOL loadingInProcess;
}
- (void)setTimeScopingAll;
- (void)setTimeScopingDay;
- (void)setTimeScopingWeek;

//---------------------------

- (void)downloadBlobForHighScore:(OFHighScore*)highScore;

@property (nonatomic, retain) OFGameProfilePageInfo* gameProfileInfo;
@property (nonatomic, retain) OFLeaderboard* leaderboard;
@end