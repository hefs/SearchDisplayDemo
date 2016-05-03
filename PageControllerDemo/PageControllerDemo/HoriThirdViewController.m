//
//  HoriThirdViewController.m
//  PageControllerDemo
//
//  Created by 何发松 on 16/3/28.
//  Copyright © 2016年 HeRay. All rights reserved.
//

#import "HoriThirdViewController.h"
#import "ChineseToPinyin.h"

@interface OxModel : NSObject
@property (nonatomic) NSInteger age;
@end

@interface ManModel : NSObject
@property (nonatomic) NSString *name;
@end

@implementation ManModel

@end

@interface HoriThirdViewController (){
    NSMutableArray *oxes;
    NSMutableArray *mans;
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
    mans = [[NSMutableArray alloc] initWithCapacity:0];
    NSArray *names = @[@"何发松",@"合法",@"高高",@"何发",@"阳春"];
    for (NSString *str in names) {
        ManModel *man = [ManModel new];
        man.name = str;
        [mans addObject:man];
    }
//    [mans sortedArrayUsingComparator:^NSComparisonResult(ManModel *obj1,ManModel *obj2){
//        NSString *name1 = [ChineseToPinyin pinyinFromChineseString:obj1.name];
//        NSString *name2 = [ChineseToPinyin pinyinFromChineseString:obj2.name];
//        NSComparisonResult result = [name1 compare:name2 options:NSCaseInsensitiveSearch];
//        return result;
//    }];
    [self  sortedArry:mans];
//    NSLog(@"%@",[names sortedArrayUsingComparator:^NSComparisonResult(NSString *str1,NSString *str2){
//        return [str1 compare:str2];
//    }]);
}

- (void)sortedArry:(NSMutableArray *)sender{
    for (int i = 0; i < sender.count; i++) {
        for (int j = 1; j < sender.count - 1; j++) {
            ManModel *obj2 = sender[j];
            ManModel *obj1 = sender[j - 1];
            NSString *name1 = [ChineseToPinyin pinyinFromChineseString:obj1.name];
            NSString *name2 = [ChineseToPinyin pinyinFromChineseString:obj2.name];
            NSComparisonResult result = [name1 compare:name2 options:NSCaseInsensitiveSearch];
            if (result == NSOrderedDescending) {
                [sender exchangeObjectAtIndex:j withObjectAtIndex:j - 1];
            }
        }
    }
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
