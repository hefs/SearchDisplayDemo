//
//  Constants.h
//  PageControllerDemo
//
//  Created by 何发松 on 16/3/29.
//  Copyright © 2016年 HeRay. All rights reserved.
//

#ifndef Constants_h
#define Constants_h

#ifdef DEBUG

#if defined (MACROS)
#define API_BASE_URL @"192.168.1.12:8080"
#else
#define API_BASE_URL @"192.168.1.36:8080"
#endif

#else

#define API_BASE_URL @"192.168.1.24:8080"

#endif

//#define NNLOG(str) #ifdef DEBUG ##NSLog(@"%@",str);

#endif /* Constants_h */
