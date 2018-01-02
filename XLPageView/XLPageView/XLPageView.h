//
//  XLPageView.h
//  XLPageView
//
//  Created by 路 on 2017/12/27.
//  Copyright © 2017年 路. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HMSegmentedControl.h"

@interface XLPageView : UIView
@property (nonatomic, strong) HMSegmentedControl *segmentedControl;
@property (nonatomic, assign) CGRect segmentedtControlFrame;
-(void)setChildVCs:(NSArray<UIViewController *> *)childVCs parentVC:(UIViewController *)parentVC defaultItem:(NSInteger)defaultItem;
@end
