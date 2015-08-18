//
//  SetViewController.m
//  zhicai
//
//  Created by perfect on 15/3/25.
//  Copyright (c) 2015年 perfect. All rights reserved.
//
#import "LoginViewController.h"
#import "SetViewController.h"
#import "RemindViewController.h"
#import "AboutViewController.h"
#import "PersonInfoController.h"
#import "FTApi.h"

@interface SetViewController ()<UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    UIImageView * iconImg;
    UILabel * userLab;
    UILabel * phoneLab;
    UIButton * setBtn;
    UIImage * image;//选择修改的图片
    UIView * view1;//个人信息
    UIView * view2;//介绍
    NSString * strTit;
    
}
@end

@implementation SetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.view.backgroundColor = [UIColor lightGrayColor];
//    
//    self.navigationController.navigationBar.translucent = NO;
//    self.view.backgroundColor = [UIColor lightGrayColor];
//    
//    UIBarButtonItem * backBtn = [[UIBarButtonItem alloc]initWithImage:nil style:UIBarButtonItemStyleDone target:self action:@selector(backClick)];
//    self.navigationItem.leftBarButtonItem = backBtn;
//    self.navigationItem.leftBarButtonItem.title = @"返回";
//    self.navigationItem.title = @"设置";
    
    [self createNav];
    [self createView];
    [self request];
}
- (void)createNav
{
    self.view.backgroundColor = [MyControl getColor:@"EDEDED"];
    self.navigationController.navigationBarHidden = YES;
    
    UIView * navView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MRScreenWidth, 64)];
    navView.backgroundColor = [UIColor colorWithRGBHex:0x509ef0];
    [self.view addSubview:navView];
    
    UILabel * navlab = [MyControl createLabelFrame:CGRectMake((MRScreenWidth-200)/2, 20, 200, 40) font:17 Text:@"设置"];
    navlab.textAlignment = YES;
    navlab.textColor = [MyControl getColor:@"ffffff"];
    [navView addSubview:navlab];
    
    UIButton * backBtn = [MyControl createButtonFrame:CGRectMake(0, 30, 50, 25) Title:nil BgImageName:nil ImageName:@"fanhui.png" Method:@selector(backClick) target:self];
    [navView addSubview:backBtn];
    
}


- (void)createView
{
     view1 = [[UIView alloc]initWithFrame:CGRectMake(0, 80, MRScreenWidth, 92)];
    view1.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view1];
    
     setBtn = [MyControl createButtonFrame:CGRectMake(25, (92-70)/2, 70, 70) Title:nil BgImageName:nil ImageName:@"touxiang.png" Method:@selector(setClick) target:self];
   // setBtn.backgroundColor = [UIColor redColor];
    setBtn.layer.cornerRadius = setBtn.frame.size.width/2;
    setBtn.layer.masksToBounds = YES;
    [view1 addSubview:setBtn];
    
    
    UIButton * userBtn = [MyControl createButtonFrame:CGRectMake(120, 0, MRScreenWidth-120, 92) Title:nil BgImageName:nil ImageName:nil Method:@selector(personClick) target:self];
   // userBtn.backgroundColor = [UIColor redColor];
    [view1 addSubview:userBtn];
    
    userLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 5, 120, 46)];
    [userLab setFont:[UIFont systemFontOfSize:18]];
    //userLab.backgroundColor = [UIColor greenColor];
    //userLab.text = @"张三";
    userLab.textColor = [MyControl getColor:@"#31424A"];
    //userLab.text = gAppDelegate.userModel.;
    //            phoneLab.text = [responseObject objectForKey:@"userPhone"];
    [userBtn addSubview:userLab];
    
    phoneLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 35, 120, 46)];
    [phoneLab setFont:[UIFont systemFontOfSize:15]];
  //  phoneLab.backgroundColor = [UIColor yellowColor];
  //  phoneLab.text = @"16532435456";
    phoneLab.textColor =[MyControl getColor:@"#8E8E8E"];
    phoneLab.text = gAppDelegate.userModel.mobilePhone;
    [userBtn addSubview:phoneLab];
  
    UIImageView * img = [MyControl createImageViewFrame:CGRectMake(MRScreenWidth-16-7-120, 53, 7, 11) imageName:@"dxiayib@1x.png"];
    //img.backgroundColor = [UIColor purpleColor];
    [userBtn addSubview:img];
    
  view2 = [[UIView alloc]initWithFrame:CGRectMake(0, 188, MRScreenWidth, 88)];
     //view2.backgroundColor =[MyControl getColor:@"EDEDED"];
    view2.backgroundColor = [UIColor redColor];
    [self.view addSubview:view2];
    
    
    UIButton * btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn1.frame = CGRectMake(0, 0, MRScreenWidth, 44);
    [btn1 addTarget:self action:@selector(btn1Click) forControlEvents:UIControlEventTouchUpInside];
    btn1.backgroundColor = [UIColor whiteColor];
    [view2 addSubview:btn1];
    
    UILabel * lab1 = [MyControl createLabelFrame:CGRectMake(16, 0, 100, 44) font:15 Text:@"新品上线提醒"];
    lab1.textColor = [MyControl getColor:@"#31424A"];
    [btn1 addSubview:lab1];
    
    UIView * lineView = [[UIView alloc]initWithFrame:CGRectMake(16, 43, MRScreenWidth-16*2, 1)];
    lineView.backgroundColor = [MyControl getColor:@"#D4D4D4"];
    [view2 addSubview:lineView];
    
    UIImageView * img3 = [MyControl createImageViewFrame:CGRectMake(MRScreenWidth-16-7, (44-11)/2, 7, 11) imageName:@"dxiayib@1x.png"];
    //img.backgroundColor = [UIColor purpleColor];
    [btn1 addSubview:img3];
    
    
    UIButton * btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn2.frame = CGRectMake(0, 44, MRScreenWidth, 44);
    [btn2 addTarget:self action:@selector(btn2Click) forControlEvents:UIControlEventTouchUpInside];
    btn2.backgroundColor = [UIColor whiteColor];
    [view2 addSubview:btn2];
    
    UILabel * lab2 = [MyControl createLabelFrame:CGRectMake(16, 0, 100, 44) font:15 Text:@"关于智选理财"];
    lab2.textColor = [MyControl getColor:@"#31424A"];
    [btn2 addSubview:lab2];
    UIImageView * img1 = [MyControl createImageViewFrame:CGRectMake(MRScreenWidth-16-7, (44-11)/2, 7, 11) imageName:@"dxiayib@1x.png"];
    //img.backgroundColor = [UIColor purpleColor];
    [btn2 addSubview:img1];
    
  #pragma mark 安全退出
    UIButton * outLogin = [MyControl createButtonFrame:CGRectMake(0, 292, MRScreenWidth, 44) Title:nil BgImageName:nil ImageName:nil Method:@selector(outClick) target:self];
    outLogin.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:outLogin];
    UILabel * lab3 = [MyControl createLabelFrame:CGRectMake(16, 0, 100, 44) font:15 Text:@"安全退出"];
    lab3.textColor = [MyControl getColor:@"#31424A"];
    [outLogin addSubview:lab3];

    
    UIButton *logBtn = [MyControl createButtonFrame:CGRectMake(0, MRScreenHeight-49, MRScreenWidth, 49) Title:@"马上登录" BgImageName:nil ImageName:nil Method:@selector(loginClick) target:self];
    logBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [logBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    logBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    logBtn.backgroundColor = [MyControl getColor:@"D4D4D4"];
   // [self.view addSubview:logBtn];

}

- (void)request
{
    
//    NSString * str =[NSString stringWithFormat:API_CoreSet];
//    str  = [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    [FTApi requestWithMethod:@"Get" withPath:str withParams:nil  complate:^(id responseObject,NSError*error){
//        if (error) {
//            NSLog(@"============error==%@",error);
//        }else{
//            NSLog(@"-----respon==%@",responseObject);
//            userLab.text = [responseObject objectForKey:@"userName"];
//            
//            phoneLab.text = [responseObject objectForKey:@"userPhone"];
//            strTit = [responseObject objectForKey:@"newsRemind"];
//            NSLog(@"bauxca");
//            NSLog(@"999999%@",strTit);
//        }
//    }];
    
}


#pragma mark 个人信息
- (void)personClick
{

    NSLog(@"个人信息");
    PersonInfoController * info = [[PersonInfoController alloc]init];
    [self.navigationController pushViewController:info animated:YES];
    

}

- (void)outClick
{
    [self doLogout];
    
}


- (void)doLogout
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"确认" message:@"您确定要退出当前账号吗？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认" , nil];
    [alert showAlertViewWithCompleteBlock:^(NSInteger buttonIndex)
     {
         if (buttonIndex == 1)
         {
             //remove flags
             [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"LoginUserName"];
             [[NSUserDefaults standardUserDefaults] setObject:@"N" forKey:kIsLogin];
             [[NSUserDefaults standardUserDefaults] removeObjectForKey:kLoginTokenIdentifier];
             
             //logout from server
 //            [gAppDelegate logoutFromServer];
             
             gAppDelegate.userModel = nil;
             gAppDelegate.isLogin = NO;
//             //clear cookies
//             [CommonFunc clearCookieStorage];
             LoginViewController * loginvc = [[LoginViewController alloc] init];
             loginvc.isFromLogOut = YES;
             [self.navigationController pushViewController:loginvc animated:YES];
         }
     }];
}

- (void)infoClick
{
    
    NSLog(@"华灯初上");
    
//    personInfoViewController * info = [[personInfoViewController alloc]init];
//    [self.navigationController pushViewController:info animated:YES];
}

- (void)backClick
{
    
    [self.navigationController popViewControllerAnimated:YES];
    self.parentViewController.tabBarController.tabBar.hidden = NO;
    
}
- (void)btn1Click
{
    NSLog(@"提醒");
    
    RemindViewController * remind =[[RemindViewController alloc]init];
    remind.titStr = strTit;
    [self.navigationController pushViewController:remind animated:YES];
    
}
- (void)btn2Click
{
    NSLog(@"guanyu");
    
    AboutViewController * about = [[AboutViewController alloc]init];
    [self.navigationController pushViewController:about animated:YES];
}

- (void)loginClick
{

    NSLog(@"马上登录");

}
- (void)setClick
{

    NSLog(@"相机");
    
     UIActionSheet*sheet=[[UIActionSheet alloc]initWithTitle:@"提示" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"相机",@"相册", nil];
#pragma mark 修改图像 给sheet加tag值
      sheet.tag = 209;
    [sheet showInView:self.view];
    
}



#pragma mark actionDelegate
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    UIImagePickerController*picker=[[UIImagePickerController alloc]init];
    picker.delegate=self;
#pragma mark 修改picker allowsEditing
    picker.allowsEditing = YES;
    
    if(buttonIndex==0)
    {
        //相机
        picker.sourceType=UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:picker animated:YES completion:nil];
    }
    else {
        if(buttonIndex==1)
        {
            //相册
            picker.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
            [self presentViewController:picker animated:YES completion:nil];
        }
    }
    
    
    if (buttonIndex==2) {
        return;
    }
    
//    UIImagePickerController*pick=[[UIImagePickerController alloc]init];
//    //为了获得选择的结果，需要加入协议添加代理
//    pick.delegate=self;
//    
//    //默认开启的是相册
//    if (!buttonIndex) {
//        //开启相机 先判断相机是否可用
//        if ([UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront]) {
//            //如果可用，设置模式
//            pick.sourceType=UIImagePickerControllerSourceTypeCamera;
//        }
//        
//    }
//    [self presentViewController:pick animated:YES completion:nil];

    
}
#pragma mark 修改完成后还需向服务器发送消息
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
#pragma mark 修改 首先先让选择图片的controller消失
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    //获得选择的图片
    UIImage *image1 = [info objectForKey:UIImagePickerControllerOriginalImage];
    //保存到沙盒
    [self saveImage:image1 withName:@"currentImage.png"];
    
    //存入临时的路径
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"currentImage.png"];
    
    //获取图片并且显示到iconbutton上
    UIImage *savedImage = [[UIImage alloc] initWithContentsOfFile:fullPath];
    image = [self imageWithImageSimple:savedImage scaledToSize:CGSizeMake(70, 70)];
    
    [setBtn setImage:image forState:UIControlStateNormal];
    
#pragma mark 上传数据的方法
    [self upLoadSalesBigImage:image];
}

//取消
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    //无论取消与确定，都需要移除
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}

#pragma mark - 保存图片至沙盒
- (void) saveImage:(UIImage *)currentImage withName:(NSString *)imageName
{
    NSData *imageData = UIImageJPEGRepresentation(currentImage, 0.5);
    // 获取沙盒目录
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:imageName];
    // 将图片写入文件
    [imageData writeToFile:fullPath atomically:NO];
}
#pragma mark 压缩图片
-(UIImage*)imageWithImageSimple:(UIImage*)oldImage scaledToSize:(CGSize)newSize
{
    // Create a graphics image context
    UIGraphicsBeginImageContext(newSize);
    // Tell the old image to draw in this new context, with the desired
    // new size
    [oldImage drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    // End the context
    UIGraphicsEndImageContext();
    // Return the new image.
    return newImage;
    
}
-(void)upLoadSalesBigImage:(UIImage*)upLoadImage
{
    //将图片转化为二进制数据
    NSData*imageData=UIImageJPEGRepresentation(upLoadImage, 1);
    //存储到本地的路径
    NSString*fullpathtofile=[[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"FileName.jpg"];
    
    //将二进制数据写入到本地
    [imageData writeToFile:fullpathtofile atomically:NO];
    
    //从本地取出文件
    NSString*string=[NSString stringWithFormat:@"%@/%@",[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"],@"FileName.jpg"];
    
    NSUserDefaults*user=[NSUserDefaults standardUserDefaults];
    
//    __weak ASIFormDataRequest*request=[ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:FIXICON,[user objectForKey:@"token"]]]];
//    request.delegate = self;
//    
//    request.tag = 1001;
//    
//    //设置超时时常
//    request.timeOutSeconds=30;
//    
//    //addFile:这个需要填写文件名
//    [request addFile:string  forKey:@"file"];
//    
//    [request addPostValue:@"file" forKey:@"name"];
//    
//    [request setCompletionBlock:^{
//        
//        [SGInfoAlert showInfo:@"头像上传成功" bgColor:[[UIColor blackColor]CGColor] inView:self.view vertical:0.7];
//        
//        [self DictWithJsonString:request.responseString];
//    }];
//    
//    [request setFailedBlock:^{
//        NSLog(@"%@",request.responseString);
//    }];
//    
//    [request startAsynchronous];
//    
}


#if 0
//这里传递过来了经过处理的图片，并将这个图片赋值给用户的图像，
-(void)passImage:(UIImage *)image1
{
    [IconButton setImage:image1 forState:UIControlStateNormal];
    //NSString*name=@"FileName.jpg";
    //将图片转化为二进制数据
    NSData*imageData=UIImageJPEGRepresentation(image1, 1.0);
    //存储到本地的路径
    NSString*fullpathtofile=[[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"FileName.jpg"];
    //将二进制数据写入到本地
    [imageData writeToFile:fullpathtofile atomically:NO];
    //从本地取出文件
    NSString*string=[NSString stringWithFormat:@"%@/%@",[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"],@"FileName.jpg"];
    NSUserDefaults*user=[NSUserDefaults standardUserDefaults];
    ASIFormDataRequest*request=[ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:FIXICON,[user objectForKey:@"token"]]]];
    //设置超时时常
    request.timeOutSeconds=30;
    //addFile:这个需要填写文件名
    [request addFile:string  forKey:@"file"];
    [request addPostValue:@"file" forKey:@"name"];
    [request setCompletionBlock:^{
        NSLog(@"%@",request.responseString);
        
        [self DictWithJsonString:request.responseString];
    }];
    [request setFailedBlock:^{
        NSLog(@"asi error:%@",request.error.debugDescription);
    }];
    [request startAsynchronous];
    
}
#endif


#pragma mark 进行json格式的解析
-(NSDictionary*)DictWithJsonString:(NSString*)str
{
    if(str==nil)
    {
        return nil;
    }
    
    NSData*jsonData=[str dataUsingEncoding:NSUTF8StringEncoding ];
    NSError*error;
    NSDictionary*dic=[NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
    NSUserDefaults*user = [NSUserDefaults standardUserDefaults];
    [user setObject:dic forKey:@"UserMessage"];
    [user synchronize];
    
//    [IconButton sd_setImageWithURL:[NSURL URLWithString:[[dic objectForKey:@"data"] objectForKey:@"pic"]] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"头像.jpg"]];
    
    //ImageNum++;
    
    if(error)
    {
        NSLog(@"解析失败");
        return nil;
    }
    return dic;
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
