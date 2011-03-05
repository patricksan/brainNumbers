//
//  AlertPrompt.m
//  Brain Numbers
//
//  Created by Patrick Santana on 22/09/10.
//  Copyright 2010 Moogu. All rights reserved.
//

#import "AlertPrompt.h"


@implementation AlertPrompt

@synthesize textField;
@synthesize enteredText;

- (id)initWithTitle:(NSString *)title message:(NSString *)message delegate:(id)delegate cancelButtonTitle:(NSString *)cancelButtonTitle okButtonTitle:(NSString *)okayButtonTitle{
	
    if (self = [super initWithTitle:title message:message delegate:delegate cancelButtonTitle:cancelButtonTitle otherButtonTitles:okayButtonTitle, nil])
    {
		NSString *reqSysVer = @"4.0";               
		NSString *currSysVer = [[UIDevice currentDevice] systemVersion];                
		if ([currSysVer compare:reqSysVer options:NSNumericSearch] != NSOrderedAscending ){ 
			UITextField *theTextField = [[UITextField alloc] initWithFrame:CGRectMake(12.0, 35.0, 260.0, 25.0)]; 
			[theTextField setBackgroundColor:[UIColor whiteColor]]; 
			[self addSubview:theTextField];
			self.textField = theTextField;
			[theTextField release];
		}else{
			
			UITextField *theTextField = [[UITextField alloc] initWithFrame:CGRectMake(12.0, 25.0, 260.0, 25.0)]; 
			[theTextField setBackgroundColor:[UIColor whiteColor]]; 
			[self addSubview:theTextField];
			self.textField = theTextField;
			[theTextField release];
				
		}
    }
    return self;
}

- (void)show{
    [textField becomeFirstResponder];
    [super show];
}

- (NSString *)enteredText{
    return textField.text;
}

- (void)dealloc{
    [textField release];
    [super dealloc];
}
@end
