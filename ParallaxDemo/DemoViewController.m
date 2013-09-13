//
//  DemoViewController.m
//  ParallaxDemo
//
//  Created by demon on 9/13/13.
//  Copyright (c) 2013 demonNico. All rights reserved.
//

#import "DemoViewController.h"
#import "UIScrollView+ParallaxEffect.h"
@interface DemoViewController ()
@property (nonatomic,strong)UILabel * labelTitle;
@property (nonatomic,strong)UILabel * labelPercent;
@property (nonatomic,copy) dragBlock dragblock;
@property (nonatomic,copy) dragBlock finishblock;
@end

#define DRAG_DISTANCE_LIMIT 100.0
@implementation DemoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)showScollViewParallax
{
    UIScrollView * scrollView = [[UIScrollView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:scrollView];
    
    scrollView.contentSize = CGSizeMake(320, 600);
    [scrollView addBackgroundView:[self getParallaxView]
                 withWindowHeight:100
                dragDistanceLimit:DRAG_DISTANCE_LIMIT
                   parallaxFactor:0.01];
    
    [scrollView addSubview:self.labelPercent];
    [scrollView addSubview:self.labelTitle];
    scrollView.draggingBlock = self.dragblock;
    scrollView.finishDragBlock= self.finishblock;
}
-(void)showTableViewParallax
{
    UITableView* tableView = [[UITableView alloc] initWithFrame:self.view.frame
                                                           style:UITableViewStylePlain];
    [self.view addSubview:tableView];
    
    [tableView addBackgroundView:[self getParallaxView]
                withWindowHeight:100
               dragDistanceLimit:0
                  parallaxFactor:0.25];
    [tableView addSubview:self.labelPercent];
    [tableView addSubview:self.labelTitle];
    tableView.draggingBlock = self.dragblock;
    tableView.finishDragBlock= self.finishblock;
}

-(UILabel*)labelPercent
{
    if(!_labelPercent){
        _labelPercent= [[UILabel alloc] initWithFrame:CGRectMake(100, 80, 320, 20)];
        _labelPercent.backgroundColor = [UIColor clearColor];
        _labelPercent.textColor = [UIColor redColor];
        _labelPercent.text = @"what's this? i donno~";
    }
    return _labelPercent;
}

-(UILabel*)labelTitle
{
    if(!_labelTitle){
        _labelTitle= [[UILabel alloc] initWithFrame:CGRectMake(0, 80, 320, 20)];
        _labelTitle.backgroundColor = [UIColor clearColor];
        _labelTitle.textColor = [UIColor blueColor];
        _labelTitle.text = @"Hello, world";
    }
    return _labelTitle;
}

-(dragBlock)dragblock
{
    if(!_dragblock)
    {
        _dragblock = ^(CGFloat offset)
        {
            NSLog(@"percent:%f",offset/DRAG_DISTANCE_LIMIT);
        };
    }
    return _dragblock;
}

-(dragBlock)finishblock
{
    if(!_finishblock)
    {
        _finishblock= ^(CGFloat offset)
        {
            //maybe you should check the offset,
            //then do some refresh work if it's reach your expect. 
            NSLog(@"maybe we'd refresh data now");
        };
    }
        
    return _finishblock;
}

-(UIView*)getParallaxView
{
    UIImage * image = [UIImage imageNamed:@"bg"];
    UIImageView * imageView =
    [[UIImageView alloc] initWithImage:image];
    return imageView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
