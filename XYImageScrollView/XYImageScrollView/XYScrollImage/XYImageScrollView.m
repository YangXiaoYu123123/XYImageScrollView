//
//  XYImageScrollView.m
//  XYImageScrollView
//
//  Created by tvie on 13-11-22.
//  Copyright (c) 2013年 YXY. All rights reserved.
//

#import "XYImageScrollView.h"

#define AP @"Appear"
#define DISAP @"Disappear"

@interface XYImageScrollView ()<UIScrollViewDelegate>
@property (nonatomic, strong) NSMutableDictionary *imageViewDic;
@property (nonatomic, strong) NSArray *imageArr;

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, assign) CGPoint oldPoint;
@property (nonatomic, assign) NSInteger currentIndex;
@property (nonatomic, assign) BOOL whetherScroll;
@end

@implementation XYImageScrollView

- (id)initWithFrame:(CGRect)frame andImageArr:(NSArray *)arr{
    self = [super initWithFrame:frame];
    if (self) {
        self.scrollView = [[UIScrollView alloc] initWithFrame:frame];
        self.scrollView.delegate = self;
        self.scrollView.pagingEnabled = YES;
        self.scrollView.showsHorizontalScrollIndicator = NO;
        CGRect frame = self.scrollView.frame;
        frame.origin.x = 0;
        frame.origin.y = 0;
        self.scrollView.frame = frame;
        
        [self addSubview:self.scrollView];
        self.imageViewDic = [NSMutableDictionary dictionaryWithCapacity:2];
        
        self.imageArr = arr;
        
        [self setup];
    }
    return self;
}

- (void)setup{
    UIImageView *view = [[UIImageView alloc] initWithFrame:self.scrollView.frame];
    [view setImage:[UIImage imageNamed:[self.imageArr objectAtIndex:0]]];
    [self.scrollView addSubview:view];
    [self.imageViewDic setValue:view forKey:AP];
    self.oldPoint = self.scrollView.contentOffset;
    self.currentIndex = 0;
    [self.scrollView setContentSize:CGSizeMake(self.scrollView.frame.size.width*self.imageArr.count, self.scrollView.frame.size.height)];
}

- (void)setImageViewFrame:(UIImageView *)view andWhetherLeft:(BOOL)left{
    
    CGRect frame = view.frame;
    int m;
    if (left) {
        frame.origin.x = [(UIImageView *)[self.imageViewDic objectForKey:AP] frame].origin.x+[(UIImageView *)[self.imageViewDic objectForKey:AP] frame].size.width;
        if (self.currentIndex+1>self.imageArr.count-1) {
            m = 0;
        }else
            m = self.currentIndex+1;
        [view setImage:[UIImage imageNamed:[self.imageArr objectAtIndex:m]]];
    }else{
        frame.origin.x = [(UIImageView *)[self.imageViewDic objectForKey:AP] frame].origin.x-[(UIImageView *)[self.imageViewDic objectForKey:AP] frame].size.width;
        if (self.currentIndex == 0) {
            m = self.imageArr.count-1;
        }else
            m = self.currentIndex-1;
        [view setImage:[UIImage imageNamed:[self.imageArr objectAtIndex:m]]];
    }
    
    frame.origin.y = 0;
    view.frame = frame;
    [self.scrollView addSubview:view];
}

- (void)changeImageDic{
    UIImageView *image1 = [self.imageViewDic objectForKey:AP];
    UIImageView *image2 = [self.imageViewDic objectForKey:DISAP];
    [image1 removeFromSuperview];
    
    [self.imageViewDic setValue:image1 forKey:DISAP];
    [self.imageViewDic setValue:image2 forKey:AP];
}
#pragma UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGPoint point = scrollView.contentOffset;
    if (!self.whetherScroll) {
        UIImageView *imageView = [self.imageViewDic objectForKey:DISAP];
        if (!imageView) {
            imageView = [[UIImageView alloc] initWithFrame:self.scrollView.frame];
            [self.imageViewDic setValue:imageView forKey:DISAP];
        }
        
        if ((point.x-self.oldPoint.x)>0) {
            [self setImageViewFrame:imageView andWhetherLeft:YES];
        }else if((point.x-self.oldPoint.x)<0){
            [self setImageViewFrame:imageView andWhetherLeft:NO];
        }
    }
    self.whetherScroll = YES;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if (self.oldPoint.x != scrollView.contentOffset.x) {
       [self changeImageDic];
    }
    self.oldPoint = scrollView.contentOffset;
    self.currentIndex = scrollView.contentOffset.x/self.scrollView.frame.size.width;
    self.whetherScroll = NO;
}

- (void)dealloc{
    self.imageArr = nil;
    self.imageViewDic = nil;
}
@end
