//
//  CityModel.h
//  PageControllerDemo
//
//  Created by 何发松 on 16/4/14.
//  Copyright © 2016年 HeRay. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^CityModelsHandler)(NSArray *city,NSError *error);

@interface CityModel : NSObject
@property (nonatomic,copy) NSString *province_cn;
@property (nonatomic,copy) NSString *district_cn;
@property (nonatomic,copy) NSString *name_cn;
@property (nonatomic,copy) NSString *name_en;
@property (nonatomic,copy) NSString *area_id;
+(void)getCitiesActionWithName:(NSString *)name handler:(CityModelsHandler)handler;
@end
