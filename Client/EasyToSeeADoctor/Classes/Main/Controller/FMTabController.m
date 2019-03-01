//
//  FMTabController.m
//  EasyToSeeADoctor
//
//  Created by mai on 2019/1/14.
//  Copyright © 2019 Mai. All rights reserved.
//

#import "FMTabController.h"
#define FMHEXColor(hex) [UIColor colorWithRed:((hex & 0xFF0000) >> 16)/255.0 green:((hex & 0xFF00) >> 8)/255.0 blue:(hex & 0xFF)/255.0 alpha:1]

@interface FMTabController ()

@end

@implementation FMTabController

+(void)load{
    //设置当前类包含的所有UITabBarItem属性
    //遵守UIAppearance协议的类可以用appearence这个方法
    //被UI_APPEARANCE_SELECTOR宏修饰的属性可以修改
    //只能在控件显示前设置(可设置后remove控件再add
    
    UITabBarItem *item=[UITabBarItem appearanceWhenContainedIn:self, nil];
    //    NSMutableDictionary *attrs=[NSMutableDictionary dictionary];
    //    attrs[NSForegroundColorAttributeName]=[UIColor blackColor];
    //    [item setTitleTextAttributes:attrs forState:UIControlStateSelected];
    //字体要在正常状态下设置才有效
    NSMutableDictionary *attrsNor=[NSMutableDictionary dictionary];
    attrsNor[NSFontAttributeName]=[UIFont systemFontOfSize:13];
    [item setTitleTextAttributes:attrsNor forState:UIControlStateNormal];
    
}





- (void)viewDidLoad {
    [super viewDidLoad];
    //    [self.tabBar setBackgroundImage:[UIImage imageNamed:@"tabBarBackground"]];
    [self.tabBar setTintColor:FMHEXColor(0x64B97F)];//按钮和标题颜色
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
