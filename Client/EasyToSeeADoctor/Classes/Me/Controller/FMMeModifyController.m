//
//  FMMeModifyController.m
//  EasyToSeeADoctor
//
//  Created by mai on 2019/1/15.
//  Copyright © 2019 Mai. All rights reserved.
//

#import "FMMeModifyController.h"

@interface FMMeModifyController ()
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *ageField;
@property (weak, nonatomic) IBOutlet UITextField *genderField;
@property (weak, nonatomic) IBOutlet UITextField *pwdField;



@end

@implementation FMMeModifyController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"修改信息";
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)modifyConfirm:(id)sender {
    [SVProgressHUD showWithStatus:@"正在修改"];
    NSString *username = self.nameField.text;
    NSNumber *age = [NSNumber numberWithInteger:[self.ageField.text integerValue]];
    NSNumber *gender;
    if ([self.genderField.text isEqualToString:@"女"]) {
        gender = @0;
    }else{
        gender = @1;
    }
    NSString *password = self.pwdField.text;
    NSString *telephone = [[FMUserManager getManager] getUser].telephone;
    NSNumber *uid = [[FMUserManager getManager] getUser].uid;
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"uid"] = uid;
    dic[@"username"] = username;
    dic[@"password"] = password;
    dic[@"gender"] = gender;
    dic[@"age"] = age;
    dic[@"telephone"] = telephone;
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager POST:[ServerHost stringByAppendingPathComponent:@"update"] parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject[@"code"] integerValue]== 200) {
            FMUser *usr = [FMUser mj_objectWithKeyValues:responseObject[@"result"]];
            [[FMUserManager getManager] updateUser:usr];
            [SVProgressHUD showSuccessWithStatus:@"修改成功!"];
            [SVProgressHUD dismissWithDelay:1];
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [SVProgressHUD showErrorWithStatus:responseObject[@"message"]];
            [SVProgressHUD dismissWithDelay:1];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"修改失败"];
        [SVProgressHUD dismissWithDelay:1];
    }];
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
