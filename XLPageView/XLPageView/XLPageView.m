//
//  XLPageView.m
//  XLPageView
//
//  Created by 路 on 2017/12/27.
//  Copyright © 2017年 路. All rights reserved.
//

#import "XLPageView.h"

@interface XLPageView()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate>
//@property (nonatomic, strong) HMSegmentedControl *segmentedControl;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic, strong) UIViewController *parentVC;
@property (nonatomic, strong) NSArray<UIViewController *> *childVCs;
@end

@implementation XLPageView


-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addContentView];
    }
    return self;
}


-(void)awakeFromNib{
    [super awakeFromNib];
    NSLog(@"\nW:%f \nH:%f",self.frame.size.width, self.frame.size.height);
    [self addContentView];
}
-(void)layoutSubviews{
    self.segmentedControl.frame = CGRectMake(0, 0, self.frame.size.width, 40);
    _flowLayout.itemSize = CGSizeMake(self.frame.size.width, self.frame.size.height - 40);
    _collectionView.frame = CGRectMake(0, 40, self.frame.size.width, self.frame.size.height - 40);
}



-(void)setSegmentedControl:(HMSegmentedControl *)segmentedControl{
    _segmentedControl = segmentedControl;
    [self addTitleView];
}


-(void)setChildVCs:(NSArray<UIViewController *> *)childVCs parentVC:(UIViewController *)parentVC defaultItem:(NSInteger)defaultItem{
    _parentVC = parentVC;
    _childVCs = childVCs;
    for (UIViewController *vc in _childVCs) {
        [_parentVC addChildViewController:vc];
    }
    [self.collectionView reloadData];
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:defaultItem inSection:0];
    [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
}




//添加头部标题按钮
-(void)addTitleView{
    self.segmentedControl.frame = _segmentedtControlFrame;
    __weak typeof(self) weakSelf = self;
    [self.segmentedControl setIndexChangeBlock:^(NSInteger index) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:index inSection:0];
        [weakSelf.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    }];
    [self addSubview:self.segmentedControl];
}



//添加容器
-(void)addContentView{
    _flowLayout = [[UICollectionViewFlowLayout alloc] init];
    _flowLayout.itemSize = CGSizeMake(self.frame.size.width, self.frame.size.height - self.segmentedControl.frame.size.height);
    _flowLayout.minimumLineSpacing = 0;
    _flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.segmentedControl.frame), self.frame.size.width, self.frame.size.height - self.segmentedControl.frame.size.height) collectionViewLayout:_flowLayout];
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.pagingEnabled = YES;
    _collectionView.showsVerticalScrollIndicator = NO;
    _collectionView.showsHorizontalScrollIndicator = NO;
    [self addSubview:_collectionView];
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
}




#pragma mark --- UICollectionViewDataSource
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return  _childVCs.count;
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    for (UIView *subView in cell.contentView.subviews) {
        [subView removeFromSuperview];
    }
    UIViewController *vc = _childVCs[indexPath.item];
    vc.view.frame = cell.contentView.frame;
    [cell.contentView addSubview:vc.view];
    return cell;
}




#pragma mark 设置页码
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGFloat pageWidth = scrollView.frame.size.width;
    NSInteger page = scrollView.contentOffset.x / pageWidth;
    if (scrollView == self.collectionView) {
        [self.segmentedControl setSelectedSegmentIndex:page animated:YES];
    }
    
}


@end
