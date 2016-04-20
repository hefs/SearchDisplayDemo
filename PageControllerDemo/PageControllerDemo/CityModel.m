//
//  CityModel.m
//  PageControllerDemo
//
//  Created by 何发松 on 16/4/14.
//  Copyright © 2016年 HeRay. All rights reserved.
//

#import "CityModel.h"

@implementation CityModel

+(void)getCitiesActionWithName:(NSString *)name handler:(CityModelsHandler)handler{
    NSString *remote = @"http://apis.baidu.com/apistore/weatherservice/citylist";
    NSURL *url = [NSURL URLWithString:[[remote stringByAppendingFormat:@"?cityname=%@",name] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request addValue:@"b7148a2facd0c2a6aff8cfda6a7a1645" forHTTPHeaderField:@"apikey"];
    [request addValue:name forHTTPHeaderField:@"cityname"];
    [request setHTTPMethod:@"GET"];
    
    
//    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response,NSData *responseData,NSError *error){
//        
//        if (error) {
//            handler(nil,error);
//        }else{
//            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableLeaves error:nil];
//            NSArray *cities = [dict objectForKey:@"retData"];
//            NSMutableArray *models = [NSMutableArray arrayWithCapacity:0];
//            for (NSDictionary *obj in cities) {
//                CityModel *model = [CityModel new];
//                model.province_cn = [obj objectForKey:@"province_cn"];
//                model.district_cn = [obj objectForKey:@"district_cn"];
//                model.name_cn = [obj objectForKey:@"name_cn"];
//                model.name_en = [obj objectForKey:@"name_en"];
//                model.area_id = [obj objectForKey:@"area_id"];
//                [models addObject:model];
//            }
//            handler(models,nil);
//        }
//
//    }];
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData *responseData,NSURLResponse *response,NSError *error){
        if (error) {
            handler(nil,error);
        }else{
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableLeaves error:nil];
            NSArray *cities = [dict objectForKey:@"retData"];
            NSMutableArray *models = [NSMutableArray arrayWithCapacity:0];
            for (NSDictionary *obj in cities) {
                CityModel *model = [CityModel new];
                model.province_cn = [obj objectForKey:@"province_cn"];
                model.district_cn = [obj objectForKey:@"district_cn"];
                model.name_cn = [obj objectForKey:@"name_cn"];
                model.name_en = [obj objectForKey:@"name_en"];
                model.area_id = [obj objectForKey:@"area_id"];
                [models addObject:model];
            }
            handler(models,nil);
        }
    }];
    //执行请求，必须调用
    [task resume];
}
@end
