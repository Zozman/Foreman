//
//  SecondViewController.h
//  Foreman
//
//  Created by Zac Lovoy on 11/16/13.
//  Copyright (c) 2013 Zac Lovoy. All rights reserved.
//
// This class is the view controller for the settings view

#import <UIKit/UIKit.h>

@interface SecondViewController : UIViewController

// API Key Label
@property (weak, nonatomic) IBOutlet UILabel *apiKeyLabel;
// API Key Text Input Box
@property (weak, nonatomic) IBOutlet UITextField *apiKeyBox;
// Save Key Button
@property (weak, nonatomic) IBOutlet UIButton *saveKeyButton;
// Save Key Button Action
- (IBAction)saveKeyButton:(id)sender;
// Get Key Button Action
- (IBAction)getKeyButton:(id)sender;
// App By Button
@property (weak, nonatomic) IBOutlet UIButton *appByButton;
// App By Button Action
- (IBAction)appByButton:(id)sender;
// Icon By Button Action
- (IBAction)iconByButton:(id)sender;
// Prices By Button Action
- (IBAction)pricesByButton:(id)sender;

@end
