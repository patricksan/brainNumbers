//
//  Brain_NumbersAppDelegate.h
//  Brain Numbers
//
//  Created by Patrick Santana on 11/09/10.
//  Copyright 2010 Moogu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Brain_NumbersViewController;

@interface Brain_NumbersAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    Brain_NumbersViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet Brain_NumbersViewController *viewController;

@end

