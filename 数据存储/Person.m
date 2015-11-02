//
//  Person.m
//  数据存储
//
//  Created by ln on 15/11/2.
//  Copyright © 2015年 ln. All rights reserved.
//

#import "Person.h"


@implementation Person

-(instancetype)init{
    self = [super init];
    if (self) {
        self.name = _name;
        self.age = _age;
    }

    return self;
}
/**
 *  当一个对象需要归档的时候会被调用
 *
 *  @param aCoder  一个需要归档的对象
 */
-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:_name forKey:USER_NAMR];
    [aCoder encodeObject:_age forKey:USER_AGE];
}
/**
 *  当前对象有哪些属性需要解档，对象需要解档的时候调用
 *
 *  @param aDecoder 一个解档对象
 *
 *  @return 返回对象
 */
-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    _name = [aDecoder decodeObjectForKey:USER_NAMR];
    _age = [aDecoder decodeObjectForKey:USER_AGE];
    
    return self;
}
/**
 *  利用NSUserDefaults,就能直接访问软件的偏好设置(Library/Preferences)
 */
-(void)save{
    NSUserDefaults *setting = [NSUserDefaults standardUserDefaults];
    [setting setObject:_name forKey:USER_NAMR];
    [setting setObject:_age forKey:USER_AGE];
    //同步
    [setting synchronize];
}

+(Person*)read{
    
    NSUserDefaults *setting = [NSUserDefaults standardUserDefaults];
    Person *p = [[Person alloc]init];
    p.name = [setting objectForKey:USER_NAMR];
    p.age = [setting objectForKey:USER_AGE];
    
    return p;
}


@end
