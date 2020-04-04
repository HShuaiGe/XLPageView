//
//  XLPageView.h
//  XLPageView
//
//  Created by 路 on 2017/12/27.
//  Copyright © 2017年 路. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HMSegmentedControl.h"

typedef void(^XZSelectedBlock)(NSInteger index);
@interface XLPageView : UIView

@property (nonatomic, copy) XZSelectedBlock block;
- (void)xz_setChildVCs:(NSArray<UIViewController *> *)childVCs parentVC:(UIViewController *)parentVC defaultItem:(NSInteger)defaultItem;
- (void)xz_scrollToItemAtIndex:(NSInteger)index;
- (void)xz_scrollToItemAtIndex:(NSInteger)index atScrollPosition:(UICollectionViewScrollPosition)scrollPosition animated:(BOOL)animated;

@end
