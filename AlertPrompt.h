//
//  AlertPrompt.h
//  Brain Numbers
//
//  Created by Patrick Santana on 22/09/10.
//  Copyright 2010 Moogu. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface AlertPrompt : UIAlertView {
	/** name of the gamer. It will be read via property */
	UITextField *textField;
}

@property (nonatomic, retain) UITextField *textField;
@property (readonly) NSString *enteredText;
- (id)initWithTitle:(NSString *)title message:(NSString *)message delegate:(id)delegate cancelButtonTitle:(NSString *)cancelButtonTitle okButtonTitle:(NSString *)okButtonTitle;

@end
