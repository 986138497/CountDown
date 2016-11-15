//
//  ViewController.m
//  倒计时
//
//  Created by lei on 2016/11/15.
//  Copyright © 2016年 lei. All rights reserved.
//

#import "ViewController.h"
#import "CountDownViewController.h"
#import "CountDownInCellViewController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *table;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"倒计时";

    self.table.tableFooterView = [UIView new];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell==nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    if (indexPath.row==0) {
        cell.textLabel.text = @"单独的倒计时";
    }else{
        cell.textLabel.text = @"cell中倒计时";
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row==0) {
        [self.navigationController pushViewController:[CountDownViewController new] animated:YES];
    }else{
        [self.navigationController pushViewController:[CountDownInCellViewController new] animated:YES];
    }
}
-(void)dealloc{
    NSLog(@"%s dealloc",object_getClassName(self));
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
