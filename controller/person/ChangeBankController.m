//
//  changeBankController.m
//  zhicai
//
//  Created by perfect on 15/4/8.
//  Copyright (c) 2015年 perfect. All rights reserved.
//

#import "BankCardModel.h"
#import "ChangeBankController.h"
#import "BankCell.h"
#import "AddBankView.h"
@interface ChangeBankController ()<UITableViewDataSource,UITableViewDelegate>
{
    
    UIView * headView;
    UIView * footView;
    UITableView * table;
    NSMutableArray * bankArr;

}

@end

@implementation ChangeBankController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.bankcardsarr = [[NSMutableArray alloc]init];
    self.bankcardsarr = [gAppDelegate.userModel.cards mutableCopy];
    // Do any additional setup after loading the view.
    
    [self createNav];
    [self createView];
    
    [self createTableView];
    
  //  bankArr = [[NSMutableArray alloc]initWithCapacity:0];
    
    for (int i = 0; i<5; i++) {
        NSString *text = [NSString stringWithFormat:@"mj-%i", i];
        [bankArr addObject:text];
    }

}

-(void)connect{
    NSString* url = @"u/disCreditCard";
    NSMutableDictionary* params =[[NSMutableDictionary alloc] init];
    [params setObject:gAppDelegate.userModel.tokenId forKey:@"TOKEN"];
    [params setObject:gAppDelegate.userModel.userId forKey:@"userId"];
    [params setObject:gAppDelegate.userModel.mobilePhone forKey:@"mobile"];
    [params setObject:self.model.cardId forKey:@"cardId"];
    [Httptool postWithURL:url Params:params Success:^(id json, HttpCode code) {
        NSDictionary* dic = (NSDictionary*)json;
        NSLog(@"%@",dic);
        if ([[dic objectForKey:@"code"] integerValue] == kHttpStatusOK) {
            [table reloadData];
            NSString* url = @"u/getUserLoingInfoByTOKEN";
            NSMutableDictionary* params1 = [[NSMutableDictionary alloc]init];
            [params1 setObject:gAppDelegate.userModel.tokenId forKey:@"TOKEN"];
            [Httptool postWithURL:url Params:params1 Success:^(id json, HttpCode code) {
                if (code == kHttpStatusOK) {
                    NSLog(@"%@",json);
                    NSDictionary* dic = (NSDictionary*)json;
                    
                    if ([[dic objectForKey:@"code"] intValue] == 200) {
                        
                        
                        NSDictionary* userdic = [dic objectForKey:@"data"];
                        UserModel* user = [UserModel objectWithKeyValues:userdic];
                        gAppDelegate.userModel = user;
                        gAppDelegate.isLogin = YES;
                        [[NSUserDefaults standardUserDefaults] setValue:gAppDelegate.userModel.mobilePhone forKey:@"LoginUserName"];
                        [[NSUserDefaults standardUserDefaults] setObject:@"Y" forKey:kIsLogin];
                        [[NSUserDefaults standardUserDefaults] setObject:[dic objectForKey:@"tokenId"] forKey:kLoginTokenIdentifier];
                        
                        
                        
                        self.bankcardsarr = [gAppDelegate.userModel.cards mutableCopy];
                        [table reloadData];
                    }else{
                        //[SVProgressHUD show];
                        //[SVProgressHUD dismissWithError:@"请重新输入密码" afterDelay:1.0];
                        [commfunc showCustInfo:nil MessageString:[dic objectForKey:@"msg"]];
                    }
                    
                    
                }
            } Failure:^(NSError *error) {
                
            }];

            
        }
    } Failure:^(NSError *error) {
        
    }];
    
 
}
- (void)createNav
{
    self.view.backgroundColor = [MyControl getColor:@"EDEDED"];
    self.navigationController.navigationBarHidden = YES;
    
    UIView * navView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MRScreenWidth, 64)];
    navView.backgroundColor = [UIColor colorWithRGBHex:0x509ef0];
    [self.view addSubview:navView];
    
    UILabel * navlab = [MyControl createLabelFrame:CGRectMake((MRScreenWidth-200)/2, 20, 200, 40) font:17 Text:@"银行卡管理"];
    navlab.textAlignment = YES;
    navlab.textColor = [MyControl getColor:@"ffffff"];
    [navView addSubview:navlab];
    
    UIButton * backBtn = [MyControl createButtonFrame:CGRectMake(0, 30, 50, 25) Title:nil BgImageName:nil ImageName:@"fanhui.png" Method:@selector(backClick) target:self];
    [navView addSubview:backBtn];
    
    UIButton * addBtn = [MyControl createButtonFrame:CGRectMake(MRScreenWidth-17-16, (64-18)/2+7, 17, 18) Title:nil BgImageName:nil ImageName:@"tianjia" Method:@selector(addClick) target:self];
    [navView addSubview:addBtn];
    
}

- (void)createView
{
   headView = [[UIView alloc]initWithFrame:CGRectMake(0, 84, MRScreenWidth, 44)];
    headView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:headView];
    
    UILabel * lab1 = [MyControl createLabelFrame:CGRectMake(20, 0, 100, 44) font:15 Text:@"账户"];
    lab1.textColor = [MyControl getColor:@"#31424A"];
    [headView addSubview:lab1];
    
    UILabel * lab2 = [MyControl createLabelFrame:CGRectMake(MRScreenWidth-16-120, 0, 120, 44) font:15 Text:gAppDelegate.userModel.mobilePhone];
    lab2.textColor = [MyControl getColor:@"#8F8F8F"];
    lab2.textAlignment = NSTextAlignmentRight;
    [headView addSubview:lab2];
    
    
    
    
}
- (void)createTableView
{

    table = [[UITableView alloc]initWithFrame:CGRectMake(0,148, MRScreenWidth, MRScreenHeight-148) style:UITableViewStylePlain];
    table.dataSource = self;
    table.delegate = self;
   // tableView.tableHeaderView = headView;
    [self.view addSubview:table];
    //tableView.backgroundColor = [UIColor purpleColor];
    table.backgroundColor = [MyControl getColor:@"EDEDED"];

    table.tableFooterView = nil;
    //230
    
    footView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MRScreenWidth, 80)];
    //footView.backgroundColor = [UIColor greenColor];
    table.tableFooterView  = footView;
    UIButton * totoalBtn =[MyControl createButtonFrame:CGRectMake((MRScreenWidth-217)/2, 0, 217, 80) Title:nil BgImageName:nil ImageName:nil Method:@selector(tbtnClick) target:self];
    //totoalBtn.backgroundColor = [UIColor redColor];
    [footView addSubview:totoalBtn];
    
    UIImageView * aimg = [MyControl createImageViewFrame:CGRectMake(0, 15, 28, 29) imageName:@"anquan@1x.png"];
    [totoalBtn addSubview:aimg];
    
    UILabel * txtLab = [MyControl createLabelFrame:CGRectMake(30, 10, 200, 40) font:12 Text:@"账户资金安全由华安财险100%承保"];
    //txtLab.textAlignment = YES;
    txtLab.textColor = [MyControl getColor:@"26526C"];
    [totoalBtn addSubview:txtLab];

    

}
- (void)addClick
{
    AddBankView * add = [[AddBankView alloc]init];
    [self.navigationController pushViewController:add animated:YES];


}
- (void)tbtnClick
{

    NSLog(@"dsfdfhnf");

}
#pragma mark tableView 代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.bankcardsarr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    BankCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ID"];
    if (!cell) {
        cell = [[BankCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ID"];
    }
//    NSArray* arr = gAppDelegate.userModel.cards;
//    self.bankcardsarr = [arr mutableCopy];
     BankCardModel* model = [BankCardModel objectWithKeyValues:gAppDelegate.userModel.cards[indexPath.row]];
    [cell setBank:model];
   // cell.textLabel.text = [bankArr objectAtIndex:indexPath.row];
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 59;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        if (indexPath.row<self.bankcardsarr.count) {
            self.model = [BankCardModel objectWithKeyValues:self.bankcardsarr[indexPath.row]];
            [self connect];
            [self.bankcardsarr removeObjectAtIndex:indexPath.row];
            [table deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];

        }
      }
    [tableView reloadData];
}

-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}


- (void)backClick
{
    [self.navigationController popViewControllerAnimated:YES];

}

- (void)viewWillAppear:(BOOL)animated
{
    
    self.parentViewController.tabBarController.tabBar.hidden = YES;
}
- (void)viewWillDisappear:(BOOL)animated
{
    self.parentViewController.tabBarController.tabBar.hidden = NO;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
