//
//  ProgramIntrduceController.m
//  zhicai
//
//  Created by 陈思思 on 15/8/5.
//  Copyright (c) 2015年 perfect. All rights reserved.
//

#import "ProgramIntrduceController.h"

@interface ProgramIntrduceController ()
@property (nonatomic,strong)SKSTableView* skstableview;
@end

@implementation ProgramIntrduceController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatCellTableview];
}


-(void)creatCellTableview{
    self.skstableview = [[SKSTableView alloc] initWithFrame:CGRectMake(0, 64, MRScreenWidth,MRScreenHeight)];
    //    [self.skstableview setDelegate:self];
    //    [self.skstableview setDataSource:self];
    //self.skstableview = [SKSTableView new];
    self.skstableview.SKSTableViewDelegate = self;
    self.skstableview.backgroundColor =  [UIColor colorWithRGBHex:0xf2f2f2];
    [self.skstableview setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
    [self.view addSubview:self.skstableview];
    //    [self.skstableview mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.edges.equalTo(self.borrowingView).with.insets(UIEdgeInsetsMake(297, 0, 0, 0));
    //    }];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}
//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return 80;
//}

-(NSInteger)tableView:(SKSTableView *)tableView numberOfSubRowsAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:
            return 5;
            break;
        case 1:
            return 2;
            break;
        case 2:
            return 7;
            break;
        case 3:
            return 6;
            break;
        case 4:
            return 1;
            break;
   
        default:
            return 0;
            break;
    } 
}
-(UITableViewCell *)tableView:(SKSTableView *)tableView cellForSubRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"UITableViewCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:{
                switch (indexPath.subRow) {
                    case 1:
                        cell.textLabel.text = @"融资规模";
                        break;
                    case 2:
                        cell.textLabel.text = @"起息日";
                        break;
                    case 3:
                        cell.textLabel.text = @"到期日";
                        break;
                    case 4:
                        cell.textLabel.text = @"保障措施";
                        break;
                    case 5:
                        cell.textLabel.text = @"保障性质";
                        break;

                    default:
                        break;
                }
                
                
                }
                break;
            case 1:{
                
                }
                break;
            case 2:{
                
                }
                break;
            case 3:{
                
                }
                break;
            case 4:{
                
                }
                break;
               
            default:
                break;
        }
    }
     // cell.textLabel.text = @"123";
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.layer.borderWidth = 2.5;
    cell.layer.borderColor = [UIColor colorWithRGBHex:0xebebeb].CGColor;
    return cell;

}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString* cellidentifier = @"CELL";
    SKSTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellidentifier];
    if (cell == nil) {
        cell = [[SKSTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellidentifier];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
    cell.isExpandable = YES;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
