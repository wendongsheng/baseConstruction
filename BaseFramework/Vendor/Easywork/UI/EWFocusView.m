//
//  EWFocusView.m
//  Easywork
//
//  Created by Jin on 15-1-14.
//  Copyright (c) 2015年 kingxl. All rights reserved.
//

#import "EWFocusView.h"

@interface EWFocusView()<UIScrollViewDelegate>
{
    UIScrollView *_scrollView;
    NSMutableArray *_contentViews;
    NSTimer *_timer;
    UIView *_titleBackgroundView;
    UILabel *_titleLabel;
    UIPageControl *_pageControl;
    NSInteger pages;
    NSInteger currentPage;
    BOOL showPageIndicator;
}

- (void)configScrollView;
- (void)configTitleView;
- (void)configData;

@end

@implementation EWFocusView

- (id)initWithFrame:(CGRect)frame showPageIndicator:(BOOL)show
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        showPageIndicator = show;
        
        [self configScrollView];
        
        [self configTitleView];
        
        [self configData];
    }
    return self;
}


- (void)dealloc
{
    if (_timer != nil ) {
        [_timer invalidate];
    }
    [_scrollView setDelegate:nil];
    
#if (!__has_feature(objc_arc))
    [_scrollView release];
    [_titleLabel release];
    [_timer release];
    
    if (_pageControl != nil) {
        [_pageControl release];
    }
    
    
    [_titleBackgroundView release];
    
    [super dealloc];
    
#endif
}


#pragma mark -- config scrollview

- (void)configScrollView
{
    _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    _scrollView.pagingEnabled = YES;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.delegate = self;
    _scrollView.contentSize = CGSizeMake(self.bounds.size.width * 3, self.bounds.size.height);
    _scrollView.contentOffset = CGPointMake(self.bounds.size.width, 0);
    [self addSubview:_scrollView];
}

#pragma mark -- config title view
- (void)configTitleView
{
    _titleBackgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, self.bounds.size.height-40, self.bounds.size.width, 40)];
    _titleBackgroundView.backgroundColor = [UIColor clearColor];
    [self addSubview:_titleBackgroundView];
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, self.bounds.size.width-10, 40)];
    _titleLabel.textAlignment = NSTextAlignmentLeft;
    _titleLabel.font = [UIFont systemFontOfSize:14];
    _titleLabel.textColor = [UIColor whiteColor];
    _titleLabel.backgroundColor = [UIColor clearColor];
    [_titleBackgroundView addSubview:_titleLabel];
    
    if (showPageIndicator) {
        // _titleLabel.frame = CGRectMake(5, 0, 250, 40);
        
        _pageControl= [[UIPageControl alloc] initWithFrame:CGRectMake(ViewFW(_titleBackgroundView)-70, 25, 70, 10)];
        _pageControl.pageIndicatorTintColor = [UIColor colorWithWhite:1.0 alpha:0.6];
        _pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
        _pageControl.backgroundColor = CLEAR_COLOR;
        [_titleBackgroundView addSubview:_pageControl];
    }
    
}

#pragma mark -- config data

- (void)configData
{
    /// init current views
    _contentViews = [NSMutableArray arrayWithCapacity:0];
    
}



#pragma mark -- reload Data

- (void)reloadData
{
    /// get numbers of page
    pages = [self.dataSource numberOfPages:self];
    currentPage = 0;
    
    if (showPageIndicator) {
        _pageControl.numberOfPages = pages;
        if (pages == 1) {
            _pageControl.hidden = YES;
        }else{
            _pageControl.hidden = NO;
        }
        _pageControl.frame = CGRectMake(ViewFW(_titleBackgroundView)-pages*15-10, 25, pages*15, 10);
    }
    
    if (pages != 0) {
        
        [self loadData];
    }
}


#pragma mark -- load data

- (void)loadData
{
    ///clear subviews of scrollview
    [self clearSubView:_scrollView];
    
    ///get new data
    [self getDisplayViews:currentPage];
    
    
    /// add view to scrollview
    for (int i = 0; i < 3; i++){
        UIView *view = [_contentViews objectAtIndex:i];
        view.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
        [view addGestureRecognizer:tap];
        view.frame = CGRectOffset(view.frame, view.frame.size.width*i, 0);
        [_scrollView addSubview:view];
    }
    
    // show display view
    _scrollView.contentOffset = CGPointMake(self.frame.size.width, 0);
    _titleLabel.text = [self.dataSource focusView:self titleForPageAtIndex:currentPage];
    
    if (showPageIndicator) {
        _pageControl.currentPage = currentPage;
        
    }
}

#pragma mark -- clear subviews

- (void)clearSubView:(UIView *)view
{
    for (UIView *temp in view.subviews) {
        [temp removeFromSuperview];
    }
}

#pragma mark -- get display views
- (void)getDisplayViews:(NSInteger)curPage
{
    NSInteger pre = [self pageAtIndex:curPage - 1];
    NSInteger next = [self pageAtIndex:curPage + 1];
    
    ///remove all object
    if (_contentViews.count != 0) {
        [_contentViews removeAllObjects];
    }
    
    ///add new object
    [_contentViews addObject:[self.dataSource focusView:self pageAtIndex:pre]];
    [_contentViews addObject:[self.dataSource focusView:self pageAtIndex:curPage]];
    [_contentViews addObject:[self.dataSource focusView:self pageAtIndex:next]];
    
}

#pragma mark -- get page index
- (NSInteger)pageAtIndex:(NSInteger)index
{
    if (index == -1)  index = pages - 1;
    if (index == pages) index =  0;
    return index;
}

#pragma mark -- handle tap gesture
- (void)handleTap:(UITapGestureRecognizer *)tap
{
    if ([self.delegate respondsToSelector:@selector(focusView:didSelectAtIndex:)]) {
        [self.delegate focusView:self didSelectAtIndex:currentPage];
    }
}


#pragma mark -- start auto run

- (void)startAutoRun
{
    if(_timer ==nil){
        _timer = [NSTimer scheduledTimerWithTimeInterval:_timeInterval target:self selector:@selector(start:) userInfo:nil repeats:YES];
    }
}

#pragma mark -- start
- (void)start:(NSTimer *)timer
{
    /// add by Lixian
    if (!CGAffineTransformEqualToTransform(self.transform, CGAffineTransformMake(1, 0, 0, 1, 0, 0))) {
        return;
    }
    /// end
    
    [_scrollView setContentOffset:CGPointMake(self.frame.size.width  * 2, 0) animated:YES];
}

#pragma mark -- stop auto run

- (void)stopAutoRun
{
    if ([_timer isValid]) {
        [_timer invalidate];
        _timer = nil;
    }
}

#pragma mark -- scroll view delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    int x = scrollView.contentOffset.x;
    if (x >= self.bounds.size.width*2) {
        currentPage = [self pageAtIndex:currentPage + 1];
        [self loadData];
    }
    
    if (x <= 0) {
        currentPage  = [self pageAtIndex:currentPage - 1];
        [self loadData];
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self resetTimer];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self resetTimer];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [_scrollView setContentOffset:CGPointMake(self.frame.size.width, 0) animated:YES];
}


#pragma mark -- reset timer

- (void)resetTimer
{
    if ([_timer isValid]) {
        [_timer invalidate];
        _timer = nil;
    }else{
        [self startAutoRun];
    }
}

@end
