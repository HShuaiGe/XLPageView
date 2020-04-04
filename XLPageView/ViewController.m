//
//  ViewController.m
//  XLPageView
//
//  Created by 路 on 2017/12/27.
//  Copyright © 2017年 路. All rights reserved.
//

#import "ViewController.h"
#import "XLPageView.h"
#import "FirstViewController.h"
#import "SecondViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet XLPageView *pageView;
@property (weak, nonatomic) IBOutlet HMSegmentedControl *segmentedControl;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    __weak typeof(self) weakSelf = self;
    
    //选项卡
    NSArray *titles = @[@"一", @"二", @"三", @"四", @"五", @"六"];
    self.segmentedControl.selectedSegmentIndex = 2;//默认选中第二个
    self.segmentedControl.sectionTitles = titles;
    self.segmentedControl.backgroundColor = [UIColor whiteColor];
    self.segmentedControl.selectionIndicatorHeight = 2;
    self.segmentedControl.segmentEdgeInset = UIEdgeInsetsMake(0, 10, 0, 10);
    self.segmentedControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    UIFont* font = [UIFont systemFontOfSize:15];
    self.segmentedControl.titleTextAttributes = @{NSFontAttributeName:font,NSForegroundColorAttributeName:[UIColor blackColor]};
    self.segmentedControl.selectedTitleTextAttributes = @{NSFontAttributeName:font,NSForegroundColorAttributeName:[UIColor redColor]};
    
    [self.segmentedControl setIndexChangeBlock:^(NSInteger index)
    {
        [weakSelf.pageView xz_scrollToItemAtIndex:index];
    }];
    
    
    //容器子View
    UIViewController *vc;
    NSMutableArray *viewControllers = [NSMutableArray array];
    for (NSString *title in titles) { //此处可以根据后台传的类型判断加载什么VC
        if ([title isEqualToString:@"三"]) {
            vc = [[SecondViewController alloc]init];
        }else{
            vc = [[FirstViewController alloc]init];
            int R = (arc4random() % 256) ;
            int G = (arc4random() % 256) ;
            int B = (arc4random() % 256) ;
            [vc.view setBackgroundColor:[UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:1]];
        }
        [viewControllers addObject:vc];
    }
    
    [self.pageView xz_setChildVCs:viewControllers parentVC:self defaultItem:2];  //默认选中第二个
    
    self.pageView.block = ^(NSInteger index) {
        [weakSelf.segmentedControl setSelectedSegmentIndex:index];
    };
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    NSLog(@"%s", __func__);
}
@end
