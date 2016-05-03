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
- (IBAction)didCheckValidate:(UITextField *)sender;
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

- (IBAction)didCheckValidate:(UITextField *)sender {
    NSLog(@"%@",[self isPwdValidate:@[[NSCharacterSet uppercaseLetterCharacterSet],[NSCharacterSet lowercaseLetterCharacterSet],[NSCharacterSet characterSetWithCharactersInString:@"1234567890"]] minLength:6 maxLength:16 pwd:sender.text containSymbols:YES]);

}

- (NSString *)isPwdValidate:(NSArray<NSCharacterSet *> *)characterSets minLength:(NSInteger)min maxLength:(NSInteger)max pwd:(NSString *)pwd containSymbols:(BOOL)flag
{
    if (pwd.length >16 || pwd.length < 6) {
        return @"密码必须包含6至16个字符";
    }
    NSString *tmpPwd = pwd;
    NSMutableArray *results = [NSMutableArray arrayWithCapacity:0];
//    [results valueForKeyPath:<#(nonnull NSString *)#>];
    NSInteger count = flag ? characterSets.count + 1 : characterSets.count;
    for (int i = 0; i < count; i++) {
        NSCharacterSet *set = nil;
        if (i < characterSets.count) {
            set = characterSets[i];
        }
        NSArray *array = [self analyseString:tmpPwd character:set];
        if ([[array firstObject] count]) {
            [results addObject:[array firstObject]];
        }
        if (array.count == 2) {
            tmpPwd = [tmpPwd stringByTrimmingCharactersInSet:array[1]];
        }
    }
    if (tmpPwd.length && !flag){
        return  @"密码不能包含特殊字符";
    }
    if (results.count < 2) {
        return @"密码必须至少包含大写字母、小写字母、数字、特殊字符中的两种";
    }
    return @"ok";
}

- (NSArray *)analyseString:(NSString *)input character:(NSCharacterSet *)set{
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:0];
    NSMutableCharacterSet *tmpSet = nil;
    for (int i = 0; i < input.length; i++) {
        NSString *str = [input substringWithRange:NSMakeRange(i, 1)];
        if (set) {
            NSRange range = [str rangeOfCharacterFromSet:set];
            if (range.location != NSNotFound) {
                [array addObject:str];
                if (tmpSet == nil) {
                    tmpSet = [NSMutableCharacterSet new];
                }
                [tmpSet addCharactersInString:str];
            }
        }else{
            [array addObject:str];
        }
    }
    if (!tmpSet) {
        return @[array];
    }
    return @[array,tmpSet];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    NSString *clang = [UIApplication sharedApplication].textInputMode.primaryLanguage;
//    if ([clang isEqualToString:@"en_US"]) {
//        <#statements#>
//    }
    NSLog(@"current input %@",clang);
    return [clang containsString:@"en"];
}

@end
