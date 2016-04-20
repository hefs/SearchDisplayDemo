//
//  ViewController.m
//  PageControllerDemo
//
//  Created by 何发松 on 16/3/28.
//  Copyright © 2016年 HeRay. All rights reserved.
//

#import "ViewController.h"
#import "VertiFirstViewController.h"
#import "VertiSecondViewController.h"

@interface ViewController ()<UIPageViewControllerDataSource,UIPageViewControllerDelegate>
{
    NSArray *pageControllers;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    VertiFirstViewController *pageCtr1 = [[VertiFirstViewController alloc] initWithNibName:NSStringFromClass([VertiFirstViewController class]) bundle:nil];
    VertiSecondViewController *pageCtr2 = [[VertiSecondViewController alloc] initWithNibName:NSStringFromClass([VertiSecondViewController class]) bundle:nil];
    pageControllers = @[pageCtr1,pageCtr2];
    
    UIPageViewController *pageCtrs = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationVertical options:nil];
    pageCtrs.delegate = self;
    pageCtrs.dataSource = self;
    [pageCtrs setViewControllers:@[[self viewControllerAtIndex:0]] direction:UIPageViewControllerNavigationDirectionReverse animated:YES completion:^(BOOL finished){
        NSLog(@"123");
    }];
//    pageCtrs.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 64);
    [self addChildViewController:pageCtrs];
    [self.view addSubview:pageCtrs.view];
}

- (UIViewController *)viewControllerAtIndex:(NSInteger)index{
    if (index < 0 || index > pageControllers.count - 1) {
        return nil;
    }
    return [pageControllers objectAtIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController{
    NSInteger index = [pageControllers indexOfObject:viewController];
    if (index == pageControllers.count - 1) {
        return nil;
    }
    return [pageControllers objectAtIndex:index + 1];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController{
    NSInteger index = [pageControllers indexOfObject:viewController];
    if (index == 0) {
        return nil;
    }
    return [pageControllers objectAtIndex:index - 1];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
