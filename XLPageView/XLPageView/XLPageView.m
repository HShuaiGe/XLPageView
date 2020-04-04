//
//  XLPageView.m
//  XLPageView
//
//  Created by 路 on 2017/12/27.
//  Copyright © 2017年 路. All rights reserved.
//

#import "XLPageView.h"

@interface XLPageView()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic, strong) NSArray<UIViewController *> *childVCs;
@property (nonatomic, assign) NSInteger defaultItem;
@property (nonatomic, weak) UIViewController *parentVC;

@end

@implementation XLPageView


-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addContentView];
    }
    return self;
}


-(void)awakeFromNib
{
    [super awakeFromNib];
    [self addContentView];
}

-(void)layoutSubviews
{
    self.flowLayout.itemSize = CGSizeMake(self.frame.size.width, self.frame.size.height);
    self.collectionView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    [self xz_scrollToItemAtIndex:self.defaultItem atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
}

- (void)xz_scrollToItemAtIndex:(NSInteger)index
{
    [self xz_scrollToItemAtIndex:index atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
}

- (void)xz_scrollToItemAtIndex:(NSInteger)index atScrollPosition:(UICollectionViewScrollPosition)scrollPosition animated:(BOOL)animated
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:index inSection:0];
    [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:scrollPosition animated:animated];
}



-(void)xz_setChildVCs:(NSArray<UIViewController *> *)childVCs parentVC:(UIViewController *)parentVC defaultItem:(NSInteger)defaultItem
{
    self.parentVC = parentVC;
    self.childVCs = childVCs;
    self.defaultItem = defaultItem;
    for (UIViewController *vc in _childVCs) {
        [self.parentVC addChildViewController:vc];
    }
    [self.collectionView reloadData];
}




//添加容器
-(void)addContentView{
    self.defaultItem = 0;
    self.flowLayout = [[UICollectionViewFlowLayout alloc] init];
    self.flowLayout.itemSize = CGSizeMake(self.frame.size.width, self.frame.size.height);
    self.flowLayout.minimumLineSpacing = 0;
    self.flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) collectionViewLayout:self.flowLayout];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.pagingEnabled = YES;
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    [self addSubview:self.collectionView];
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
}




#pragma mark --- UICollectionViewDataSource
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return  self.childVCs.count;
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    for (UIView *subView in cell.contentView.subviews) {
        [subView removeFromSuperview];
    }
    UIViewController *vc = self.childVCs[indexPath.item];
    vc.view.frame = cell.contentView.frame;
    [cell.contentView addSubview:vc.view];
    return cell;
}




#pragma mark 设置页码
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGFloat pageWidth = scrollView.frame.size.width;
    NSInteger page = scrollView.contentOffset.x / pageWidth;
    if (scrollView == self.collectionView) {
        if (_block) {
            _block(page);
        }
    }
    
}
- (void)dealloc
{
    NSLog(@"%s", __func__);
}

@end
