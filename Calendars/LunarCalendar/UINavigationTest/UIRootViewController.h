//
//  UIRootViewController.h
//  UINavigationTest
//
//  Created by mac on 13-9-2.
//  Copyright (c) 2013年 caobo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIRootViewController : UIViewController<UIPickerViewDelegate,UIPickerViewDataSource>
//选取器得数据源，和委托

@property(nonatomic, retain) UIPickerView  *pickerView;
@property(retain, nonatomic) UIView *titleView;

@end
