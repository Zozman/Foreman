//
//  SecondViewController.m
//  Foreman
//
//  Created by Zac Lovoy on 11/16/13.
//  Copyright (c) 2013 Zac Lovoy. All rights reserved.
//
//  This class is the view controller for the settings view

#import "Utilities.h"
#import "Alerts.h"
#import "SecondViewController.h"

@interface SecondViewController () <UITextFieldDelegate>

@end

@implementation SecondViewController

// Function that runs when the view loads
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Set the API Key Box so that when you hit "Done", the keyboard disappears (next 3 lines)
    [_apiKeyBox setDelegate:self];
    [_apiKeyBox setReturnKeyType:UIReturnKeyDone];
    [_apiKeyBox addTarget:self
                        action:@selector(textFieldFinished:)
              forControlEvents:UIControlEventEditingDidEndOnExit];
    // Fills the API Key Box witht the saved API Key
    _apiKeyBox.text = [Utilities retrieveKey];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// Function that runs when the "Save" button is pressed
- (IBAction)saveKeyButton:(id)sender {
    // Save the key entered in the API Key Box
    [Utilities saveKey:_apiKeyBox.text];
    // Let the user know the key has been saved
    [Alerts saveKey];
}

// Function that runs when the "Get Key" button is pressed
- (IBAction)getKeyButton:(id)sender {
    // Open the page to get your token in your default web browser
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://mining.bitcoin.cz/accounts/token-manage/"]];
}

// Function used to make the keyboard disappear when the "Done" button is hit on the keyboard
- (IBAction)textFieldFinished:(id)sender
{
    [sender resignFirstResponder];
}

// Function that runs when the "App By" button is pressed
- (IBAction)appByButton:(id)sender {
    // Open the page in your default web browser
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://mrlovoy.com"]];
}

// Function that runs when the "Tab Icons By" button is pressed
- (IBAction)iconByButton:(id)sender {
    // Open the page in your default web browser
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://iconbeast.com"]];
}

// Function that runs when the "Bitcoin Prices By" button is pressed
- (IBAction)pricesByButton:(id)sender {
    // Open the page in your default web browser
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://bitstamp.net"]];
}
@end
