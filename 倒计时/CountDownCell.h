//
//  CountDownCell.h
//  倒计时
//
//  Created by lei on 2016/11/15.
//  Copyright © 2016年 lei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CountDownCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *titleIV;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *countDownLabel;

@end
