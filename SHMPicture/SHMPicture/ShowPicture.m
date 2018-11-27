//
//  ShowPicture.m
//  Terminus
//
//  Created by apple on 15/12/10.
//  Copyright © 2015年 gtzt. All rights reserved.
//

#import "ShowPicture.h"
static CGRect oldframe;
@implementation ShowPicture
+(void)showImage:(UIImageView *)avatarImageView
{
    UIImage *image = avatarImageView.image;
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    
    UIView *backgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight)];
    [[UIApplication sharedApplication].keyWindow addSubview:backgroundView];
    oldframe = [avatarImageView convertRect:avatarImageView.bounds toView:[UIApplication sharedApplication].keyWindow];
    backgroundView.backgroundColor = [UIColor blackColor];
    backgroundView.alpha = 0;
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:oldframe];
    imageView.layer.cornerRadius = 8.0;
    imageView.layer.masksToBounds = YES;
    imageView.image = image;
    imageView.tag = 17856;
    [backgroundView addSubview:imageView];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideImage:)];
    
    [backgroundView addGestureRecognizer: tap];
    
    [UIView animateWithDuration:0.8 animations:^{
        imageView.frame = CGRectMake(0, screenHeight/2 - screenWidth/2, screenWidth, screenWidth);
        backgroundView.alpha = 1;
    } completion:nil];
}

+(void)hideImage:(UITapGestureRecognizer*)tap
{
    UIView *backgroundView = tap.view;
    UIImageView *imageView = (UIImageView*)[tap.view viewWithTag:17856];
    [UIView animateWithDuration:0.8 animations:^{
        imageView.frame = oldframe;
        backgroundView.alpha = 0;
    } completion:^(BOOL finished){
        [backgroundView removeFromSuperview];
    }];
}

@end
