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

#import "OpenFeint.h"
#import "OpenFeintDelegate.h"
#import "OFControllerLoader.h"
#import "OpenFeintSettings.h"
#import "OFReachability.h"
#import "OFProvider.h"
#import "OpenFeint+Private.h"
#import "OpenFeint+UserOptions.h"
#import <QuartzCore/QuartzCore.h>
#import "OFPoller.h"
#import "OFSettings.h"
#import "OpenFeint+Private.h"
#import "OFNotification.h"
#import "OpenFeint+Settings.h"
#import "OpenFeint+Dashboard.h"
#import "OFNavigationController.h"
#import "OFIntroNavigationController.h"
#import "OFGameProfilePageInfo.h"
#import "OFImageCache.h"
#import "OpenFeint+UserStats.h"
#import "OpenFeint+AddOns.h"

#import "OFService+Overridables.h"
#import "OFOfflineService.h"
#import "OFBootstrapService.h"
#import "OFUserSettingService.h"
#import "OFHighScoreService.h"
#import "OFLeaderboardService.h"
#import "OFLeaderboardService+Private.h"
#import "OFApplicationDescriptionService.h"
#import "OFChatRoomDefinitionService.h"
#import "OFChatRoomInstanceService.h"
#import "OFChatMessageService.h"
#import "OFProfileService.h"
#import "OFClientApplicationService.h"
#import "OFUserService.h"
#import "OFAchievementService.h"
#import "OFAchievementService+Private.h"
#import "OFChallengeService+Private.h"
#import "OFChallengeDefinitionService.h"
#import "OFUsersCredentialService.h"
#import "OFFriendsService.h"
#import "OFSocialNotificationService.h"
#import "OFPushNotificationService.h"
#import "OFForumService.h"
#import "OFAnnouncementService+Private.h"
#import "OFSubscriptionService+Private.h"
#import "OFConversationService+Private.h"
#import "OFUserFeintApprovalController.h"
#import "OpenFeint+UserOptions.h"
#import "OFPresenceService.h"
#import "OFGameDiscoveryService.h"
#import "OFTickerService.h"
#import "OFCloudStorageService.h"
#import "OFPresenceService.h"
#import "OFInviteService.h"

#import "OFChallengeDetailController.h"
#import "OFCompressableData.h"
#import "OFWebApprovalController.h"
#import "IPhoneOSIntrospection.h"
#import "OpenFeint+GameCenter.h"
#import "OFReachabilityObserver.h"

OFIntroNavigationController *gOFretainedIntroController;

@implementation OpenFeint
@synthesize mProductKey;
@synthesize dashboardVisible = mDashboardVisable;
//@synthesize locationManager;

+ (NSUInteger)versionNumber
{
	return 9282010;
}

+ (NSString*)releaseVersionString
{
	return @"2.7.3";
}

+ (void) initializeWithProductKey:(NSString*)productKey 
						andSecret:(NSString*)productSecret 
				   andDisplayName:(NSString*)displayName
					  andSettings:(NSDictionary*)settings 
					 andDelegates:(OFDelegatesContainer*)delegatesContainer
{
	[OpenFeint createSharedInstance];
	[OFImageCache initializeCache];
		
	OFControllerLoader::setAssetFileSuffix(@"Of");
	OFControllerLoader::setClassNamePrefix(@"OF");

	// Initialize OFServices
	[OFOfflineService initializeService];
	[OFBootstrapService initializeService];
	[OFUserSettingService initializeService];
	[OFHighScoreService initializeService];
	[OFSocialNotificationService initializeService];
	[OFPushNotificationService initializeService];
	[OFLeaderboardService initializeService];
	[OFApplicationDescriptionService initializeService];
	[OFChatRoomDefinitionService initializeService];
	[OFChatRoomInstanceService initializeService];
	[OFChatMessageService initializeService];	
	[OFProfileService initializeService];
	[OFClientApplicationService initializeService];
	[OFUserService initializeService];
	[OFAchievementService initializeService];
	[OFChallengeService initializeService];
	[OFChallengeDefinitionService initializeService];
	[OFUsersCredentialService initializeService];
	[OFFriendsService initializeService];
	[OFForumService initializeService];
	[OFAnnouncementService initializeService];
	[OFGameDiscoveryService initializeService];
	[OFSubscriptionService initializeService];	
	[OFConversationService initializeService];
	[OFTickerService initializeService];
	[OFCloudStorageService initializeService];
	[OFPresenceService initializeService];
	[OFInviteService initializeService];
	
	OpenFeint* instance = [OpenFeint sharedInstance];
	instance->mCachedLocalUser = nil;
			
	instance->mDelegatesContainer = delegatesContainer ? [delegatesContainer retain] : [OFDelegatesContainer new];
	instance->mOFRootController = nil;
	instance->mDisplayName = [displayName copy];
	instance->mIsDashboardDismissing = false;
#if TARGET_IPHONE_SIMULATOR
	instance->mPushNotificationsEnabled = false;
#else
	instance->mPushNotificationsEnabled = [OpenFeint isTargetAndSystemVersionThreeOh] ? [(NSNumber*)[settings objectForKey:OpenFeintSettingEnablePushNotifications] boolValue] : false;
#endif

	[self intiailizeUserStats];
	
	NSNumber* notificationPosition = (NSNumber*)[settings objectForKey:OpenFeintSettingNotificationPosition];
	instance->mNotificationPosition = notificationPosition ? (ENotificationPosition)[notificationPosition unsignedIntValue] : ENotificationPosition_TOP_LEFT;

	instance->mDisableUGC = [(NSNumber*)[settings objectForKey:OpenFeintSettingDisableUserGeneratedContent] boolValue];
	instance->mAllowErrorScreens = YES;
	
	if ([(NSNumber*)[settings objectForKey:OpenFeintSettingDisableCloudStorageCompression] boolValue])
	{
		[[OFCloudStorageService sharedInstance] disableCompression];
	}
	if ([(NSNumber*)[settings objectForKey:OpenFeintSettingOutputCloudStorageCompressionRatio] boolValue])
	{
		[[OFCloudStorageService sharedInstance] enableVeboseCompression];
	}	
    if ([(NSNumber*)[settings objectForKey:OpenFeintSettingCloudStorageLegacyHeaderlessCompression] boolValue])
	{
		[[OFCloudStorageService sharedInstance] useLegacyHeaderlessCompression];
	}
    
    [OFCompressableData setDisableCompression:[[settings objectForKey:OpenFeintSettingDisableCloudStorageCompression] boolValue]];
    [OFCompressableData setVerbose:[[settings objectForKey:OpenFeintSettingOutputCloudStorageCompressionRatio] boolValue]];
    
	instance->mIsUsingGameCenter = NO;
#ifdef __IPHONE_4_1
    if(is4Point1SystemVersion()) 
	{
        instance->mIsUsingGameCenter = [(NSNumber*)[settings objectForKey:OpenFeintSettingGameCenterEnabled] boolValue];
    }
#endif    
    

	NSNumber* dashboardOrientation = [settings objectForKey:OpenFeintSettingDashboardOrientation];
	[OpenFeint setDashboardOrientation:(dashboardOrientation ? (UIInterfaceOrientation)[dashboardOrientation intValue] : UIInterfaceOrientationPortrait)];
		
	NSString* shortName = [settings objectForKey:OpenFeintSettingShortDisplayName];
	shortName = shortName ? shortName : displayName;
	instance->mShortDisplayName = [shortName copy];

	CFUUIDRef sessionId = CFUUIDCreate(NULL);
	instance->mSessionId = (NSString*)CFUUIDCreateString(NULL, sessionId);
	CFRelease(sessionId);
	
	instance->mSessionStartDate = [[NSDate date] retain];

	instance->mReservedMemory = NULL;
	[self reserveMemory];
	
	[self intiailizeUserOptions];
	[self intiailizeSettings];

	OFSettings::Initialize();
    if(OFSettings::Instance()->getDebugOverrideKey())
	{
		productKey = OFSettings::Instance()->getDebugOverrideKey();
	}
    if(OFSettings::Instance()->getDebugOverrideSecret()) 
	{
		productSecret = OFSettings::Instance()->getDebugOverrideSecret();
	}
    [OpenFeint sharedInstance].mProductKey = productKey;
	OFReachability::Initialize();
	
	instance->mPresentationWindow = [[settings objectForKey:OpenFeintSettingPresentationWindow] retain];
	instance->mProvider = [[OFProvider providerWithProductKey:productKey andSecret:productSecret] retain];
	instance->mPoller = [[OFPoller alloc] initWithProvider:instance->mProvider sourceUrl:@"users/@me/activities.xml"];

	
	[[OFHighScoreService sharedInstance] registerPolledResources:instance->mPoller];
	[[OFChatMessageService sharedInstance] registerPolledResources:instance->mPoller];	

	[OpenFeint setUnviewedChallengesCount:0];
	[OpenFeint setPendingFriendsCount:0];
	
	[OFAchievementService setAutomaticallyPromptToPostUnlocks:[[settings objectForKey:OpenFeintSettingPromptToPostAchievementUnlock] boolValue]];
	
	OFControllerLoader::setOverrideAssetFileSuffix([settings objectForKey:OpenFeintSettingOverrideSuffixString]);
	OFControllerLoader::setOverrideClassNamePrefix([settings objectForKey:OpenFeintSettingOverrideClassNamePrefixString]);

#if defined(_DEBUG) || defined(DEBUG)
	if ([(NSNumber*)[settings objectForKey:OpenFeintSettingAlwaysAskForApprovalInDebug] boolValue])
	{
		[OpenFeint _resetHasUserSetFeintAccess];
	}
	if ([(NSNumber*)[settings objectForKey:OpenFeintSettingDisableIncompleteDelegateWarning] boolValue])
	{
		[self setShouldWarnOnIncompleteDelegates:NO];
	}
#endif

	NSString* userIdToLoginAs = [settings objectForKey:OpenFeintSettingInitialUserId];
	userIdToLoginAs = ([userIdToLoginAs length] > 0 ? userIdToLoginAs : [OpenFeint lastLoggedInUserId]);
	if ([OpenFeint doneWithGetTheMost])
	{
		[OpenFeint startLocationManagerIfAllowed];
	}
	
	[OpenFeint initializeAddOns:settings];
	
	OFDelegate noopSuccess;
	OFDelegate noopFailure;
	[self doBootstrap:NO userId:userIdToLoginAs onSuccess:noopSuccess onFailure:noopFailure];
    
	NSLog(@"Using OpenFeint version %d (%@). %@", [self versionNumber], [self releaseVersionString], OFSettings::Instance()->getServerUrl());
	
	instance->reachabilityOb = new OFReachabilityObserver(OFDelegate(self, @selector(gameServerReachabilityChanged:)));
}

+ (void) shutdown
{
	OpenFeint* instance = [OpenFeint sharedInstance];
	if (instance)
	{
        instance.mProductKey = nil;    
		[instance->mProvider destroyAllPendingRequests];
        if(instance->mIsUsingGameCenter) {
            [OpenFeint releaseGameCenter];
        }
	}
	
	[self sessionClosed];

	[OpenFeint shutdownAddOns];

	// Shutdown services
	[OFGameDiscoveryService shutdownService];
	[OFConversationService shutdownService];
	[OFSubscriptionService shutdownService];
	[OFAnnouncementService shutdownService];
	[OFForumService shutdownService];
	[OFFriendsService shutdownService];
	[OFUsersCredentialService shutdownService];
	[OFChallengeDefinitionService shutdownService];
	[OFChallengeService shutdownService];
	[OFAchievementService shutdownService];
	[OFUserService shutdownService];
	[OFClientApplicationService shutdownService];
	[OFProfileService shutdownService];
	[OFChatMessageService shutdownService];	
	[OFChatRoomInstanceService shutdownService];
	[OFChatRoomDefinitionService shutdownService];
	[OFApplicationDescriptionService shutdownService];
	[OFLeaderboardService shutdownService];
	[OFHighScoreService shutdownService];
	[OFPushNotificationService shutdownService];
	[OFSocialNotificationService shutdownService];
	[OFUserSettingService shutdownService];
	[OFTickerService shutdownService];
	[OFCloudStorageService shutdownService];
	[OFBootstrapService shutdownService];
	[OFOfflineService shutdownService];
	[OFInviteService shutdownService];
	
	[OFPresenceService shutdownService];
	
	[OFImageCache shutdownCache];
	
	[OpenFeint destroySharedInstance];
}

+ (void) setDashboardOrientation:(UIInterfaceOrientation)orientation
{
	OpenFeint* instance = [OpenFeint sharedInstance];
	if (instance && orientation != instance->mDashboardOrientation)
	{
		if (![OpenFeint isLargeScreen] && [OpenFeint isShowingFullScreen])
		{
			OFLog(@"You cannot change the dashboard orientation while the dashboard is open! Ignoring [OpenFeint setDashboardOrientation:].");
			return;
		}

		if ([OpenFeint isShowingFullScreen])
		{
			[[UIApplication sharedApplication] setStatusBarOrientation:orientation animated:YES];
			[instance _rotateDashboardFromOrientation:instance->mDashboardOrientation toOrientation:orientation];
		}

		instance->mDashboardOrientation = orientation;
	}
}

+ (void) launchDashboardWithDelegate:(id<OpenFeintDelegate>)delegate
{
	[self launchDashboardWithDelegate:delegate tabControllerName:nil andControllers:nil];
}

+ (void)launchDashboard
{
	[self launchDashboardWithDelegate:nil];
}

+ (bool)canReceiveCallbacksNow
{
	return YES;
}

+ (void)dismissDashboard
{
	[OpenFeint dismissRootController];
}

- (void) dealloc
{
	OFSafeRelease(mCachedLocalUser);	
	OFSafeRelease(mDisplayName);
	OFSafeRelease(mShortDisplayName);
	OFSafeRelease(mProvider);
	OFSafeRelease(mPoller);
	OFSafeRelease(mQueuedRootModal);
	OFSafeRelease(mDelegatesContainer);
	OFSafeRelease(mPresentationWindow);
	OFSafeRelease(mLocation);
	OFSafeRelease(mSessionId);
	OFSafeRelease(mSessionStartDate);
	
	if(reachabilityOb)
	{
		delete reachabilityOb;
		reachabilityOb = nil;
	}

	if(OFSettings::Instance())
	{
		OFSettings::Instance()->Shutdown();
	}
	
	if(OFReachability::Instance())
	{
		OFReachability::Instance()->Shutdown();
	}
	
	[super dealloc];
}

+(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation withSupportedOrientations:(UIInterfaceOrientation*)nullTerminatedOrientations andCount:(unsigned int)numOrientations
{
	if([OpenFeint isShowingFullScreen] && ![OpenFeint isLargeScreen])
	{
		return NO;
	}
	
	for(unsigned int i = 0; i < numOrientations; ++i)
	{
		if(interfaceOrientation == nullTerminatedOrientations[i])
		{
			return YES;
		}
	}
	
	return NO;
}

- (bool)canReceiveCallbacksNow
{
	return true;
}

+ (void)applicationWillResignActive
{
	OpenFeint* instance = [OpenFeint sharedInstance];

	if(!instance)
	{
		//no need to stop polling
	} else {
		instance->mPollingFrequencyBeforeResigningActive = [instance->mPoller getPollingFrequency];
		[instance->mPoller stopPolling];
	}
	
	[[NSUserDefaults standardUserDefaults] synchronize];
}

+ (void)applicationDidBecomeActive
{
	OpenFeint* instance = [OpenFeint sharedInstance];
	
	if(!instance)
	{
		return;
	}

	[instance->mPoller changePollingFrequency:instance->mPollingFrequencyBeforeResigningActive];
	
	//rebootstrap here since we might have changed our online/offline status when this app was asleep. synch up all the data with the server
	OFDelegate noopSuccess;
	OFDelegate noopFailure;
	[self doBootstrap:NO userId:[OpenFeint lastLoggedInUserId] onSuccess:noopSuccess onFailure:noopFailure];
}

+ (void)applicationDidEnterBackground
{
	[[OFPresenceService sharedInstance] disconnect];
}

+ (void)applicationWillEnterForeground
{
	[[OFPresenceService sharedInstance] connect];
	
	if ([OpenFeint sharedInstance] && ![OpenFeint isSuccessfullyBootstrapped] && OFReachability::Instance()->isGameServerReachable())
	{
		OFDelegate noopSuccess;
		OFDelegate noopFailure;
		[self doBootstrap:noopSuccess onFailure:noopFailure];
	}
}

+ (void)applicationDidRegisterForRemoteNotificationsWithDeviceToken:(NSData*)deviceToken
{
	OFDelegate nilDelegate;
	[OFPushNotificationService setDeviceToken:deviceToken onSuccess:nilDelegate onFailure:nilDelegate];
}

+ (void)applicationDidFailToRegisterForRemoteNotifications
{
	OFLog(@"Application failed to register for remote notifications.");
}

+ (NSString*)getChallengeIdIfExist:(NSDictionary *)params
{
	if (params)
	{
		NSString* notificationType = [params objectForKey:@"notification_type"];
		if (notificationType && [notificationType isEqualToString:@"challenge"])
		{
			NSString* challengeId = [params objectForKey:@"resource_id"];
			return challengeId;
		}
	}
	return nil;
}

+ (BOOL)applicationDidReceiveRemoteNotification:(NSDictionary *)userInfo
{	
	if (userInfo)
	{
		NSString* challengeId = [OpenFeint getChallengeIdIfExist:userInfo];
		if(challengeId != nil)
		{
			[OpenFeint setUnviewedChallengesCount:([OpenFeint unviewedChallengesCount] + 1)];
			[OFChallengeService getChallengeToUserAndShowNotification:challengeId];
			return YES;
		}

		BOOL addonResponded = [OpenFeint allowAddOnsToRespondToPushNotification:userInfo duringApplicationLaunch:NO];
		if (addonResponded)
			return YES;
	}

	return NO;
}

+ (BOOL)respondToApplicationLaunchOptions:(NSDictionary*)launchOptions
{
	NSDictionary* notificationInfo = [launchOptions objectForKey:@"UIApplicationLaunchOptionsRemoteNotificationKey"];
	if (notificationInfo)
	{
		NSString* challengeId = [OpenFeint getChallengeIdIfExist:notificationInfo];
		if(challengeId != nil)
		{
			[OFChallengeService getChallengeToUserAndShowDetailView:challengeId];
			return true;
		}

		BOOL addonResponded = [OpenFeint allowAddOnsToRespondToPushNotification:notificationInfo duringApplicationLaunch:YES];
		if (addonResponded)
			return YES;
	}
	return NO;
}

+ (bool)hasUserApprovedFeint
{
	return [OpenFeint _hasUserApprovedFeint];
}

+ (void)userDidApproveFeint:(BOOL)approved
{
	OFDelegate nilDelegate;
	[OpenFeint userDidApproveFeint:approved accountSetupCompleteDelegate:nilDelegate];
}

+ (void)userDidApproveFeint:(BOOL)approved accountSetupCompleteDelegate:(OFDelegate&)accountSetupCompleteDelegate
{
	if (approved)
	{
		[OpenFeint setUserApprovedFeint];
		[OpenFeint presentConfirmAccountModal:accountSetupCompleteDelegate useModalInDashboard:NO];
	}
	else
	{
        [OpenFeint initializeGameCenter];
		[OpenFeint setUserDeniedFeint];
		accountSetupCompleteDelegate.invoke();
	}
}

+ (void)presentUserFeintApprovalModal:(OFDelegate&)approvedDelegate deniedDelegate:(OFDelegate&)deniedDelegate
{
    // Already showing an intro flow, abort
    if ([OFIntroNavigationController activeIntroNavigationController]) return;
    
	if ([OpenFeint hasUserApprovedFeint])
	{
		approvedDelegate.invoke();
	}
	else
	{
		// developer is overriding the approval screen
		if (![OpenFeint isDashboardHubOpen] &&	// cannot override approval screen if we're prompting from within dashboard
			[[OpenFeint getDelegate] respondsToSelector:@selector(showCustomOpenFeintApprovalScreen)] &&
			[[OpenFeint getDelegate] showCustomOpenFeintApprovalScreen])
		{
			return;
		}
		
        // --- WebView Disabled for now ---
        //OFWebApprovalController *webController = nil;
        
        // Try to load the web based approval controller
        //webController = [[[OFWebApprovalController alloc] init] autorelease];            
        //[webController loadWebContent];
        //[webController setApprovedDelegate:approvedDelegate andDeniedDelegate:deniedDelegate];
        
        // Use native isntead
        OFUserFeintApprovalController *nativeController = (OFUserFeintApprovalController*)OFControllerLoader::load(@"UserFeintApproval");
        [nativeController setApprovedDelegate:approvedDelegate andDeniedDelegate:deniedDelegate];
        
        
        //OFNavigationController* navController = [[[OFNavigationController alloc] initWithRootViewController:webController] autorelease];
        OFNavigationController* navController = [[[OFNavigationController alloc] initWithRootViewController:nativeController] autorelease];
        gOFretainedIntroController = [[OFIntroNavigationController alloc] initWithNavigationController:navController];
        [navController setNavigationBarHidden:YES animated:NO];
        [navController hideBackground];
		
        //[gOFretainedIntroController setFullscreenFrame:YES];
        [gOFretainedIntroController setFullscreenFrame:NO];
        
		if ([OpenFeint isDashboardHubOpen])
		{
			[[OpenFeint getRootController] presentModalViewController:gOFretainedIntroController animated:YES];
            OFSafeRelease(gOFretainedIntroController);
		}
        
        // Normally called on webview completion
        else
        {
            [OpenFeint presentRootControllerWithModal:gOFretainedIntroController];
        }
    }
}

- (bool)_isOnline
{
	return mSuccessfullyBootstrapped && OFReachability::Instance()->isGameServerReachable();
}

+ (bool)isOnline
{
	return [[OpenFeint sharedInstance] _isOnline];
}

+ (void)loginWithUserId:(NSString*)openFeintUserId onSuccess:(const OFDelegate&)onSuccess onFailure:(const OFDelegate&)onFailure
{
	[OpenFeint doBootstrap:NO userId:openFeintUserId onSuccess:onSuccess onFailure:onFailure];
}

+ (void)gameServerReachabilityChanged:(NSNumber*) newStatus
{
	if([newStatus intValue] != NotReachable)
	{
		OFDelegate noopSuccess;
		OFDelegate noopFailure;
		[self doBootstrap:NO userId:[OpenFeint lastLoggedInUserId] onSuccess:noopSuccess onFailure:noopFailure];
	}
}

@end
