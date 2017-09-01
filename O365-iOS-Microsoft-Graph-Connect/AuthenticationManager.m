/*
 * Copyright (c) Microsoft. All rights reserved. Licensed under the MIT license.
 * See full license at the bottom of this file.
 */

#import <MSAL/MSAL.h>
#import "AuthenticationManager.h"


@implementation AuthenticationManager


#pragma mark - singleton
+ (AuthenticationManager *)sharedInstance
{
    static AuthenticationManager *sharedInstance;
    static dispatch_once_t onceToken;
    
    // Initialize the AuthenticationManager only once.
    dispatch_once(&onceToken, ^{
        sharedInstance = [[AuthenticationManager alloc] init];
    });
    
    return sharedInstance;
}

#pragma mark - init
- (void)initWithAuthority:(NSString*)authority_
               completion:(void (^)(NSError* error))completion
{
    
    //Get the MSAL client Id for this Azure app registration. We store it in the main bundle
    NSDictionary *dictionary = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Info" ofType:@"plist"]];
    NSArray *array = [dictionary objectForKey:@"CFBundleURLTypes"];
    NSString *redirectUrl = [self getRedirectUrlFromMSALArray:(array)];
    
    NSRange range = [redirectUrl rangeOfString:@"msal"];
    NSString *kClientId = [[redirectUrl substringFromIndex:NSMaxRange(range)] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSLog(@"client id = %@", kClientId);

    self.clientId = kClientId;
    self.authorty = authority_;
    
    NSError *error_ = nil;
    @try {
        self.msalClient = [[MSALPublicClientApplication alloc] initWithClientId:kClientId error:&error_];
        if (error_) {
            completion(error_);
        } else {
            completion(nil);}
        
    }
    @catch(NSException *exception) {
        NSMutableDictionary * info = [NSMutableDictionary dictionary];
        [info setValue:exception.name forKey:@"ExceptionName"];
        [info setValue:exception.reason forKey:@"ExceptionReason"];
        [info setValue:exception.callStackReturnAddresses forKey:@"ExceptionCallStackReturnAddresses"];
        [info setValue:exception.callStackSymbols forKey:@"ExceptionCallStackSymbols"];
        [info setValue:exception.userInfo forKey:@"ExceptionUserInfo"];
        
        NSError *error = [[NSError alloc] initWithDomain:MSALErrorDomain code:MSALErrorInternal userInfo:info];
        //use error
        completion(error);
    }
    
}


#pragma mark - acquire token

- (void)acquireAuthTokenWithScopes:(NSArray<NSString *> *)scopes
                        completion:(void(^)(MSALErrorCode error))completion {

    NSError  __autoreleasing  *error_ = nil;
    
    NSArray<MSALUser *> *users = [self.msalClient users:(&error_)];
    
    // We check to see if we have a current logged in user. If we don't, then we need to sign someone in.
    // We throw an interactionRequired so that we trigger the interactive signin.

    if (self.msalClient == nil) {
        completion(MSALErrorInternal);
 
    }
    
    if (users == nil | [users count] == 0) {
        @try {
            [self.msalClient acquireTokenForScopes:scopes completionBlock:^(MSALResult *result, NSError *error) {
                if (error) {
                    completion(error.code);
                } else {
                    self.clientId = self.msalClient.clientId;
                    self.accessToken = result.accessToken;

                    self.user = result.user;
                    self.userID = result.user.displayableId;
                    completion(0);
                    
                }
            }];
        }
        @catch (NSException *exception) {
            completion(MSALErrorInternal);
        }

    } else {
        @try {
            self.user =  [users objectAtIndex:0];
            [self.msalClient acquireTokenSilentForScopes:scopes user:self.user completionBlock:^(MSALResult *result, NSError *error) {
                if (error) {
                    completion(MSALErrorInteractionRequired);
                } else {
                    self.clientId = self.msalClient.clientId;
                    self.accessToken = result.accessToken;
                    self.userID = result.user.displayableId;

                    completion(0);
                    
                }
            }];
        }
        @catch (NSException *exception) {
            completion(MSALErrorInternal);
        }
        
    }

}

-(void) acquireAuthTokenCompletion:(void (^)(MSALErrorCode *error))completion{
}

#pragma mark - Get client id from bundle

- (NSString *) getRedirectUrlFromMSALArray:(NSArray *) array {
    NSDictionary *arrayElement = [array objectAtIndex: 0];
    NSArray *redirectArray = [arrayElement valueForKeyPath:@"CFBundleURLSchemes"];
    NSString *substring = [redirectArray objectAtIndex:0];
    return substring;
}


#pragma mark - clear credentials
 //Clears the ADAL token cache and the cookie cache.
- (void)clearCredentials {

    NSError *error_ = nil;
    [self.msalClient removeUser:self.user error:&error_];
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
