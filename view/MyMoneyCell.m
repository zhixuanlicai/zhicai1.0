//
//  myMoneyCell.m
//  zhicai
//
//  Created by perfect on 15/4/1.
//  Copyright (c) 2015年 perfect. All rights reserved.
//

#import "MyMoneyCell.h"
@implementation MyMoneyCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self makeUI];
    }
    return self;
}
-(void)makeUI
{
    
    //NSArray * titleArr = @[@"产品名称",@"本金",@"已购买天数",@"收益"];
    
    for (int i = 0; i<4; i++) {
         self.cLab = [MyControl createLabelFrame:CGRectMake(MRScreenWidth/4*i,0,MRScreenWidth/4,40) font:12 Text:nil];
        self.cLab.textAlignment = NSTextAlignmentCenter;
        self.cLab.textColor = [MyControl getColor:@"#8E8E8E"];
        self.cLab.tag = 205+i;
        [self.contentView addSubview:self.cLab];
        
        switch (i) {
            case 0:
            {
            
                self.cLab.textColor = [MyControl getColor:@"#3E535E"];

            }
                break;
            case 1:
            {
               self.cLab.textColor = [MyControl getColor:@"#8cc3ea"];

            }
                break;
            case 2:
            {
                self.cLab.textColor = [MyControl getColor:@"#8E8E8E"];

            }
                break;
            case 3:
            {
                self.cLab.textColor = [MyControl getColor:@"#f97252"];

            }
                break;
    
            default:
                break;
        }
    }
    
    
    
    lView = [[UIView alloc]initWithFrame:CGRectMake(15, 39, MRScreenWidth-15*2, 1)];
    lView.backgroundColor = [MyControl getColor:@"#D4D4D4"];
    [self.contentView addSubview:lView];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
