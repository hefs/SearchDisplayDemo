//
//  VertiFirstViewController.m
//  PageControllerDemo
//
//  Created by 何发松 on 16/3/28.
//  Copyright © 2016年 HeRay. All rights reserved.
//

#import "VertiFirstViewController.h"
#import "HoriFirstViewController.h"
#import "HoriSecondViewController.h"
#import "HoriThirdViewController.h"

@interface VertiFirstViewController ()<UIPageViewControllerDataSource,UIPageViewControllerDelegate>
{
    NSArray *pageCopntrollers;
    UISegmentedControl *seg;
}
@property (nonatomic,strong) UIPageViewController *pageCtrs;
@end

@implementation VertiFirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self initPageControllers];
    [self pageCtrs];
    [self initSegmentControl];
    
}

- (void)initSegmentControl{
    seg = [[UISegmentedControl alloc] initWithItems:@[@"Item1",@"Item2",@"Item3"]];
    seg.selectedSegmentIndex = 0;
    [seg setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14],NSForegroundColorAttributeName:[UIColor darkGrayColor]} forState:UIControlStateNormal];
    [seg setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14],NSForegroundColorAttributeName:[UIColor blueColor]} forState:UIControlStateSelected];
    [seg addTarget:self action:@selector(didValueChanged:) forControlEvents:UIControlEventValueChanged];
    seg.frame = CGRectMake(0, 20, CGRectGetWidth([UIScreen mainScreen].bounds), 44);
    seg.tintColor = [UIColor whiteColor];
    [self.view addSubview:seg];
}

- (void)didValueChanged:(UISegmentedControl *)sender{
    NSInteger index = sender.selectedSegmentIndex;
    [self.pageCtrs setViewControllers:@[pageCopntrollers[index]] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
}

- (void)initPageControllers{
    HoriFirstViewController *firstCtrs = [[HoriFirstViewController alloc] initWithNibName:NSStringFromClass([HoriFirstViewController class]) bundle:nil];
    HoriSecondViewController *secondCtrs = [[HoriSecondViewController alloc] initWithNibName:NSStringFromClass([HoriSecondViewController class]) bundle:nil];
    HoriThirdViewController *thirdCtrs = [[HoriThirdViewController alloc] initWithNibName:NSStringFromClass([HoriThirdViewController class]) bundle:nil];
    pageCopntrollers = @[firstCtrs,secondCtrs,thirdCtrs];
}

- (UIPageViewController *)pageCtrs{
    if (!_pageCtrs) {
        _pageCtrs = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
        _pageCtrs.delegate = self;
        _pageCtrs.dataSource = self;
        /**
         * 设置当前显示的视图控制器集合（只有当前控制器一个元素），而不是UIPageViewController控制的视图集合
         */
        [_pageCtrs setViewControllers:@[pageCopntrollers[0]] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
        _pageCtrs.view.frame = CGRectMake(0, 64, CGRectGetWidth(self.view.bounds), CGRectGetHeight([UIScreen mainScreen].bounds) - 64*2 - 5);
        [self addChildViewController:_pageCtrs];
        [self.view addSubview:_pageCtrs.view];
    }
    return _pageCtrs;
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController{
    NSInteger index = [pageCopntrollers indexOfObject:viewController];
    if (index == pageCopntrollers.count - 1) {
        return nil;
    }
    return [pageCopntrollers objectAtIndex:index + 1];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController{
    NSInteger index = [pageCopntrollers indexOfObject:viewController];
    if (index == 0) {
        /**
         *  第一页必须返回nil，不能返回viewController，否则会有空白页，最后一页亦然
         */
        return nil;
    }
    return [pageCopntrollers objectAtIndex:index - 1];
}

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed{
    if (!finished) {
        return;
    }
    NSInteger index = [pageCopntrollers indexOfObject:pageViewController.viewControllers.firstObject];
    [seg setSelectedSegmentIndex:index];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
