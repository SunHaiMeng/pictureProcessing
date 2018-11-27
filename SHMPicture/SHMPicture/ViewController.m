//
//  ViewController.m
//  SHMPicture
//
//  Created by apple on 2018/11/27.
//  Copyright © 2018年 GXT. All rights reserved.
//

#import "ViewController.h"
#import "UIImage+compress.h"
#import "SHMimageFixOrientation.h"
#import "ShowPicture.h"
#import "ACSelectMediaView.h"
#define WIDTH [UIScreen mainScreen].bounds.size.width
@interface ViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@end

@implementation ViewController{
    UIImageView * showImage;
    UITextField * pictureByte;
    UILabel * showPictureByte;
    UIView * imageView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self initUI];
}
-(void)initUI{
    NSString *showPByte;
    showImage = [[UIImageView alloc]init];
    showImage.frame = CGRectMake(100, 100, 100, 100);
    showImage.image = [UIImage imageNamed:@"timg-7.jpeg"];
    NSData *data = UIImagePNGRepresentation(showImage.image);
    showPByte = [NSString stringWithFormat:@"%lu byte",(unsigned long)data.length];
    [self.view addSubview:showImage];
    pictureByte = [[UITextField alloc]init];
    pictureByte.font = [UIFont systemFontOfSize:12];
    pictureByte.placeholder = @"请输入压缩图片的大小（byte）。";
    pictureByte.frame = CGRectMake(20, 200, 200, 30);
    [self.view addSubview:pictureByte];
    showPictureByte = [[UILabel alloc]init];
    showPictureByte.textColor = [UIColor redColor];
    showPictureByte.text = showPByte;
    showPictureByte.frame = CGRectMake(220, 200, 150, 30);
    [self.view addSubview:showPictureByte];
    
    UIButton * button_p = [[UIButton alloc]init];
    button_p.frame = CGRectMake(220, 150, 40, 40);
    [button_p setTitle:@"拍照" forState:(UIControlStateNormal)];
    [button_p setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    [button_p addTarget:self action:@selector(onButtonPicture) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:button_p];
    
    UIButton * button_one = [[UIButton alloc]init];
    button_one.frame = CGRectMake(100, 250, 100, 40);
    [button_one setTitle:@"压缩" forState:(UIControlStateNormal)];
    [button_one setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    [button_one addTarget:self action:@selector(onButtonOne) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:button_one];
    
    //旋转正图片（主要是ios拍照后进行压缩的图片都是左转90度的，用此方法转正图片）
    UIButton * button_two = [[UIButton alloc]init];
    button_two.frame = CGRectMake(100, 300, 100, 40);
    [button_two setTitle:@"转正图片" forState:(UIControlStateNormal)];
    [button_two setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    [button_two addTarget:self action:@selector(onButtonTwo) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:button_two];
    UIButton * button_three = [[UIButton alloc]init];
    button_three.frame = CGRectMake(100, 350, 100, 40);
    [button_three setTitle:@"展示" forState:(UIControlStateNormal)];
    [button_three setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    [button_three addTarget:self action:@selector(onButtonThree) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:button_three];
    UIButton * button_four = [[UIButton alloc]init];
    button_four.frame = CGRectMake(100, 400, 100, 40);
    [button_four setTitle:@"图片选择" forState:(UIControlStateNormal)];
    [button_four setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    [button_four addTarget:self action:@selector(onButtonFour) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:button_four];
}
-(void)onButtonOne{
    [self.view endEditing:YES];
    if (pictureByte.text.length!=0) {
        NSData *data = [showImage.image compressQualityWithMaxLength:[pictureByte.text integerValue]];
        showPictureByte.text = [NSString stringWithFormat:@"%lu byte",(unsigned long)data.length];
        showImage.image = [UIImage imageWithData:data];
    }else{
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请输入压缩的大小。" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
    }
    
}
//旋转正图片（主要是ios拍照后进行压缩的图片上传到服务器都是左转90度的，用此方法转正图片）
-(void)onButtonTwo{
    [self.view endEditing:YES];
    UIImage *test = [SHMimageFixOrientation fixOrientation:showImage.image];
    showImage.image = test;
    
    
}
-(void)onButtonThree{
    [self.view endEditing:YES];
    [ShowPicture showImage:showImage];
}
-(void)onButtonFour{
    [self.view endEditing:YES];
    [self setImageView];
}

-(void)onButtonPicture{
    [self photocamera];
}
-(void)photocamera
{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIImagePickerController* imagepicker = [[UIImagePickerController alloc] init];
        imagepicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        imagepicker.delegate = self;
        
        
        
        [self presentViewController:imagepicker animated:YES completion:nil];
        
    }
    else {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"Sorry"
                              message:@"设备不支持拍照功能"
                              delegate:nil
                              cancelButtonTitle:@"确定"
                              otherButtonTitles:nil];
        [alert show];
        
    }
    
}
#pragma mark UIImagePicker method
- (void)imagePickerController:(UIImagePickerController *)picker
        didFinishPickingImage:(UIImage *)image
                  editingInfo:(NSDictionary *)editingInfo
{
    
    
    // NSData *imageData = UIImageJPEGRepresentation(newImage, 0.5);
    [showImage setImage:image];
    //[self updateVcard:imageData];
   
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}


// 完成选取
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}


-(void)setImageView{
    imageView = [[UIView alloc]initWithFrame:CGRectMake(15, 125, WIDTH-30, 200)];
    imageView.userInteractionEnabled = YES;
    imageView.backgroundColor = [UIColor colorWithRed:245/255.f green:235/255.f blue:235/255.f alpha:1];
    imageView.layer.borderWidth = 1;
    imageView.layer.borderColor = [UIColor redColor].CGColor;
    [self.view addSubview:imageView];
    [self setupViews];
    
}
- (void)setupViews{
    
    
    //2、初始化
    ACSelectMediaView *mediaView = [[ACSelectMediaView alloc] initWithFrame:CGRectMake(0, 0, imageView.frame.size.width, imageView.frame.size.height)];
    //3、选择媒体类型：是否仅选择图片或者其他的等
    mediaView.type = ACMediaTypePhoto;
    //4、随时获取新的布局高度
    [mediaView observeViewHeight:^(CGFloat value) {
        self->imageView.height = value;
    }];
    //5、随时获取已经选择的媒体文件
    [mediaView observeSelectedMediaArray:^(NSArray<ACMediaModel *> *list) {
        
        
        for (ACMediaModel *model in list) {
            NSLog(@"%@",model);
            
           
        }
        
    }];
    
    [imageView addSubview:mediaView];
    
    
    
}
@end
