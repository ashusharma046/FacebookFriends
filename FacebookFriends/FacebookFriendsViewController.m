//
//  FacebookFriendsViewController.m
//  FacebookFriends
//
//  Created by Aneesh on 11/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "FacebookFriendsViewController.h"
#import "JSON.h"

#import "AnimationViewController.h"
@implementation FacebookFriendsViewController
@synthesize loginStatusLabel = _loginStatusLabel;
@synthesize loginButton = _loginButton;
@synthesize loginDialog = _loginDialog;
@synthesize loginDialogView = _loginDialogView;

#pragma mark Main

- (void)dealloc {
    self.loginStatusLabel = nil;
    self.loginButton = nil;
    self.loginDialog = nil;
    self.loginDialogView = nil;
    [super dealloc];
}

- (void)refresh {
    if (_loginState == LoginStateStartup || _loginState == LoginStateLoggedOut) {
        _loginStatusLabel.text = @"Not connected to Facebook";
        [_loginButton setTitle:@"Login" forState:UIControlStateNormal];
        _loginButton.hidden = NO;
    } else if (_loginState == LoginStateLoggingIn) {
        _loginStatusLabel.text = @"Connecting to Facebook...";
        _loginButton.hidden = YES;
    } else if (_loginState == LoginStateLoggedIn) {
        _loginStatusLabel.text = @"Connected to Facebook";
        [_loginButton setTitle:@"Logout" forState:UIControlStateNormal];
        _loginButton.hidden = NO;
    }   
}

- (void)viewWillAppear:(BOOL)animated {
    [self refresh];
}

#pragma mark Login Button

- (IBAction)loginButtonTapped:(id)sender {
    NSLog(@"login button tapped");
    NSString *appId = @"8fa673a06891cac667e55d690e27ecbb";
    NSString *permissions = @"publish_stream";
    
    if (_loginDialog == nil) {
        self.loginDialog = [[[FBFunLoginDialog alloc] initWithAppId:appId requestedPermissions:permissions delegate:self] autorelease];
        self.loginDialogView = _loginDialog.view;
    }
    
    if (_loginState == LoginStateStartup || _loginState == LoginStateLoggedOut) {
        _loginState = LoginStateLoggingIn;
        [_loginDialog login];
    } else if (_loginState == LoginStateLoggedIn) {
        _loginState = LoginStateLoggedOut;        
        [_loginDialog logout];
    }
    
    [self refresh];
    
}

#pragma mark FBFunLoginDialogDelegate

- (void)accessTokenFound:(NSString *)apiKey {

    _loginState = LoginStateLoggedIn;
    if(LoginStateLoggedIn){
        NSLog(@"logged in succes");
        [self loginButtonTapped:self];
    }
    
    else{
    
        NSLog(@"ashu  sharma ---------------------------------------");
    }
    [self refresh];
    NSString *str=[NSString stringWithFormat:@"https://graph.facebook.com/me/friends?access_token=%@",apiKey];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:str]];
    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSString *get = [[NSString alloc] initWithData:response encoding:NSUTF8StringEncoding];
    
    
	NSDictionary *jsonDict = [get JSONValue];
   // NSLog(@"json dict %@",jsonDict);
    NSArray *dataDictArray = [jsonDict valueForKey:@"data"];
    AnimationViewController *animationViewController=[[AnimationViewController alloc] initWithNibName:@"AnimationViewController" bundle:nil];
    
    animationViewController.dataDictArray=dataDictArray;
    [self dismissViewControllerAnimated:YES completion:^(void) {
        
        
        
        [self presentModalViewController:animationViewController animated:YES];
    } 
     ]; 
 
    }

- (void)displayRequired {
    [self presentModalViewController:_loginDialog animated:YES];
}

- (void)closeTapped {
    [self dismissModalViewControllerAnimated:YES];
    _loginState = LoginStateLoggedOut;        
    [_loginDialog logout];
    [self refresh];
}

@end
