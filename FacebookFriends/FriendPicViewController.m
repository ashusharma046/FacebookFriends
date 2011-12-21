//
//  FriendPicViewController.m
//  FacebookFriends
//
//  Created by Aneesh on 12/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "FriendPicViewController.h"


@implementation FriendPicViewController
@synthesize dataArray,scrollView,tag;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
 

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil tag:(NSInteger)tag1 array:(NSMutableArray *)array
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    self.tag=tag1;
    self.dataArray=array;
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{   
    NSLog(@"dataArray count is%d",[self.dataArray count]);
    [super viewDidLoad];
    int i;
    scrollView.frame=CGRectMake(167, 60, 525, 925);
    CGPoint offset = [scrollView contentOffset];
	offset.x =525*tag-3;
  
	[scrollView setContentOffset:offset animated:YES];
     for(i=0;i<[dataArray count];i++)    
     {
         UIImage *image=[UIImage imageWithData:[dataArray objectAtIndex:i]];
         UIImageView *imgView=[[UIImageView alloc] initWithImage:image];
         imgView.tag=i;
         imgView.userInteractionEnabled=YES;
       
         imgView.frame=CGRectMake(i*525,170,520,625);
         [scrollView addSubview:imgView];
         [scrollView setContentSize:CGSizeMake(162*625, 925)];  
         scrollView.pagingEnabled = YES;
         imgView=nil;
         image=nil;
     }  
  

}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

@end
