//
//  FMMeController.m
//  EasyToSeeADoctor
//
//  Created by mai on 2019/1/14.
//  Copyright © 2019 Mai. All rights reserved.
//

#import "FMMeController.h"
#import "FMMeModifyController.h"
#import <Masonry.h>

@interface FMMeController ()<UIPickerViewDelegate, UIPickerViewDataSource>
@property (weak, nonatomic) IBOutlet UILabel *telephoneNum;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *gender;
@property (weak, nonatomic) IBOutlet UILabel *userAge;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;

@property (nonatomic, strong) NSArray *moneyArr;
@property (nonatomic, assign) NSInteger index;

@end

@implementation FMMeController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我的";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(editInfomation)];
//    [self freshInfo];
    self.moneyArr = @[@"10",@"50",@"100",@"50",@"1000"];
}

- (void)editInfomation{
    FMMeModifyController *modify = [[FMMeModifyController alloc] init];
    [self.navigationController pushViewController:modify animated:YES];
}

- (void)freshInfo{
    FMUser *user = [[FMUserManager getManager] getUser];
    self.telephoneNum.text = user.telephone;
    self.userName.text = user.username;
    if (user.gender == nil) {
        self.gender.text = @"未设置";
    }else if ([user.gender isEqualToNumber:@0]) {
        self.gender.text = @"女";
    }else{
        self.gender.text = @"男";
    }
    if (user.age == nil) {
        self.userAge.text = @"未设置";
    }else{
        self.userAge.text = [NSString stringWithFormat:@"%@",user.age];
    }
    self.moneyLabel.text = [NSString stringWithFormat:@"%@元",user.money];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self freshInfo];
}
- (IBAction)logOutConfirm:(id)sender {
    [[NSNotificationCenter defaultCenter]postNotificationName:UserDidLogoutNotification object:nil];
}

- (IBAction)moneyConfirm:(id)sender {
    UIPickerView *picker = [UIPickerView new];
    picker.delegate = self;
    picker.dataSource = self;
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"请选择充值金额\n\n\n\n\n\n\n\n\n\n" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [alert.view addSubview:picker];
    [picker mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(alert.view);
        make.top.equalTo(alert.view.mas_top).offset(2);
    }];
    __weak typeof (self) weakSelf = self;
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [SVProgressHUD showWithStatus:@"正在充值"];
        NSNumber *money = [NSNumber numberWithInteger:[[weakSelf.moneyArr objectAtIndex:weakSelf.index] integerValue]];
        FMUser *user = [[FMUserManager getManager] getUser];
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        dic[@"money"] = money;
        dic[@"uid"] = user.uid;
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        [manager POST:[ServerHost stringByAppendingPathComponent:@"addmoney"] parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if ([responseObject[@"code"] integerValue]== 200) {
                FMUser *usr = [FMUser mj_objectWithKeyValues:responseObject[@"result"]];
                [[FMUserManager getManager] updateUser:usr];
                [weakSelf freshInfo];
                [SVProgressHUD showSuccessWithStatus:@"充值成功!"];
                [SVProgressHUD dismissWithDelay:1];
            }else{
                [SVProgressHUD showErrorWithStatus:responseObject[@"message"]];
                [SVProgressHUD dismissWithDelay:1];
            }
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [SVProgressHUD showErrorWithStatus:@"充值失败"];
            [SVProgressHUD dismissWithDelay:1];
        }];
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:ok];
    [alert addAction:cancel];
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - UIPickerView
- (NSInteger)numberOfComponentsInPickerView:(nonnull UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(nonnull UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.moneyArr.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [self.moneyArr objectAtIndex:row];
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    self.index = (int)row;
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
