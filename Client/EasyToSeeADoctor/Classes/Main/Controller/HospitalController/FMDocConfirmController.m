//
//  FMDocConfirmController.m
//  EasyToSeeADoctor
//
//  Created by mai on 2019/1/15.
//  Copyright © 2019 Mai. All rights reserved.
//

#import "FMDocConfirmController.h"
#import <Masonry.h>

@interface FMDocConfirmController ()<UIPickerViewDelegate, UIPickerViewDataSource>
@property (weak, nonatomic) IBOutlet UITextField *personName;
@property (weak, nonatomic) IBOutlet UITextField *personTele;
@property (weak, nonatomic) IBOutlet UITextField *timeField;
@property (weak, nonatomic) IBOutlet UITextField *personIdField;
@property (weak, nonatomic) IBOutlet UITextView *personDes;

@property (assign, nonatomic) NSInteger index;


@end

@implementation FMDocConfirmController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"填写挂号信息";
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)timeChose:(id)sender {
    UIPickerView *picker = [UIPickerView new];
    picker.delegate = self;
    picker.dataSource = self;
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"请选择挂号日期\n\n\n\n\n\n\n\n\n\n" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [alert.view addSubview:picker];
    [picker mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(alert.view);
        make.top.equalTo(alert.view.mas_top).offset(2);
    }];
    
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        self.timeField.text = [self.timeArr objectAtIndex:self.index];
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:ok];
    [alert addAction:cancel];
    [self presentViewController:alert animated:YES completion:nil];
    
}

- (IBAction)appConfirm:(id)sender {
    [SVProgressHUD showWithStatus:@"预约中"];
    
    NSRange range = NSMakeRange([[self.indexArr objectAtIndex:self.index] integerValue], 2);
    NSUInteger num = [[self.work_time substringWithRange:range] integerValue];
    num = num - 1;
    NSString *replaceString;
    if (num < 0) {
        replaceString = [NSString stringWithFormat:@"0%ld",num];
    }else{
        replaceString = [NSString stringWithFormat:@"%ld",num];
    }
    self.work_time = [self.work_time stringByReplacingCharactersInRange:range withString:replaceString];
    __weak typeof (self) weakSelf = self;
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"uid"] = [[FMUserManager getManager] getUser].uid;
    dic[@"person_name"] = self.personName.text;
    dic[@"time"] = self.timeField.text;
    dic[@"doctor"] = self.d_name;
    dic[@"hospital"] = self.h_name;
    dic[@"telephone"] = self.personTele.text;
    dic[@"person_id"] = self.personIdField.text;
    dic[@"person_des"] = self.personDes.text;
    dic[@"did"] = self.did;
    dic[@"work_time"] = self.work_time;
    dic[@"money"] = self.money;
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager POST:[ServerHost stringByAppendingPathComponent:@"/addrecord"] parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject[@"code"] integerValue]== 200) {
            FMUser *usr = [FMUser mj_objectWithKeyValues:responseObject[@"result"]];
            [[FMUserManager getManager] updateUser:usr];
            UIViewController *viewCtl = weakSelf.navigationController.viewControllers[0];
            [weakSelf.navigationController popToViewController:viewCtl animated:YES];
            [SVProgressHUD showSuccessWithStatus:@"挂号成功!"];
            [SVProgressHUD dismissWithDelay:1];
        }else{
            [SVProgressHUD showErrorWithStatus:@"余额不足,请充值"];
            [SVProgressHUD dismissWithDelay:1];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"挂号失败"];
        [SVProgressHUD dismissWithDelay:1];
    }];
}

#pragma mark - UIPickerView
- (NSInteger)numberOfComponentsInPickerView:(nonnull UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(nonnull UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.timeArr.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [self.timeArr objectAtIndex:row];
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
