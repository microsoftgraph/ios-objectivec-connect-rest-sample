/*
 * Copyright (c) Microsoft. All rights reserved. Licensed under the MIT license.
 * See full license at the bottom of this file.
 */

#import "SendMailViewController.h"
#import "AuthenticationManager.h"

@interface SendMailViewController () <NSURLConnectionDelegate>

@property (weak, nonatomic) IBOutlet UILabel *headerLabel;
@property (weak, nonatomic) IBOutlet UITextView *mainContentTextView;
@property (weak, nonatomic) IBOutlet UITextView *statusTextView;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *disconnectBarButtonItem;
@property (weak, nonatomic) IBOutlet UIButton *sendMailButton;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

- (IBAction)sendMailTapped:(id)sender;
- (IBAction)disconnectTapped:(id)sender;

@end

@implementation SendMailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationItem setHidesBackButton:YES];
    
    // set user information
    AuthenticationManager *authManager = [AuthenticationManager sharedInstance];
    self.emailTextField.text = [authManager userID];
    
    NSArray *parts = [[[AuthenticationManager sharedInstance] userID] componentsSeparatedByString: @"@"];
    self.headerLabel.text = [NSString stringWithFormat:@"Hi %@!", parts[0]];
    
    self.statusTextView.text = @"";
}

#pragma mark - Button interactions
- (IBAction)sendMailTapped:(id)sender {
    [self showSendingUI:YES];
    [self sendMailREST];
}

- (IBAction)disconnectTapped:(id)sender {
    [[AuthenticationManager sharedInstance] clearCredentials];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Send mail
- (void)sendMailREST {
    [self.emailTextField resignFirstResponder];
    
    AuthenticationManager *authManager = [AuthenticationManager sharedInstance];
    NSData *postData = [self mailContent];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:@"https://graph.microsoft.com/v1.0/me/microsoft.graph.sendmail"]];

    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/json, text/plain, */*" forHTTPHeaderField:@"Accept"];
    
    NSString *authorization = [NSString stringWithFormat:@"Bearer %@", authManager.accessToken];
    [request setValue:authorization forHTTPHeaderField:@"Authorization"];
    [request setHTTPBody:postData];

    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    if(conn) {
        NSLog(@"Connection Successful");
    } else {
        NSLog(@"Connection could not be made");
    }
    
    [conn start];
}

- (NSData *)mailContent {
    NSString *htmlContentPath = [[NSBundle mainBundle] pathForResource:@"EmailBody" ofType:@"html"];
    NSString *htmlContentString = [[NSString stringWithContentsOfFile:htmlContentPath encoding:NSUTF8StringEncoding error:nil] stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
    
    NSString *jsonContentPath = [[NSBundle mainBundle] pathForResource:@"EmailPostContent" ofType:@"json"];
    NSMutableString *jsonContentString = [NSMutableString stringWithContentsOfFile:jsonContentPath encoding:NSUTF8StringEncoding error:nil];

    [jsonContentString replaceOccurrencesOfString:@"<EMAIL>"
                                       withString:self.emailTextField.text
                                          options:0 range:(NSRange){0, [jsonContentString length]}];
    

    [jsonContentString replaceOccurrencesOfString:@"<CONTENTTYPE>"
                                       withString:@"HTML"
                                          options:0 range:(NSRange){0, [jsonContentString length]}];
    
    [jsonContentString replaceOccurrencesOfString:@"<CONTENT>"
                                       withString:htmlContentString
                                          options:0 range:(NSRange){0, [jsonContentString length]}];

    return [jsonContentString dataUsingEncoding:NSUTF8StringEncoding];
}

#pragma mark - NSURLConnection delegates
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    [self showSendingUI:NO];
    
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;

    if([httpResponse statusCode] == 202){
            self.statusTextView.text = @"Check your inbox, you have a new message. :)";
    }
    else{
        NSLog(@"Response - %@", response);
        self.statusTextView.text = @"The email could not be sent. Check the log for errors.";
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    NSString *responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"Received Data - %@", responseString);
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"Connection Failure - %@", error.localizedDescription);
}

#pragma mark - Helpers
- (void)showSendingUI:(BOOL)sending { 
    if(sending){
        [self.activityIndicator startAnimating];
        [self.sendMailButton setTitle:@"Sending..." forState:UIControlStateNormal];
        self.sendMailButton.enabled = NO;
        self.statusTextView.text = @"";
    }
    else{
        [self.activityIndicator stopAnimating];
        [self.sendMailButton setTitle:@"Send" forState:UIControlStateNormal];
        self.sendMailButton.enabled = YES;
    }
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

