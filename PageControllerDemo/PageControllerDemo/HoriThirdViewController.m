//
//  HoriThirdViewController.m
//  PageControllerDemo
//
//  Created by 何发松 on 16/3/28.
//  Copyright © 2016年 HeRay. All rights reserved.
//

#import "HoriThirdViewController.h"

@interface OxModel : NSObject
@property (nonatomic) NSInteger age;
@end

@interface HoriThirdViewController (){
    NSMutableArray *oxes;
}
@end

@implementation OxModel


@end

@implementation HoriThirdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    OxModel *ox = [OxModel new];
    ox.age = 0;
    oxes = [[NSMutableArray alloc] initWithObjects:ox, nil];
    [self oxCountAfterYears:10];
    NSLog(@"count : %ld",oxes.count);
}

- (void)oxCountAfterYears:(NSInteger)years{
    if (years < 2) {
        return;
    }
    for (int i = 1; i <= years; i++) {
        NSMutableArray *newOxes = [NSMutableArray arrayWithCapacity:0];
        for (OxModel *ox in oxes) {
            ox.age = ox.age + 1;
            if (ox.age >= 4) {
                OxModel *newOx = [OxModel new];
                newOx.age = 0;
                [newOxes addObject:newOx];
            }
        }
        if (newOxes.count) {
            [oxes addObjectsFromArray:newOxes];
        }
    }
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
