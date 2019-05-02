/*
 * Copyright (c) Microsoft. All rights reserved. Licensed under the MIT license.
 * See full license at the bottom of this file.
 */

#import "ConnectViewController.h"
#import "SendMailViewController.h"
#import "AuthenticationManager.h"
#import <MSAL/MSAL.h>

// Set your application's clientId.
NSString *const kClientId = @"YOUR CLIENT ID";
NSString *const kAuthority = @"https://login.microsoftonline.com/common";

@interface ConnectViewController()

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) IBOutlet UIButton *connectButton;
@property (nonatomic) AuthenticationManager *authManager;

@end

@implementation ConnectViewController

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"showSendMail"])
    {
        SendMailViewController *sendMailViewController = segue.destinationViewController;
        sendMailViewController.authManager = self.authManager;
    }
}

#pragma mark - IBAction

- (IBAction)connectTapped:(id)sender
{
    [self processConnect];
}

#pragma mark - Private

- (void)processConnect
{
    __auto_type scopes = @[@"https://graph.microsoft.com/Mail.ReadWrite",
                           @"https://graph.microsoft.com/Mail.Send",
                           @"https://graph.microsoft.com/Files.ReadWrite",
                           @"https://graph.microsoft.com/User.ReadBasic.All"];

    [self showLoadingUI:YES];
    [self.authManager acquireAuthTokenWithScopes:scopes completion:^(BOOL success, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self showLoadingUI:NO];
            
            if (error) {
                [self showError:error];
                return;
            }
            
            NSLog(@"%@", self.authManager.account.username);
            [self performSegueWithIdentifier:@"showSendMail" sender:nil];
        });
     }];
}

- (AuthenticationManager *)authManager
{
    if (!_authManager) {
        NSURL *authorityUrl = [[NSURL alloc] initWithString:kAuthority];
        assert(authorityUrl);
        __auto_type authority = [[MSALAADAuthority alloc] initWithURL:authorityUrl error:nil];
        assert(authority);
        
        NSAssert(![kClientId isEqualToString:@"YOUR CLIENT ID"], @"ConnectViewController: Provide your client id first!");
        
        NSError *error;
        _authManager = [[AuthenticationManager alloc] initWithAuthority:authority clientId:kClientId error:&error];
        
        if (error) [self showError:error];
    }
    
    return _authManager;
}

- (void)showLoadingUI:(BOOL)loading
{
    if (loading) {
        [self.activityIndicator startAnimating];
        [self.connectButton setTitle:@"Connecting..." forState:UIControlStateNormal];
        self.connectButton.enabled = NO;
    } else {
        [self.activityIndicator stopAnimating];
        [self.connectButton setTitle:@"Connect to Office 365" forState:UIControlStateNormal];
        self.connectButton.enabled = YES;
    }
}

- (void)showError:(NSError *)error
{
    NSLog(@"Error: %@", error);
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error"
                                                                   message:@"Please see the log for more details"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"Close"
                                              style:UIAlertActionStyleDefault handler:nil]];
    
    [self presentViewController:alert animated:YES completion:nil];
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

