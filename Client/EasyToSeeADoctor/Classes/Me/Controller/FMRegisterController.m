//
//  FMRegisterController.m
//  EasyToSeeADoctor
//
//  Created by mai on 2019/1/14.
//  Copyright © 2019 Mai. All rights reserved.
//

#import "FMRegisterController.h"

@interface FMRegisterController ()
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *telephoneField;
@property (weak, nonatomic) IBOutlet UITextField *pwdField;


@end

@implementation FMRegisterController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)cancelConfirm:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)registerConfirm:(id)sender {
    [SVProgressHUD showWithStatus:@"正在注册"];
    NSString *username = self.nameField.text;
    NSString *password = self.pwdField.text;
    NSString *telephone = self.telephoneField.text;
    __weak typeof (self) weakSelf = self;
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"username"] = username;
    dic[@"password"] = password;
    dic[@"telephone"] = telephone;
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager POST:[ServerHost stringByAppendingPathComponent:@"adduser"] parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject[@"code"] integerValue]== 200) {
            FMUser *usr = [FMUser mj_objectWithKeyValues:responseObject[@"result"]];
            [[FMUserManager getManager] updateUser:usr];
            [SVProgressHUD showSuccessWithStatus:@"注册成功!"];
            [SVProgressHUD dismissWithDelay:1];
            [weakSelf dismissViewControllerAnimated:YES completion:nil];
        }else{
            [SVProgressHUD showErrorWithStatus:responseObject[@"message"]];
            [SVProgressHUD dismissWithDelay:1];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"注册失败"];
        [SVProgressHUD dismissWithDelay:1];
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
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
