//
//  UpdataInfo.m
//  数据存储
//
//  Created by ln on 15/11/5.
//  Copyright © 2015年 ln. All rights reserved.
//

#import "UpdataInfo.h"
#import "DataHandle.h"
@interface UpdataInfo ()<UITextFieldDelegate>

@property (nonatomic, strong) UITextField *nameT;
@property (nonatomic, strong) UITextField *subjectT;

@end

@implementation UpdataInfo

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    
    _nameT = [[UITextField alloc]initWithFrame:CGRectMake(20, 100, 100, 30)];
    _nameT.text = _teacher.t_name;
    [self.view addSubview:_nameT];
    
    _subjectT = [[UITextField alloc]initWithFrame:CGRectMake(20, 150, 100, 30)];
    _subjectT.text = _teacher.t_subject;
    [self.view addSubview:_subjectT];
    

    UIButton *editBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 200, 60, 30)];
    editBtn.center = self.view.center;
    [editBtn setTitle:@"编辑" forState:UIControlStateNormal];
    [editBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [editBtn addTarget:self action:@selector(edit) forControlEvents:UIControlEventTouchDown];
    [editBtn setBackgroundColor:[UIColor purpleColor]];
     editBtn.layer.cornerRadius = 5;
    [self.view addSubview:editBtn];
}
-(void)edit{
    NSArray *arr = [[DataHandle shareHandleData]getDataAccordingToFileName:@"handle.plist"];
    NSMutableArray *array = [NSMutableArray arrayWithArray:arr];

   //移除原数据
    [array removeObject:_teacher];
    _teacher.t_name = _nameT.text;
    _teacher.t_subject = _subjectT.text;
    _teacher.t_teacher_age = [NSString stringWithFormat:@"%d",arc4random()%20+10];
    //从字典获取数据
    
    [array addObject:_teacher];
     [[DataHandle shareHandleData]storeObjectToPlist:array forFileName:@"handle.plist"];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
       
        dispatch_async(dispatch_get_main_queue(), ^{
            [self dismissViewControllerAnimated:YES completion:nil];
        });
    });
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
