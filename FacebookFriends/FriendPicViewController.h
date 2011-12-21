//
//  FriendPicViewController.h
//  FacebookFriends
//
//  Created by Aneesh on 12/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface FriendPicViewController : UIViewController<UIGestureRecognizerDelegate> {
    NSMutableArray *dataArray;
    IBOutlet UIScrollView *scrollView; 
    NSInteger tag;
}
@property(nonatomic,retain) NSMutableArray *dataArray;
@property(nonatomic,retain) IBOutlet UIScrollView *scrollView;
@property(nonatomic,assign) NSInteger tag;
@end
