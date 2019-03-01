//
//  FMFuntionController.m
//  EasyToSeeADoctor
//
//  Created by mai on 2019/1/14.
//  Copyright © 2019 Mai. All rights reserved.
//

#import "FMFuntionController.h"
#import "FMFunCell.h"
#import "FMOfficeDetailController.h"

@interface FMFuntionController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *officeArray;
@property (nonatomic, strong) NSArray *officeDetailArray;

@end

@implementation FMFuntionController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"预约挂号";
//    NSLog(@"%f,%f",[UIApplication sharedApplication].statusBarFrame.size.height,self.navigationController.navigationBar.frame.size.height);
    [self setOffice];
    [self setCollectView];

    // Do any additional setup after loading the view from its nib.
}

- (void)setCollectView{
    UICollectionViewFlowLayout *collectionViewLayout = [[UICollectionViewFlowLayout alloc] init];
    CGFloat itemWandH = (self.view.bounds.size.width - 3*2) / 4;
    collectionViewLayout.itemSize = CGSizeMake(itemWandH, 60);
    collectionViewLayout.minimumLineSpacing = 0;
    collectionViewLayout.minimumInteritemSpacing = 0;
    collectionViewLayout.sectionInset = UIEdgeInsetsMake(2, 2, 0, 2);
    [self.collectionView setCollectionViewLayout:collectionViewLayout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerNib:[UINib nibWithNibName:@"FMFunCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"FMFunCell"];
}
- (void)setOffice{
    self.officeArray = @[@"内科",@"外科",@"妇产科",@"生殖中心",@"儿科",@"骨外科",@"眼科",@"口腔科",@"耳耳鼻咽喉科",@"肿瘤科",@"皮肤性病科",@"男性学科",@"皮肤美容",@"烧伤科",@"精神心理科",@"中医科",@"中西医结合科",@"穿软冰科",@"结核病科",@"介入医学科",@"康复医学科",@"运动医学科",@"麻醉医学科",@"职业病科",@"地方病科",@"营养科",@"医学影像科",@"病理科",@"其他科室"];
    NSArray *arr1 = @[@"心血管科",@"神经内科",@"消化内科",@"内分泌科",@"免疫科",@"呼吸科",@"肾病内科",@"血液科",@"感染内科",@"过敏反应科",@"老年病科",@"普通内科",@"高压氧科"];
    NSArray *arr2 = @[@"神经外科",@"功能神经外科",@"心血管外科",@"胸外科",@"整形科",@"乳腺外科",@"泌尿外科",@"肝胆外科",@"肛肠科",@"血管外科",@"器官移植",@"微创外科",@"普外科",@"脑外科",@"烧伤科"];
    NSArray *arr3 = @[@"妇科",@"产科",@"妇泌尿科",@"遗传咨询科",@"计划生育科",@"妇产科"];
    NSArray *arr4 = @[@"生殖中心"];
    NSArray *arr5 = @[@"儿科",@"新生儿科",@"小儿呼吸科",@"小儿营养科"];
    NSArray *arr6 = @[@"骨科",@"脊柱外科",@"手外科",@"创伤骨科",@"骨关节科",@"矫形骨科"];
    NSArray *arr7 = @[@"眼科",@"小儿眼科",@"眼底",@"角膜科",@"青光眼",@"白内障",@"眼外科",@"眼眶及肿瘤",@"屈光",@"眼整形",@"中医眼科"];
    NSArray *arr8 = @[@"口腔科",@"正畸科",@"牙体牙髓科"];
    NSArray *arr9 = @[@"耳鼻喉"];
    NSArray *arr10 = @[@"肿瘤内科",@"肿瘤外科"];
    NSArray *arr11= @[@"皮肤科",@"性病科"];
    NSArray *arr12 = @[@"男性学科"];
    NSArray *arr13 = @[@"皮肤美容"];
    NSArray *arr14 = @[@"烧伤科"];
    NSArray *arr15 = @[@"精神科",@"心理咨询科",@"司法鉴定科",@"双相障碍科",@"药物依赖科"];
    NSArray *arr16 = @[@"中医妇产科",@"中医儿科",@"中医骨科"];
    NSArray *arr17 = @[@"中西医结合科"];
    NSArray *arr18 = @[@"肝病科",@"传染科"];
    NSArray *arr19 = @[@"结核病科"];
    NSArray *arr20 = @[@"介入医学科"];
    NSArray *arr21 = @[@"康复科",@"理疗科"];
    NSArray *arr22 = @[@"运动医学科"];
    NSArray *arr23 = @[@"疼痛科",@"麻醉科"];
    NSArray *arr24 = @[@"职业病科"];
    NSArray *arr25 = @[@"地方病科"];
    NSArray *arr26 = @[@"营养科"];
    NSArray *arr27 = @[@"核医学科",@"放射科",@"超声科",@"医学影像科"];
    NSArray *arr28 = @[@"病理科"];
    NSArray *arr29 = @[@"急诊科",@"特色医疗科",@"干部诊疗科",@"重症监护室",@"特诊科",@"体检科"];
    self.officeDetailArray = @[arr1,arr2,arr3,arr4,arr5,arr6,arr7,arr8,arr9,arr10,arr11,arr12,arr13,arr14,arr15,arr16,arr17,arr18,arr19,arr20,arr21,arr22,arr23,arr24,arr25,arr26,arr27,arr28,arr29];
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 29;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    FMFunCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FMFunCell" forIndexPath:indexPath];
    cell.officeLabel.text = [self.officeArray objectAtIndex:indexPath.row];
    return cell;
}

#pragma mark <UICollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    FMOfficeDetailController *detailController = [[FMOfficeDetailController alloc] init];
    detailController.officeDetailArr = [self.officeDetailArray objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:detailController animated:YES];
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
