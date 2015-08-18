//
//  selectBankViewController.m
//  zhicai
//
//  Created by perfect on 15/4/7.
//  Copyright (c) 2015年 perfect. All rights reserved.
//
#import "BuyController.h"
#import "AddBankView.h"
#import "BankModel.h"
#import "SelectBankViewController.h"

@interface SelectBankViewController ()

@end

@implementation SelectBankViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.bankarr = [[NSMutableArray alloc]init];
    self.view.backgroundColor = [UIColor grayColor];
    [self createNav];
    [self creatTableview];
    [self connect];
}
-(void)connect{
    NSString* url = @"o/getAllBankList";
    [Httptool getWithURL:url Params:nil Success:^(id json, HttpCode code) {
        NSDictionary* dic = (NSDictionary*)json;
        NSLog(@"%@",dic);
        
        if ([[dic objectForKey:@"code"] integerValue]== kHttpStatusOK) {
            //self.bankarr = [dic objectForKey:@"data"];
            for (NSDictionary* bankdic in [dic objectForKey:@"data"]) {
                BankModel* bankmodel = [BankModel objectWithKeyValues:bankdic];
                [self.bankarr addObject:bankmodel];
            }
            [self.mytableview reloadData];
        }
        else{
            [commfunc showCustInfo:nil MessageString:[dic objectForKey:@"msg"]];
        }
    } Failure:^(NSError *error) {
        
    }];
}

-(void)creatTableview{
    self.mytableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 84, MRScreenWidth, MRScreenHeight) style:UITableViewStylePlain];
    self.mytableview.delegate = self;
    self.mytableview.dataSource = self;
    [self.mytableview setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
    self.mytableview.backgroundColor = [UIColor whiteColor];
    self.mytableview.bounces = NO;
    [self.view addSubview:self.mytableview];

}
- (void)createNav
{
    self.view.backgroundColor = [MyControl getColor:@"EDEDED"];
    self.navigationController.navigationBarHidden = YES;
    
    UIView * navView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MRScreenWidth, 64)];
    navView.backgroundColor = [UIColor colorWithRGBHex:0x509ef0];
    [self.view addSubview:navView];
    
    UILabel * navlab = [MyControl createLabelFrame:CGRectMake((MRScreenWidth-200)/2, 20, 200, 40) font:17 Text:@"选择银行"];
    navlab.textAlignment = YES;
    navlab.textColor = [MyControl getColor:@"ffffff"];
    [navView addSubview:navlab];
    
   UIButton * backBtn = [MyControl createButtonFrame:CGRectMake(0, 30, 50, 25) Title:nil BgImageName:nil ImageName:@"fanhui.png" Method:@selector(backClick) target:self];
    // backBtn.backgroundColor = [UIColor redColor];
    [navView addSubview:backBtn];
    
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.bankarr.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString* cellidentifier = @"cell";
    UITableViewCell* cell = [tableView cellForRowAtIndexPath:indexPath];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellidentifier];
        self.imageLogo = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 30, 30)];
       
        [cell.contentView addSubview:self.imageLogo];
        
        self.banknameLab = [[UILabel alloc] initWithFrame:CGRectMake(70, 0, MRScreenWidth-40, 44)];
        self.banknameLab.textAlignment = NSTextAlignmentLeft;
        //self.banknameLab.backgroundColor = [UIColor blackColor];
        [cell.contentView addSubview:self.banknameLab];
        
    }
    BankModel* model = self.bankarr[indexPath.row];
    self.banknameLab.text = model.bankname;
    NSData* imgdata = [NSData dataWithContentsOfURL:[NSURL URLWithString:model.logoPath]];
    self.imageLogo.image = [UIImage imageWithData:imgdata];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.mybankmodel = self.bankarr[indexPath.row];
    //self.addbank = self.navigationController.childViewControllers[4];
    self.addbank.bank.text = self.mybankmodel.bankname;
    self.addbank.bankid = self.mybankmodel.bankId;
   [self.navigationController popToViewController:self.addbank animated:YES];
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



@end
