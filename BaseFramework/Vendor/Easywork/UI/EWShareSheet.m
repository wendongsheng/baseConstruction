//
//  EWShareSheet.m
//  EasyWork
//
//  Created by wendongsheng on 15-1-26.
//  Copyright (c) 2015年 wendongsheng. All rights reserved.
//

#import "EWShareSheet.h"
@interface EWShareSheet()<UIScrollViewDelegate>
@property (nonatomic, retain)UIScrollView* scrollView;
@property (nonatomic, retain)UIPageControl* pageControl;
@property (nonatomic, retain)NSMutableArray* items;
@property (nonatomic, assign)id<EWShareSheetDelegate> shareDelegate;
@property (nonatomic, assign) NSInteger itemCountforOneLine;

@property (nonatomic, strong) UIView *backgroundMask;
@property (nonatomic, strong) UIView *contentView;
@end

@implementation EWShareSheet

@synthesize collect;

-(void)dealloc
{
    _shareDelegate= nil;
}


-(instancetype)initWithDelegate:(id<EWShareSheetDelegate>)delegate count:(NSInteger)count
{
    self = [self initWithFrame:[UIScreen mainScreen].bounds];
    
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        
        //window back
        self.backgroundMask = [[UIView alloc] initWithFrame:self.bounds];
        self.backgroundMask.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        self.backgroundMask.backgroundColor = [UIColor blackColor];
        self.backgroundMask.alpha = 0.5;
        [self addSubview:self.backgroundMask];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
        [self.backgroundMask addGestureRecognizer:tap];
        
        
        //content back
        self.contentView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.bounds), CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds))];
        self.contentView.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.8];
        self.contentView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
        [self addSubview:self.contentView];
        self.itemCountforOneLine = 4;
        
        
        _shareDelegate = delegate;
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.contentView.bounds), 105*3)];
        [_scrollView setPagingEnabled:YES];
        [_scrollView setBackgroundColor:[UIColor clearColor]];
        [_scrollView setShowsHorizontalScrollIndicator:NO];
        [_scrollView setShowsVerticalScrollIndicator:NO];
        [_scrollView setDelegate:self];
        [_scrollView setScrollEnabled:YES];
        [_scrollView setBounces:NO];
        
        [self.contentView addSubview:_scrollView];
        
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.scrollView.frame), CGRectGetWidth(self.contentView.bounds), 0)];
        [_pageControl setNumberOfPages:0];
        [_pageControl setCurrentPage:0];
        _pageControl.hidesForSinglePage = YES;
        [_pageControl addTarget:self action:@selector(changePage:)forControlEvents:UIControlEventValueChanged];
        [self.contentView addSubview:_pageControl];
        
        self.items = [[NSMutableArray alloc] initWithCapacity:count];
        self.windowLevel = UIWindowLevelAlert;
        
        _showCollect =YES;
    }
    
    return self;
}

static EWShareSheet *sheet = nil;


- (void)collect:(UIButton *)sender
{
    //
    [_shareDelegate didSelectedItemAtIndex:sender.tag];
    [self dismiss];
}

- (void)dismiss
{
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.backgroundMask.alpha = 0;
        [self setContentViewFrameY:CGRectGetHeight(self.bounds)];
    } completion:^(BOOL finished) {
        sheet.hidden = YES;
        sheet = nil;
    }];
}

- (void)setContentViewFrameY:(CGFloat)y
{
    CGRect frame = self.contentView.frame;
    frame.origin.y = y;
    self.contentView.frame = frame;
}

- (void)show
{
    [self reloadData];
    
    sheet = self;
    sheet.hidden = NO;
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.backgroundMask.alpha = 0.5;
        [self setContentViewFrameY:CGRectGetHeight(self.bounds) - CGRectGetHeight(self.contentView.frame)];
    } completion:^(BOOL finished) {
        
    }];
}

- (void)reloadData
{
    for (EWShareSheetCell* cell in _items) {
        [cell removeFromSuperview];
        [_items removeObject:cell];
    }
    
    NSInteger count = [_shareDelegate numberOfItemsInShareSheet];
    
    if (count <= 0) {
        return;
    }
    
    NSInteger rowCount = 3;
    
    if (count <= self.itemCountforOneLine) {
        [_scrollView setFrame:CGRectMake(0, 0, CGRectGetWidth(self.contentView.bounds), 105)];
        rowCount = 1;
    } else if (count <= self.itemCountforOneLine*2) {
        [_scrollView setFrame:CGRectMake(0, 0, CGRectGetWidth(self.contentView.bounds), 210)];
        rowCount = 2;
    }
    
    CGFloat pageControlY = CGRectGetMinY(self.scrollView.frame) + CGRectGetHeight(self.scrollView.frame);
    CGRect pageControlFrame = self.pageControl.frame;
    pageControlFrame.origin.y = pageControlY;
    self.pageControl.frame = pageControlFrame;
    
    NSUInteger itemPerPage = self.itemCountforOneLine*rowCount;
    [_scrollView setContentSize:CGSizeMake(CGRectGetWidth(self.contentView.bounds)*ceilf((((float)count)/itemPerPage)), _scrollView.frame.size.height)];
    [_pageControl setNumberOfPages:ceilf((((float)count)/itemPerPage))];
    [_pageControl setCurrentPage:0];
    
    CGFloat margin = 0;
    CGFloat width = self.scrollView.frame.size.width - margin*2;
    
    for (NSInteger i = 0; i< count; i++) {
        EWShareSheetCell* cell = [_shareDelegate cellForItemAtIndex:i];
        cell.tag = i;
        NSInteger PageNo = i/itemPerPage;
        NSInteger index  = i%itemPerPage;
        
        NSInteger row = index/self.itemCountforOneLine;
        NSInteger column = index%self.itemCountforOneLine;
        
        float centerY = (1+row*2)*self.scrollView.frame.size.height/(2*rowCount);
        float centerX = (1+column*2)*width/(2*self.itemCountforOneLine);
        
        [cell setCenter:CGPointMake(margin + centerX+CGRectGetWidth(self.contentView.bounds)*PageNo, centerY)];
        [self.scrollView addSubview:cell];
        
        UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(actionForItem:)];
        [cell addGestureRecognizer:tap];
        
        [_items addObject:cell];
    }
    
    UIView *scrollBG = [[UIView alloc] initWithFrame:CGRectMake(margin, 0, CGRectGetWidth(self.scrollView.frame) - margin * 2, CGRectGetHeight(self.scrollView.frame))];
    scrollBG.backgroundColor = [UIColor clearColor];
    scrollBG.clipsToBounds = YES;
    [self.contentView insertSubview:scrollBG belowSubview:self.scrollView];
    
    CGFloat y = CGRectGetMinY(self.pageControl.frame) +  5 + (self.pageControl.numberOfPages == 1 ? 0 : CGRectGetHeight(self.pageControl.frame));
    
    if(_showCollect ==YES){
        collect = [UIButton buttonWithType:UIButtonTypeCustom];
        collect.frame = CGRectMake(10, y, CGRectGetWidth(self.contentView.frame) - 10 * 2, 42);
        [collect setTitle:@"收藏" forState:UIControlStateNormal];
        [collect setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [collect setBackgroundColor:[UIColor colorWithRed:52/255.0 green:152/255.0 blue:219/255.0 alpha:1]];
        collect.tag = 100;
        collect.titleLabel.font = [UIFont systemFontOfSize:15];
        [collect addTarget:self action:@selector(collect:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:collect];
        y += 42+10;
    }
    
    UIButton *cancel = [UIButton buttonWithType:UIButtonTypeCustom];
    cancel.frame = CGRectMake(10, y, CGRectGetWidth(self.contentView.frame) - 10 * 2, 42);
    [cancel setTitle:@"取消" forState:UIControlStateNormal];
    [cancel setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    cancel.titleLabel.font = [UIFont systemFontOfSize:15];
    [cancel addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:cancel];
    cancel.backgroundColor = [UIColor whiteColor];
    CGFloat height = CGRectGetMinY(cancel.frame) + CGRectGetHeight(cancel.frame) +10;
    
    CGRect frame = self.contentView.frame;
    frame.size.height = height;
    self.contentView.frame = frame;
}


- (void)actionForItem:(UITapGestureRecognizer*)recongizer
{
    EWShareSheetCell* cell = (EWShareSheetCell*)[recongizer view];
    
    [self dismiss];
    [_shareDelegate didSelectedItemAtIndex:cell.index];
}

- (IBAction)changePage:(id)sender {
    NSInteger page = (int)_pageControl.currentPage;
    [_scrollView setContentOffset:CGPointMake(CGRectGetWidth(self.contentView.bounds) * page, 0)];
}
#pragma mark -
#pragma scrollview _shareDelegate

- (void)scrollViewDidScroll:(UIScrollView *)sender {
    NSInteger page = _scrollView.contentOffset.x /CGRectGetWidth(self.contentView.bounds);
    _pageControl.currentPage = page;
}

@end

#pragma mark - AWActionSheetCell
@interface EWShareSheetCell ()
@end
@implementation EWShareSheetCell
@synthesize iconView;
@synthesize titleLabel;

-(id)init
{
    self = [super initWithFrame:CGRectMake(0, 0, 70, 70)];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        self.iconView = [[UIImageView alloc] initWithFrame:CGRectMake(6.5, 0, 57, 57)];
        [iconView setBackgroundColor:[UIColor clearColor]];
        [[iconView layer] setCornerRadius:10.5f];
        [[iconView layer] setMasksToBounds:YES];
        
        [self addSubview:iconView];
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 63, 70, 13)];
        [titleLabel setBackgroundColor:[UIColor clearColor]];
        [titleLabel setTextAlignment:NSTextAlignmentCenter];
        [titleLabel setFont:[UIFont systemFontOfSize:13]];
        [titleLabel setTextColor:[UIColor blackColor]];
        [titleLabel setAdjustsFontSizeToFitWidth:YES];
        [titleLabel setText:@""];
        [self addSubview:titleLabel];
        
        
    }
    return self;
}


@end
