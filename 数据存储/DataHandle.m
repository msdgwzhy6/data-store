//
//  DataHandle.m
//  数据存储
//
//  Created by ln on 15/11/2.
//  Copyright © 2015年 ln. All rights reserved.
//

#import "DataHandle.h"
#import "FastCoder.h"

static DataHandle *handleData = nil;

@implementation DataHandle

+(DataHandle *)shareHandleData{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        handleData = [[DataHandle alloc]init];
    });
    
    return handleData;
}

-(void)storeObject:(id)value forKey:(NSString *)key{
    NSData *data = [FastCoder dataWithRootObject:value];
    if (data) {
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setObject:data forKey:key];
    }
    
}

-(id)valueWithKey:(NSString *)key{
    NSData *data = [[NSUserDefaults standardUserDefaults]valueForKey:key];
    return [FastCoder objectWithData:data];
}

-(void)storeObjectToPlist:(id)value forFileName:(NSString *)file_name{
    
  NSString *filePath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]stringByAppendingPathComponent:file_name];
    
    NSData *data = [FastCoder dataWithRootObject:value];
    if (data) {
        [data writeToFile:filePath atomically:YES];
    }
}

-(id)getDataAccordingToFileName:(NSString *)file_name{
    
    NSString *filePath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]stringByAppendingPathComponent:file_name];
    
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    return [FastCoder objectWithData:data];
}
@end
