//
//  ViewController.m
//  XYImageScrollView
//
//  Created by tvie on 13-11-22.
//  Copyright (c) 2013年 YXY. All rights reserved.
//

#import "ViewController.h"
#import "XYImageScrollView.h"

@interface ViewController ()
@property (nonatomic, strong) XYImageScrollView *xyView;
@end

@implementation ViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.xyView = [[XYImageScrollView alloc] initWithFrame:self.view.frame andImageArr:[NSArray arrayWithObjects:@"test1.jpg",@"test2.jpg",@"test3.jpg",@"test4.jpg",@"test5.jpg",@"test6.jpg",@"test7.jpg",@"test8.jpg", nil]];
    [self.view addSubview:self.xyView];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
