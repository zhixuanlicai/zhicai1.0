//
//  selectBankViewController.h
//  zhicai
//
//  Created by perfect on 15/4/7.
//  Copyright (c) 2015年 perfect. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectBankViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)NSMutableArray* bankarr;
@property(nonatomic,strong)UILabel* banknameLab ;
@property(nonatomic,strong)BankModel* mybankmodel;
@property(nonatomic,strong)UITableView* mytableview;
@property(nonatomic,strong)AddBankView* addbank;
@property(nonatomic,strong)UIImageView* imageLogo;
@end
