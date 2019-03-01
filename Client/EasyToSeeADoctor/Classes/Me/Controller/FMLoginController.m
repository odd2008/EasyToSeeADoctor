//
//  FMLoginController.m
//  EasyToSeeADoctor
//
//  Created by mai on 2019/1/14.
//  Copyright © 2019 Mai. All rights reserved.
//

#import "FMLoginController.h"
#import "FMRegisterController.h"


@interface FMLoginController ()
@property (weak, nonatomic) IBOutlet UITextField *telephoneFiled;

@property (weak, nonatomic) IBOutlet UITextField *pwdFiled;



@end

@implementation FMLoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)loginConfirm:(id)sender {
    [SVProgressHUD showWithStatus:@"正在登录"];
    NSString *telephone = self.telephoneFiled.text;
    NSString *password = self.pwdFiled.text;
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"telephone"] = telephone;
    dic[@"password"] = password;
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager POST:[ServerHost stringByAppendingPathComponent:@"/login"] parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject[@"code"] integerValue]== 200) {
            FMUser *usr = [FMUser mj_objectWithKeyValues:responseObject[@"result"]];
            [[FMUserManager getManager] updateUser:usr];
            [[NSNotificationCenter defaultCenter] postNotificationName:UserDidLoginNotification object:nil];
            [SVProgressHUD showSuccessWithStatus:@"登录成功!"];
            [SVProgressHUD dismissWithDelay:1];
        }else{
            [SVProgressHUD showErrorWithStatus:responseObject[@"message"]];
            [SVProgressHUD dismissWithDelay:1];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"登录失败"];
        [SVProgressHUD dismissWithDelay:1];
    }];
    
   
    
}

- (IBAction)registerConfirm:(id)sender {
    FMRegisterController *registerCV = [[FMRegisterController alloc] init];
    [self presentViewController:registerCV animated:YES completion:nil];
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
