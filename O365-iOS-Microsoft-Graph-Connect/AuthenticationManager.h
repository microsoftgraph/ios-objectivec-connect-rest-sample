/*
 * Copyright (c) Microsoft. All rights reserved. Licensed under the MIT license.
 * See full license at the bottom of this file.
 */

#import <Foundation/Foundation.h>
#import <MSAL/MSAL.h>

@interface AuthenticationManager : NSObject

+ (AuthenticationManager*)sharedInstance;

- (void)initWithAuthority:(NSString*)authority
               completion:(void (^)(NSError *error))completion;

@property (nonatomic, strong) NSString *accessToken;
@property (nonatomic, strong) NSString *userID;
@property (nonatomic, strong) MSALPublicClientApplication *msalClient;
@property (nonatomic, weak) NSString *clientId;
@property (nonatomic, weak) NSString *authorty;
@property (nonatomic, strong) MSALUser *user;


- (void)acquireAuthTokenWithScopes:(NSArray<NSString *> *)scopes
                        completion:(void(^)(MSALErrorCode error))completion;

-(void) acquireAuthTokenCompletion:(void (^)(MSALErrorCode *error))completion;

// Clears the ADAL token cache and the cookie cache.
- (void) clearCredentials;

- (NSString *) getRedirectUrlFromMSALArray:(NSArray *) array;

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


