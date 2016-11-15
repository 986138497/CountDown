//
//  CountDownInCellViewController.m
//  倒计时
//
//  Created by lei on 2016/11/15.
//  Copyright © 2016年 lei. All rights reserved.
//

#import "CountDownInCellViewController.h"
#import "CountDown.h"
#import "CountDownCell.h"

@interface CountDownInCellViewController ()<UITableViewDelegate,UITableViewDataSource>{
    NSArray *dataSource;//时间数组
}
@property (weak, nonatomic) IBOutlet UITableView *table;
@property (strong, nonatomic)  CountDown *countDown;

@end

@implementation CountDownInCellViewController
-(void)updateTimeInVisibleCells{
    NSArray  *cells = self.table.visibleCells; //取出屏幕可见ceLl
    for (CountDownCell *cell in cells) {
        cell.countDownLabel.text = [self getNowTimeWithString:dataSource[cell.tag]];
        if ([cell.countDownLabel.text isEqualToString:@"活动已经结束！"]) {
            cell.countDownLabel.textColor = [UIColor redColor];
        }else{
            cell.countDownLabel.textColor = [UIColor orangeColor];
        }
    }
}
-(NSString *)getNowTimeWithString:(NSString *)aTimeString{
    NSDateFormatter* formater = [[NSDateFormatter alloc] init];
    [formater setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    // 截止时间date格式
    NSDate  *expireDate = [formater dateFromString:aTimeString];
    NSDate  *nowDate = [NSDate date];
    // 当前时间字符串格式
    NSString *nowDateStr = [formater stringFromDate:nowDate];
    // 当前时间date格式
    nowDate = [formater dateFromString:nowDateStr];
  
    NSTimeInterval timeInterval =[expireDate timeIntervalSinceDate:nowDate];
    
    int days = (int)(timeInterval/(3600*24));
    int hours = (int)((timeInterval-days*24*3600)/3600);
    int minutes = (int)(timeInterval-days*24*3600-hours*3600)/60;
    int seconds = timeInterval-days*24*3600-hours*3600-minutes*60;
    
    NSString *dayStr;NSString *hoursStr;NSString *minutesStr;NSString *secondsStr;
    //天
    dayStr = [NSString stringWithFormat:@"%d",days];
    //小时
    hoursStr = [NSString stringWithFormat:@"%d",hours];
   //分钟
    if(minutes<10)
        minutesStr = [NSString stringWithFormat:@"0%d",minutes];
    else
        minutesStr = [NSString stringWithFormat:@"%d",minutes];
    //秒
    if(seconds < 10)
        secondsStr = [NSString stringWithFormat:@"0%d", seconds];
    else
        secondsStr = [NSString stringWithFormat:@"%d",seconds];
    if (hours<=0&&minutes<=0&&seconds<=0) {
        return @"活动已经结束！";
    }
    if (days) {
        return [NSString stringWithFormat:@"%@天 %@小时 %@分 %@秒", dayStr,hoursStr, minutesStr,secondsStr];
    }
    return [NSString stringWithFormat:@"%@小时 %@分 %@秒",hoursStr , minutesStr,secondsStr];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"cell中倒计时";
    dataSource = @[@"2016-10-24 22:23:49",@"2016-10-25 14:23:43",@"2016-10-26 14:23:14",@"2016-10-27 14:23:41",@"2016-10-28 14:11:46",@"2016-10-29 14:23:23",@"2016-10-30 14:23:43",@"2016-11-01 14:12:45",@"2016-11-02 14:23:22",@"2016-11-03 14:23:40",@"2016-11-04 14:13:40",@"2016-11-05 14:23:45",@"2016-11-06 14:23:45",@"2016-11-07 14:14:41",@"2016-11-08 14:23:50",@"2016-11-09 14:23:45",@"2016-11-10 14:15:42",@"2016-11-11 14:23:51",@"2016-11-12 14:28:45",@"2016-11-13 14:16:43",@"2016-11-14 14:23:52",@"2016-11-15 14:29:45",@"2016-11-16 14:17:44",@"2016-11-17 14:23:53",@"2016-11-18 14:30:45",@"2016-11-19 14:18:45",@"2016-11-20 14:23:54",@"2016-11-21 14:31:01",@"2016-11-22 14:19:30",@"2016-11-23 14:23:55",@"2016-11-24 14:32:02",@"2016-11-25 14:20:31",@"2016-11-26 14:23:56",@"2016-11-27 14:33:03",@"2016-11-28 14:21:12",@"2016-11-29 14:23:45",@"2016-11-30 14:34:04",@"2016-11-31 14:23:32",@"2016-11-01 14:23:49",@"2016-11-02 14:04:05",@"2016-12-03 14:23:05",@"2016-12-04 14:24:09",@"2016-12-05 14:14:06",@"2016-12-06 14:24:02",@"2016-12-07 14:24:10",@"2016-12-08 14:24:07",@"2016-12-09 14:25:01",@"2016-12-10 14:24:11",@"2016-12-11 14:34:08",@"2016-12-12 14:26:03",];
    self.countDown = [[CountDown alloc] init];
    __weak __typeof(self) weakSelf= self;
    ///每秒回调一次
    [self.countDown countDownWithPER_SECBlock:^{
        NSLog(@"6");
        [weakSelf updateTimeInVisibleCells];
    }];
    [_table registerNib:[UINib nibWithNibName:@"CountDownCell" bundle:nil] forCellReuseIdentifier:@"CountDownCell"];
    _table.tableFooterView = [UIView new];//去除table下面多余的分割线
    _table.rowHeight = 100;//固定行高最好用这个属性，提高效率，不用走代理方法询问每个row多高
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return dataSource.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CountDownCell *cell = (CountDownCell *)[tableView dequeueReusableCellWithIdentifier:@"CountDownCell"];
    cell.timeLabel.text = [NSString stringWithFormat:@"活动 %@ 结束",dataSource[indexPath.row]];
    cell.timeLabel.adjustsFontSizeToFitWidth = YES;
    cell.countDownLabel.text = [self getNowTimeWithString:dataSource[indexPath.row]];
    if ([cell.countDownLabel.text isEqualToString:@"活动已经结束！"]) {
        cell.countDownLabel.textColor = [UIColor redColor];
    }else{
        cell.countDownLabel.textColor = [UIColor orangeColor];
    }
    cell.tag = indexPath.row;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
-(void)dealloc{
    NSLog(@"%s dealloc",object_getClassName(self));
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
/**
 * 根据传入的年份和月份获得该月份的天数
 *
 * @param year
 *            年份-正整数
 * @param month
 *            月份-正整数
 * @return 返回天数
 */
-(NSInteger)getDayNumberWithYear:(NSInteger )y month:(NSInteger )m{
    int days[] = { 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 };
    if (2 == m && 0 == (y % 4) && (0 != (y % 100) || 0 == (y % 400))) {
        days[1] = 29;
    }
    return (days[m - 1]);
}
@end
