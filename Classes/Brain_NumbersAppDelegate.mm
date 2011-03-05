//
//  Brain_NumbersAppDelegate.m
//  Brain Numbers
//
//  Created by Patrick Santana on 11/09/10.
//  Copyright 2010 Moogu. All rights reserved.
//

#import "Brain_NumbersAppDelegate.h"
#import "Brain_NumbersViewController.h"

#import "OpenFeint.h"

@implementation Brain_NumbersAppDelegate

@synthesize window;
@synthesize viewController;


#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    
	// verify if file of Function exists, if not create
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	NSString *path = [documentsDirectory stringByAppendingPathComponent:@"setup.plist"];
	
	BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:path];
	
	if (!fileExists){
		NSLog(@"File with Setup configuration does not exist, create it");
		NSNumber *functionToSave = [NSNumber numberWithInt:5];
		NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:functionToSave,@"function",nil];	
		[dict writeToFile:path atomically:YES];
	}
	
    // Add the view controller's view to the window and display.
    [window addSubview:viewController.view];
    [window makeKeyAndVisible];
	
	[OpenFeint initializeWithProductKey:@"6S4lqMM2l9qNDzvPX2ymaw" andSecret:@"Rg5r2ELf1kbyKIycywEjDdodLacH7AVZi15nRmbpOos" andDisplayName:@"OpenFeint" andSettings:nil andDelegates:nil];

    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
	[OpenFeint applicationWillResignActive];

}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, called instead of applicationWillTerminate: when the user quits.
     */
		[OpenFeint applicationDidEnterBackground];
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    /*
     Called as part of  transition from the background to the inactive state: here you can undo many of the changes made on entering the background.
     */
[OpenFeint applicationWillEnterForeground];
}



- (void)applicationDidBecomeActive:(UIApplication *)application {
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
	[OpenFeint applicationDidBecomeActive];
}


- (void)applicationWillTerminate:(UIApplication *)application {
    /*
     Called when the application is about to terminate.
     See also applicationDidEnterBackground:.
     */
}


#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}


- (void)dealloc {
	[OpenFeint shutdown];
    [viewController release];
    [window release];
    [super dealloc];
}


@end
