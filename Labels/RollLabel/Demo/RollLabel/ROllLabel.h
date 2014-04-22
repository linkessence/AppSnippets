//
//  ROllLabel.h
//  RollLabel
//
//  Created by zhouxl on 12-11-2.
//  Copyright (c) 2012年 zhouxl. All rights reserved.
//


#import <UIKit/UIKit.h>
#define kConstrainedSize CGSizeMake(10000,40)//字体最大
@interface ROllLabel : UIScrollView
/*title,要显示的文字
 *color,文字颜色
 *font , 字体大小
 *superView,要加载标签的视图
 *rect ,标签的frame
 */
+ (void)rollLabelTitle:(NSString *)title color:(UIColor *)color font:(UIFont *)font superView:(UIView *)superView fram:(CGRect)rect;
@end
