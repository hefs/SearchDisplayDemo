//
//  HoriFirstViewController.m
//  PageControllerDemo
//
//  Created by 何发松 on 16/3/28.
//  Copyright © 2016年 HeRay. All rights reserved.
//

#import "HoriFirstViewController.h"
#import "Constants.h"

@interface HoriFirstViewController ()<UITextFieldDelegate>
@property (nonatomic,weak) IBOutlet UITextField *txt;
@end

@implementation HoriFirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    NSLog(@"api url : %@",API_BASE_URL);
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
