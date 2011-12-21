//
//  AnimationViewController.m
//  Animation
//
//  Created by Aneesh on 14/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AnimationViewController.h"
#import "FriendPicViewController.h"
@implementation AnimationViewController
@synthesize dataDictArray,scrollView,dataArray,btn,pgcontrol,avView;
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
-(void)layoutScrollViews{
    NSAutoreleasePool *pool1 = [[NSAutoreleasePool alloc] init];
    int i;
    [btn setHidden:YES];
    pgcontrol.hidden=NO;
    dataArray=[[NSMutableArray alloc] init];
    
    for(i=0;i<[dataDictArray count];i++)
    {   
        if(i==0){
            [avView startAnimating];
        }
        
        NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
        NSDictionary *friendDict=[dataDictArray objectAtIndex:i];  
        NSString *str=[NSString stringWithFormat:@"http://graph.facebook.com/%@/picture",[friendDict valueForKey:@"id"]];
        NSURL *url = [NSURL URLWithString:str];
        NSData *data = [NSData dataWithContentsOfURL:url];
        UIImage *image=[UIImage imageWithData:data]; 
        [dataArray addObject:data];
        
        UIImageView *imgView=[[UIImageView alloc] initWithImage:image];
        imgView.tag=i;
        imgView.tag=i;
        imgView.userInteractionEnabled=NO;
        UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
        tap.numberOfTapsRequired = 1;
        tap.delegate=self;
        [imgView addGestureRecognizer:tap];
        int rownum;
        int coloumnnum;
        int j=i+1;
        if(j%7==0){
            coloumnnum=j/7;
            rownum=7;
        }
        else{
            coloumnnum=j/7+1;
            rownum=j%7;    
        } 
        int k=coloumnnum-1;
        if(k%5==0 || coloumnnum==1){
           imgView.frame=CGRectMake((coloumnnum-1)*130,(rownum-1)*120+20,100,90);
             //imgView.frame=CGRectMake((coloumnnum-1)*113.20,(rownum-1)*120,113.2,90);
        }
        else{
           imgView.frame=CGRectMake((coloumnnum-1)*130,(rownum-1)*120+20,100,90);
            //imgView.frame=CGRectMake((coloumnnum-1)*113.20+20,(rownum-1)*120,113.2,90);
            
        }

       
        [scrollView addSubview:imgView];
        float n=(float)[dataDictArray count]/7;
        NSLog(@"float is %f",n);
        [scrollView setContentSize:CGSizeMake(([dataDictArray count]/7+1)*130+130,5*90+100 )];
        //
        
        
        scrollView.pagingEnabled = YES;
        [pool drain];  
    } 
    NSLog(@"count is %dhorizontal %f  horizontal y %f-",[dataDictArray count],scrollView.contentSize.width,scrollView.contentSize.height);
    [avView stopAnimating];
    UIButton *button=[[UIButton alloc] init];
    int numofpages=((162/7)*130+60)/650;
    [pgcontrol setNumberOfPages:numofpages];
    button.frame=CGRectMake(-50, -50, 45, 45);
    [button setImage:[UIImage imageNamed:@"images.jpeg"] forState:UIControlStateNormal];
    
    [button addTarget:self action:@selector(removeScroll) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:button];
    
    [pool1 release];  
    for(i=0;i<[dataDictArray count];i++){
        UIImageView *view=[[scrollView subviews] objectAtIndex:i];  
        view.userInteractionEnabled=YES;
    }
    scrollView.userInteractionEnabled=YES;
   
}
-(IBAction)handleSingleTap:(UITapGestureRecognizer *)recognizer {
    [btn setHidden:NO];
   // int tag = recognizer.view.tag;
    
   
    UIView *flipView=recognizer.view;
    UIView *newView= [[UIView alloc] init];
    newView.frame=CGRectMake(150, 170, 425, 425);
    CGRect rect =flipView.frame;
    int currentpage=rect.origin.x/650;
    friendPicViewController = [[FriendPicViewController alloc] initWithNibName:@"FriendPicViewController" bundle:nil tag:recognizer.view.tag array :dataArray];
    friendPicViewController.view.backgroundColor=[UIColor clearColor];
    
    //NSLog(@"data array count is %d",[dataArray count]);
    friendPicViewController.dataArray=dataArray;
    friendPicViewController.tag=recognizer.view.tag;
    [friendPicViewController reloadInputViews];
    //NSLog(@"friends pic view contoller %d",friendPicViewController.tag);
    friendPicViewController.tag=[dataArray count];
    CGRect rect1=friendPicViewController.view.frame;
    rect1.size.width=924;
    
    self.view.userInteractionEnabled=YES;
    self.view.alpha=0.5;
    [UIView transitionWithView:flipView
                      duration:1
                       options:UIViewAnimationOptionTransitionFlipFromLeft | UIViewAnimationTransitionFlipFromRight 
                    animations:^{ 
                        flipView.frame=CGRectMake(110+currentpage*650, 170, 520, 625);
                        
                    }
                    completion:^(BOOL finished) {
                        
                        
                        
                        [self.view.superview addSubview:friendPicViewController.view];
                        btn.alpha=1;
                        pgcontrol.hidden=YES;
                        scrollView.userInteractionEnabled=NO;
                    } 
     ]; 
    
    
    
    
    
    
}

- (IBAction)removeScroll : (id) sender{
     NSLog(@"remove scroll");
    [friendPicViewController.view removeFromSuperview];
    if(scrollView!=nil)
    {
        while ([scrollView.subviews count] > 0) {
            [[[scrollView subviews] objectAtIndex:0] removeFromSuperview];
        }
    }
    self.view.alpha=1;
    [self relayoutScrollViews];
    scrollView.userInteractionEnabled=YES;
} 
-(void)relayoutScrollViews{
   
    int i;
    [btn setHidden:YES];
    pgcontrol.hidden=NO;
    
    
    for(i=0;i<[dataDictArray count];i++)
    {   
        
        UIImage *image=[UIImage imageWithData:[dataArray objectAtIndex:i]]; 
       
        
        UIImageView *imgView=[[UIImageView alloc] initWithImage:image];
        imgView.tag=i;
        imgView.tag=i;
        imgView.userInteractionEnabled=YES;
        UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
        tap.numberOfTapsRequired = 1;
        tap.delegate=self;
        [imgView addGestureRecognizer:tap];
        int rownum;
        int coloumnnum;
        int j=i+1;
        if(j%7==0){
            coloumnnum=j/7;
            rownum=7;
        }
        else{
            coloumnnum=j/7+1;
            rownum=j%7;    
        } 
        int k=coloumnnum-1;
        if(k%5==0 || coloumnnum==1){
            imgView.frame=CGRectMake((coloumnnum-1)*130,(rownum-1)*120,100,90);
            //imgView.frame=CGRectMake((coloumnnum-1)*113.20,(rownum-1)*120,113.2,90);
        }
        else{
            imgView.frame=CGRectMake((coloumnnum-1)*130,(rownum-1)*120,100,90);
            //imgView.frame=CGRectMake((coloumnnum-1)*113.20+20,(rownum-1)*120,113.2,90);
            
        }
        
        [scrollView addSubview:imgView];
        [scrollView setContentSize:CGSizeMake(([dataDictArray count]/7+1)*130+130,5*90+100 )]; //
        scrollView.pagingEnabled = YES;
        
    }   
    UIButton *button=[[UIButton alloc] init];
    
    button.frame=CGRectMake(-50, -50, 45, 45);
    [button setImage:[UIImage imageNamed:@"images.jpeg"] forState:UIControlStateNormal];
    
    [button addTarget:self action:@selector(removeScroll) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:button];
    

     
    
}

- (void)pageTurning:(UIPageControl *)pageController{
  }

-(void)scrollViewDidScroll:(UIScrollView *)sender {
	CGPoint offset = [scrollView contentOffset];
    
    int currentPage=offset.x/650;
   
    [pgcontrol setCurrentPage:currentPage];
    [pgcontrol updateCurrentPageDisplay];
    // NSLog(@"current offset is %f and page is %d",offset.x,currentPage);
    
	}


#pragma mark - View lifecycle


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{ 
    [super viewDidLoad];
    [pgcontrol setNumberOfPages:5];
    [NSThread detachNewThreadSelector:@selector(layoutScrollViews) toTarget:self withObject:nil];
    
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
