//
//  UIView+ArrangeSubview.h
//  倒计时
//
//  Created by lei on 2016/11/15.
//  Copyright © 2016年 lei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Masonry.h"

@interface UIView (ArrangeSubview)
-(void)arrangeSubviewWithSpacingHorizontally:(NSArray*)views;
- (void)arrangeSubviewWithSpacingVertically:(NSArray*)views;
@end
