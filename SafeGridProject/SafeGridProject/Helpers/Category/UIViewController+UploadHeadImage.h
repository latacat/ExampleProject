//
//  UIViewController+UploadHeadImage.h
//  JingHuaTimes
//
//  Created by zhouyongchao on 16/2/1.
//  Copyright © 2016年 zhouyongchao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TZImagePickerController.h"
#import "TZImageManager.h"

@interface UIViewController (UploadHeadImage)<UIImagePickerControllerDelegate,UINavigationControllerDelegate,TZImagePickerControllerDelegate>
/**
 *  上传的二级制数据
 */
@property (strong, nonatomic) NSData *uploadPicData;
/**
 *  上传的图片
 */
@property (strong, nonatomic) UIImage *uploadImage;

@property (assign, nonatomic) BOOL allowCrop;

@property (assign, nonatomic) BOOL needCircleCrop;

@property (nonatomic, nullable, strong) CLLocation *location;

/**
 *  上传头像
 *
 *  @param sender 上传按钮
 */
- (void)uploadButtonClicked:(UIButton *)sender;

/**
 相机拍照
 */
- (void)takePhoto;

/**
 跳转相册
 */
- (void)pushTZImagePickerController;

@end
