//
//  SecondViewController.h
//  Slush Watch
//
//  Created by Zac Lovoy on 11/16/13.
//  Copyright (c) 2013 Zozworks. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SecondViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *apiKeyLabel;
@property (weak, nonatomic) IBOutlet UITextField *apiKeyBox;
@property (weak, nonatomic) IBOutlet UIButton *saveKeyButton;
- (IBAction)saveKeyButton:(id)sender;
- (IBAction)getKeyButton:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *appByButton;
- (IBAction)appByButton:(id)sender;
- (IBAction)iconByButton:(id)sender;

@end
