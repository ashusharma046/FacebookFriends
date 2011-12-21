//
//  AnimationViewController.h
//  Animation
//
//  Created by Aneesh on 14/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FriendPicViewController.h"

@interface AnimationViewController : UIViewController<UIGestureRecognizerDelegate,UIScrollViewDelegate>  {
    NSArray *dataDictArray;
    IBOutlet UIScrollView *scrollView;
    IBOutlet UIButton *btn;
    NSMutableArray *dataArray;
    FriendPicViewController *friendPicViewController;
    IBOutlet UIPageControl *pgcontrol;
    IBOutlet UIActivityIndicatorView *avView;
}
@property(nonatomic,retain) NSArray *dataDictArray;
@property(nonatomic,retain) NSMutableArray *dataArray;
@property(nonatomic,retain) IBOutlet UIScrollView *scrollView;
@property(nonatomic,retain) IBOutlet UIButton *btn;
@property(nonatomic,retain) IBOutlet UIPageControl *pgcontrol;
@property(nonatomic,retain) IBOutlet UIActivityIndicatorView *avView;
-(IBAction)handleSingleTap:(UITapGestureRecognizer *)recognizer;
-(void)layoutScrollViews;
-(void)relayoutScrollViews;
- (IBAction)removeScroll : (id) sender;
@end
