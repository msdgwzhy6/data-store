//
//  DataHandle.h
//  数据存储
//
//  Created by ln on 15/11/2.
//  Copyright © 2015年 ln. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataHandle : NSObject
/**
 *  创建单例
 *
 *  @return 返回一个单例对象
 */
+(DataHandle*)shareHandleData;

/**
 *  使用FastCoder 存储一个对象
 *
 *  @param value 需要存储的对象
 *  @param key   键
 */
-(void)storeObject:(id)value forKey:(NSString*)key;


/**
 *  使用FastCoder返回一个对象
 *
 *  @param key 键
 *
 *  @return 返回的对象
 */
-(id)valueWithKey:(NSString*)key;

/**
 *  存储数据到plist文件中
 *
 *  @param value     需要存储的数据
 *  @param file_name 存储的文件路径名
 */
-(void)storeObjectToPlist:(id)value forFileName:(NSString*)file_name;

/**
 *  根据文件名获取数据
 *
 *  @param file_name 数据存储的文件名
 *
 *  @return 返回的数据
 */
-(id)getDataAccordingToFileName:(NSString*)file_name;

@end
