//
//  FacebookFriendsAppDelegate.h
//  FacebookFriends
//
//  Created by Aneesh on 11/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FacebookFriendsViewController;

@interface FacebookFriendsAppDelegate : NSObject <UIApplicationDelegate> {

}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet FacebookFriendsViewController *viewController;

@end
