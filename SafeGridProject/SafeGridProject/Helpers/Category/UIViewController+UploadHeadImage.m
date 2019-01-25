//
//  UIViewController+UploadHeadImage.m
//  JingHuaTimes
//
//  Created by zhouyongchao on 16/2/1.
//  Copyright © 2016年 zhouyongchao. All rights reserved.
//

#import "UIViewController+UploadHeadImage.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import <objc/runtime.h>

static const char *uploadPicDataKey = "uploadPicDataKey";
static const char *uploadImageKey = "uploadImage";


@implementation UIViewController (UploadHeadImage)

- (void)uploadButtonClicked:(UIButton *)sender {
    
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];

    UIAlertAction *takePicAction = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self takePhoto];
    }];
    if (@available(iOS 8.4, *)) {
        [takePicAction setValue:COLOR_WITH_HEX(0x3B5998) forKey:@"titleTextColor"];
    }
    

    UIAlertAction *assetAction = [UIAlertAction actionWithTitle:@"从相册选取" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self pushTZImagePickerController];
    }];
    if (@available(iOS 8.4, *)) {
        [assetAction setValue:COLOR_WITH_HEX(0x3B5998) forKey:@"titleTextColor"];
    }
    

    UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {

    }];
    if (@available(iOS 8.4, *)) {
        [cancleAction setValue:COLOR_WITH_HEX(0x333333) forKey:@"titleTextColor"];
    }
    

    [alertVC addAction:takePicAction];
    [alertVC addAction:assetAction];
    [alertVC addAction:cancleAction];

    [self presentViewController:alertVC animated:YES completion:nil];
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    TZImagePickerController *tzImagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 delegate:self];
    tzImagePickerVc.sortAscendingByModificationDate = YES;
    [tzImagePickerVc showProgressHUD];
    
    if ([type isEqualToString:@"public.image"]) {
        
        UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
        // save photo and get asset / 保存图片，获取到asset
        [[TZImageManager manager] savePhotoWithImage:image location:self.location completion:^(PHAsset *asset, NSError *error) {
            [tzImagePickerVc hideProgressHUD];
            if (error) {
                NSLog(@"图片保存失败 %@",error);
            } else {
                TZAssetModel *assetModel = [[TZImageManager manager] createModelWithAsset:asset];
                if (self.allowCrop) { // 允许裁剪,去裁剪
                    TZImagePickerController *imagePicker = [[TZImagePickerController alloc] initCropTypeWithAsset:assetModel.asset photo:image completion:^(UIImage *cropImage, id asset) {
                        self.uploadImage = cropImage;
                        self.uploadPicData = UIImageJPEGRepresentation(cropImage, 1.0);
                        
                        [[NSNotificationCenter defaultCenter] postNotificationName:kSelectedAvatarSuccessNotification object:nil];
                    }];
                    imagePicker.allowCrop = [self allowCrop];
                    imagePicker.allowPickingImage = YES;
                    imagePicker.needCircleCrop = self.needCircleCrop;
                    imagePicker.circleCropRadius = 120;
                    imagePicker.cropRect = CGRectMake(0, (CGRectGetHeight(self.view.bounds) - SCREEN_WIDTH) / 2.f, SCREEN_WIDTH, SCREEN_WIDTH);
                    [self presentViewController:imagePicker animated:YES completion:nil];
                } else {
//                    [self.view showWaitStatusHUDWithMsg:@"正在压缩..."];
//                    UIImage *compressImage = [self compressImageQuality:image toByte:1024 * 500];
//                    [self.view hideHUDView];
                    self.uploadImage = image;
                    self.uploadPicData = UIImageJPEGRepresentation(image, 0.5);

                    [[NSNotificationCenter defaultCenter] postNotificationName:kSelectedAvatarSuccessNotification object:nil];
                }
            }
        }];
        
    }
    
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (UIImage *)compressImageQuality:(UIImage *)image toByte:(NSInteger)maxLength {
    
    CGFloat compression = 1;
    NSData *data = UIImageJPEGRepresentation(image, compression);
    if (data.length < maxLength) return image;
    CGFloat max = 1;
    CGFloat min = 0;
    for (int i = 0; i < 6; ++i) {
        compression = (max + min) / 2;
        data = UIImageJPEGRepresentation(image, compression);
        if (data.length < maxLength * 0.9) {
            min = compression;
        } else if (data.length > maxLength) {
            max = compression;
        } else {
            break;
        }
    }
    UIImage *resultImage = [UIImage imageWithData:data];
    
    return resultImage;
}

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) { // 去设置界面，开启相机访问权限
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
    }
}

#pragma mark - private methods

- (void)takePhoto {
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if ((authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied)) {
        // 无相机权限 做一个友好的提示
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"无法使用相机" message:@"请在iPhone的""设置-隐私-相机""中允许访问相机" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"设置", nil];
        [alert show];
    } else if (authStatus == AVAuthorizationStatusNotDetermined) {
        //  防止用户首次拍照拒绝授权时相机页黑屏
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
            if (granted) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self takePhoto];
                });
            }
        }];
        // 拍照之前还需要检查相册权限
    } else if ([PHPhotoLibrary authorizationStatus] == 2) { // 已被拒绝，没有相册权限，将无法保存拍的照片
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"无法访问相册" message:@"请在iPhone的""设置-隐私-相册""中允许访问相册" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"设置", nil];
        [alert show];
    } else if ([PHPhotoLibrary authorizationStatus] == 0) { // 未请求过相册权限
        [[TZImageManager manager] requestAuthorizationWithCompletion:^{
            [self takePhoto];
        }];
    } else {
        
        [self pushImagePickerController];
    }
}

- (void)pushImagePickerController {
    
    self.definesPresentationContext = YES;
    UIImagePickerController *_imagePickerVc = [[UIImagePickerController alloc] init];
    _imagePickerVc.modalPresentationStyle = UIModalPresentationCustom;
    _imagePickerVc.delegate = self;
    // set appearance / 改变相册选择页的导航栏外观
    _imagePickerVc.navigationBar.barTintColor = NavigationColor;
    _imagePickerVc.navigationBar.tintColor = [UIColor whiteColor];
    UIBarButtonItem *tzBarItem, *BarItem;
    if (@available(iOS 9, *)) {
        tzBarItem = [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[TZImagePickerController class]]];
        BarItem = [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[UIImagePickerController class]]];
    } else {
        tzBarItem = [UIBarButtonItem appearanceWhenContainedIn:[TZImagePickerController class], nil];
        BarItem = [UIBarButtonItem appearanceWhenContainedIn:[UIImagePickerController class], nil];
    }
    NSDictionary *titleTextAttributes = [tzBarItem titleTextAttributesForState:UIControlStateNormal];
    [BarItem setTitleTextAttributes:titleTextAttributes forState:UIControlStateNormal];
    
    // 提前定位
    __weak typeof(self) weakSelf = self;
    [[TZLocationManager manager] startLocationWithSuccessBlock:^(NSArray<CLLocation *> *locations) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        strongSelf.location = [locations firstObject];
    } failureBlock:^(NSError *error) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        strongSelf.location = nil;
    }];
    
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
        _imagePickerVc.sourceType = sourceType;
        NSMutableArray *mediaTypes = [NSMutableArray array];
        [mediaTypes addObject:(NSString *)kUTTypeImage];
        if (mediaTypes.count) {
            _imagePickerVc.mediaTypes = mediaTypes;
        }
        [self presentViewController:_imagePickerVc animated:YES completion:nil];
    } else {
        NSLog(@"模拟器中无法打开照相机,请在真机中使用");
    }
}

- (void)pushTZImagePickerController {
    TZImagePickerController *imagePickerVC = [[TZImagePickerController alloc]initWithMaxImagesCount:1 delegate:self];
    imagePickerVC.naviBgColor = NavigationColor;
    imagePickerVC.naviTitleColor = [UIColor whiteColor];
    
    imagePickerVC.allowTakePicture = NO;
    imagePickerVC.allowPickingOriginalPhoto = NO;
    imagePickerVC.allowPickingVideo = NO;
    imagePickerVC.allowCrop = [self allowCrop];
    imagePickerVC.needCircleCrop = [self needCircleCrop];
    imagePickerVC.circleCropRadius = 120;
    imagePickerVC.cropRect = CGRectMake(0, (CGRectGetHeight(self.view.bounds) - SCREEN_WIDTH) / 2.f, SCREEN_WIDTH, SCREEN_WIDTH);
    imagePickerVC.needShowStatusBar = NO;
    
    imagePickerVC.modalPresentationStyle = UIModalPresentationCurrentContext;
    [imagePickerVC setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos,NSArray *assets,BOOL isSelectOriginalPhoto) {
        
        self.uploadImage = photos[0];
        self.uploadPicData = UIImageJPEGRepresentation(self.uploadImage, 1.0);
        
        [[NSNotificationCenter defaultCenter] postNotificationName:kSelectedAvatarSuccessNotification object:nil];
        
    }];
    
    imagePickerVC.modalPresentationStyle = UIModalPresentationCustom;
    [self presentViewController:imagePickerVC animated:YES completion:nil];
}

#pragma mark - getters and setters

- (NSData *)uploadPicData {
    return (NSData *)objc_getAssociatedObject(self, uploadPicDataKey);
}

- (UIImage *)uploadImage {
    return (UIImage *)objc_getAssociatedObject(self, uploadImageKey);
}

- (BOOL)allowCrop {
    return [(NSNumber*)objc_getAssociatedObject(self, @selector(allowCrop)) boolValue];
}

- (BOOL)needCircleCrop {
    return [(NSNumber *)objc_getAssociatedObject(self, @selector(needCircleCrop)) boolValue];
}

- (CLLocation *)location {
    return objc_getAssociatedObject(self, @selector(location));
}

- (void)setUploadPicData:(NSData *)uploadPicData {
    objc_setAssociatedObject(self, uploadPicDataKey, uploadPicData, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setUploadImage:(UIImage *)uploadImage {
    objc_setAssociatedObject(self, uploadImageKey, uploadImage, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setAllowCrop:(BOOL)allowCrop {
    objc_setAssociatedObject(self, @selector(allowCrop), [NSNumber numberWithBool:allowCrop], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setNeedCircleCrop:(BOOL)needCircleCrop {
    objc_setAssociatedObject(self, @selector(needCircleCrop), [NSNumber numberWithBool:needCircleCrop], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setLocation:(CLLocation *)location {
    objc_setAssociatedObject(self, @selector(location), location, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
