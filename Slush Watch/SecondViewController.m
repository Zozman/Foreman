//
//  SecondViewController.m
//  Slush Watch
//
//  Created by Zac Lovoy on 11/16/13.
//  Copyright (c) 2013 Zozworks. All rights reserved.
//

#import "Utilities.h"
#import "Alerts.h"
#import "SecondViewController.h"

@interface SecondViewController () <UITextFieldDelegate>

@end

@implementation SecondViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [_apiKeyBox setDelegate:self];
    [_apiKeyBox setReturnKeyType:UIReturnKeyDone];
    [_apiKeyBox addTarget:self
                        action:@selector(textFieldFinished:)
              forControlEvents:UIControlEventEditingDidEndOnExit];

    _apiKeyBox.text = [Utilities retrieveKey];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)saveKeyButton:(id)sender {
    [Utilities saveKey:_apiKeyBox.text];
    [Alerts saveKey];
}

- (IBAction)getKeyButton:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://mining.bitcoin.cz/accounts/token-manage/"]];
}

- (IBAction)textFieldFinished:(id)sender
{
    [sender resignFirstResponder];
}
- (IBAction)appByButton:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://mrlovoy.com"]];
}

- (IBAction)iconByButton:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://iconbeast.com"]];
}
@end
