//
//  Person.h
//  数据存储
//
//  Created by ln on 15/11/2.
//  Copyright © 2015年 ln. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject<NSCoding>

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *age;

/**
 *  利用NSUserDefaults存储
 */
-(void)save;


/**
 *  从NSUserDefaults返回值
 *
 *  @return 返回一个对象
 */
+(Person*)read;






@end
