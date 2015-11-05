//
//  ViewController.m
//  数据存储
//
//  Created by ln on 15/11/2.
//  Copyright © 2015年 ln. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"
#import "Teacher.h"
#import "DataHandle.h"
#import "UpdataInfo.h"
@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *listTableView;
@property (nonatomic, strong) NSMutableArray *resourceData;
@end

@implementation ViewController


-(NSMutableArray *)resourceData{
    
    if (!_resourceData) {
        _resourceData = [NSMutableArray array];
    }
    return _resourceData;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    /**
     归档NSKeyedArchiver
     */
   
    
    Person *p = [[Person alloc]init];
    p.name = @"我是一个对象";
    p.age = @"这个对象今年18岁";
    
    Person *ppp = [[Person alloc]init];
    ppp.name = @"一个对象";
    ppp.age = @"这个对象今年20岁";
    NSArray *pArr = @[p,ppp,p];
    
    NSString *ppath = [NSTemporaryDirectory() stringByAppendingPathComponent:@"person.txt"];
    NSLog(@"文件路径 --- %@",ppath);
    [NSKeyedArchiver archiveRootObject:pArr toFile:ppath];
    NSArray *a = [NSKeyedUnarchiver unarchiveObjectWithFile:ppath];
    NSLog(@"a 数组是 %@",a);
    
    NSString *path = [NSTemporaryDirectory() stringByAppendingPathComponent:@"person.data"];
    
    [NSKeyedArchiver archiveRootObject:p toFile:path];
    
    NSLog(@"文件地址----%@",path);
    
    Person *p2 = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    NSLog(@"当前的用户名 %@ 年龄 = %@",p2.name,p2.age);
    [p save];
    Person *returnP = [Person read];
    NSLog(@"当前的用户名 %@ 年龄 = %@",returnP.name,returnP.age);
    
 
//    [self handelData];
    
    [self initListTableView];
    [self loadResourceData];
}
#pragma mark 数据处理
-(void)handelData{
    /**
     NSUserDefaults的使用
     */
        Teacher *teacher1 = [[Teacher alloc]init];
        teacher1.t_name = @"张帮群";
        teacher1.t_teacher_age = @"45";
        teacher1.t_subject = @"语文";
    
    
        Teacher *teacher2 = [[Teacher alloc]init];
        teacher2.t_name = @"李英飞";
        teacher2.t_teacher_age = @"15";
        teacher2.t_subject = @"英语";
    
        Teacher *teacher3 = [[Teacher alloc]init];
        teacher3.t_name = @"林鹏飞";
        teacher3.t_teacher_age = @"32";
        teacher3.t_subject = @"数学";
    
        Teacher *teacher4 = [[Teacher alloc]init];
        teacher4.t_name = @"张朝阳";
        teacher4.t_teacher_age = @"5";
        teacher4.t_subject = @"科学";
    
        Teacher *teacher5 = [[Teacher alloc]init];
        teacher5.t_name = @"苏文萍";
        teacher5.t_teacher_age = @"22";
        teacher5.t_subject = @"自然";
    
    
        Teacher *teacher6 = [[Teacher alloc]init];
        teacher6.t_name = @"欧阳文雅";
        teacher6.t_teacher_age = @"2";
        teacher6.t_subject = @"辅导员";
    
    
        NSArray *personArray = @[teacher1,teacher2,teacher3,teacher4,teacher5,teacher6];
    
        [[DataHandle shareHandleData] storeObject:personArray forKey:@"数据处理"];
    
        NSArray *arrayR = [[DataHandle shareHandleData]valueWithKey:@"数据处理"];
    
        NSLog(@"返回的数组 ====== %@",arrayR);
    
    
    
        //存储数据到字典
        [[DataHandle shareHandleData]storeObjectToPlist:personArray forFileName:@"handle.plist"];
        //从字典获取数据
        NSArray *arr = [[DataHandle shareHandleData]getDataAccordingToFileName:@"handle.plist"];
    
        _resourceData = [NSMutableArray arrayWithArray:arr];
        /**
         *  plist文件的使用
         *
         */
        NSString *filePath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]stringByAppendingPathComponent:@"data.plist"];
        NSArray *array = @[@"逗逼二人组",@"黄蓉妹妹",@"靖哥哥"];
        [array writeToFile:filePath atomically:YES];
        
        NSArray *returnArray = [NSArray arrayWithContentsOfFile:filePath];
        NSLog(@"返回的数据== %@",returnArray);
}
-(void)initListTableView{
    _listTableView = [[UITableView alloc]initWithFrame:self.view.frame];
    _listTableView.delegate = self;
    _listTableView.dataSource = self;
    [self.view addSubview:_listTableView];

}
-(void)loadResourceData{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        

        NSArray *arr = [[DataHandle shareHandleData]getDataAccordingToFileName:@"handle.plist"];
        NSLog(@"返回的数组元素 -- %@",arr);
        _resourceData = [NSMutableArray arrayWithArray:arr];;
        dispatch_async(dispatch_get_main_queue(), ^{
            [_listTableView reloadData];
        });
    });
}
#pragma mark UITableView

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _resourceData.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   static NSString *idCell = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:idCell];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:idCell];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    Teacher *teacher = _resourceData[indexPath.row];
    cell.textLabel.text = teacher.t_name;
    cell.detailTextLabel.text = teacher.t_subject;
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    Teacher *teacher = [_resourceData objectAtIndex:indexPath.row];
    UpdataInfo *updateVC = [[UpdataInfo alloc]init];
    updateVC.teacher = teacher;
    [self presentViewController:updateVC animated:YES completion:nil];
}

-(void)viewWillAppear:(BOOL)animated{
    [self loadResourceData];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
