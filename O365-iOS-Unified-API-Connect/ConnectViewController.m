/*
 * Copyright (c) Microsoft. All rights reserved. Licensed under the MIT license.
 * See full license at the bottom of this file.
 */

#import "ConnectViewController.h"
#import "SendMailViewController.h"
#import <ADAuthenticationError.h>
#import "AuthenticationManager.h"

// You will set your application's clientId and redirect URI. You get
// these when you register your application in the Microsoft Application Registration Portal (https://apps.dev.microsoft.com).
NSString * const kRedirectUri = @"ENTER_REDIRECT_URI_HERE";
NSString * const kClientId    = @"ENTER_CLIENT_ID_HERE";
NSString * const kAuthority   = @"https://login.microsoftonline.com/common";
@interface ConnectViewController()

@property (nonatomic, strong) ADAuthenticationContext *adContext;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) IBOutlet UIButton *connectButton;
@end

@implementation ConnectViewController

- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self showLoadingUI:NO];
}

#pragma mark - button interaction (Connect)
- (IBAction)connectTapped:(id)sender {
    [self showLoadingUI:YES];
    [self processConnect];
}

#pragma mark - Connect
- (void) processConnect{
    AuthenticationManager *authManager = [AuthenticationManager sharedInstance];

    [authManager initWithAuthority:kAuthority
                          clientId:kClientId
                       redirectURI:kRedirectUri
                        resourceID:@"https://graph.microsoft.com"
                        completion:^(ADAuthenticationError *error) {
                            if(error){
                                [self handleADAuthenticationError:error];
                            }
                            else{
                                
                                [authManager acquireAuthTokenCompletion:^(ADAuthenticationError *acquireTokenError) {
                                    if(acquireTokenError){
                                        [self handleADAuthenticationError:acquireTokenError];
                                    }
                                    else{
                                        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                                             [self performSegueWithIdentifier:@"showSendMail" sender:nil];
                                            
                                        }];
                                       
                                    }
                                }];
                                
                                
                            }
                        }];
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"showSendMail"]){
        ;
    }
}

#pragma mark - helper
- (void) showLoadingUI:(BOOL)loading{
    if(loading){
        [self.activityIndicator startAnimating];
        [self.connectButton setTitle:@"Connecting..." forState:UIControlStateNormal];
        self.connectButton.enabled = NO;
    }
    else{
        [self.activityIndicator stopAnimating];
        [self.connectButton setTitle:@"Connect to Office 365" forState:UIControlStateNormal];
        self.connectButton.enabled = YES;
    }
}

- (void)handleADAuthenticationError:(ADAuthenticationError *)error{
    [self showLoadingUI:NO];
    
    NSLog(@"Error\nProtocol Code %@\nDescription %@", error.protocolCode, error.description);
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error"
                                                                   message:@"Please see the log for more details"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"Close"
                                              style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                                                  ;
                                              }]];
    [self presentViewController:alert animated:YES completion:^{
        ;
    }];
}


@end

// *********************************************************
//
// O365-iOS-Unified-API-Connect, https://github.com/OfficeDev/O365-iOS-Unified-API-Connect
//
// Copyright (c) Microsoft Corporation
// All rights reserved.
//
// MIT License:
// Permission is hereby granted, free of charge, to any person obtaining
// a copy of this software and associated documentation files (the
// "Software"), to deal in the Software without restriction, including
// without limitation the rights to use, copy, modify, merge, publish,
// distribute, sublicense, and/or sell copies of the Software, and to
// permit persons to whom the Software is furnished to do so, subject to
// the following conditions:
//
// The above copyright notice and this permission notice shall be
// included in all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
// EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
// MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
// NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
// LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
// OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
// WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//
// *********************************************************

