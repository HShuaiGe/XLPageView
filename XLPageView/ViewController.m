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
@property (nonatomic, strong) XLPageView *pageView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray *titles = @[@"一", @"二", @"三", @"四", @"五", @"六"];
    
#warning 标题不同的类型使用可以请参考 HMSegmentedControl   非常感谢HMSegmentedControl作者
    HMSegmentedControl *segmentedControl = [[HMSegmentedControl alloc]init];
    _pageView = [[XLPageView alloc]initWithFrame:CGRectMake(0, 20, 320, 500)];
    _pageView.segmentedtControlFrame = CGRectMake(0, 0, 320, 40);
    segmentedControl.selectedSegmentIndex = 0;
    segmentedControl.sectionTitles = titles;
    segmentedControl.backgroundColor = [UIColor whiteColor];
    segmentedControl.selectionIndicatorHeight = 2;
    segmentedControl.segmentEdgeInset = UIEdgeInsetsMake(0, 10, 0, 10);
    segmentedControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    UIFont* font = [UIFont systemFontOfSize:15];
    segmentedControl.titleTextAttributes = @{NSFontAttributeName:font,NSForegroundColorAttributeName:[UIColor blackColor]};
    segmentedControl.selectedTitleTextAttributes = @{NSFontAttributeName:font,NSForegroundColorAttributeName:[UIColor redColor]};
    _pageView.segmentedControl = segmentedControl;
    [self.view addSubview:_pageView];
    NSMutableArray *viewControllers = [NSMutableArray array];
    
    
    
    UIViewController *vc;
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
     [self.pageView setChildVCs:viewControllers parentVC:self]; 
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
