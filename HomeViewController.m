//
//  HomeViewController.m
//  GifCreat
//
//  Created by admin on 16/11/3.
//  Copyright © 2016年 LiuYQ. All rights reserved.
//

#import "HomeViewController.h"
#import "GetImage.h"
@interface HomeViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    NSURL *carmerurl;
    NSString *urlstr;
    NSString *resultPath;
}
@property (strong, nonatomic) IBOutlet UIButton *baseButton;
@property (strong, nonatomic) IBOutlet UIButton *NetButton;
@property (strong, nonatomic) IBOutlet UIImageView *imageview;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    urlstr = [[NSBundle mainBundle]pathForResource:@"test" ofType:@"mp4"];
    // Do any additional setup after loading the view from its nib.
}


-(void)setimageviewWithImagewithurl:(NSString *)url
{
    
    
    [_imageview setImage:[GetImage getImage:url]];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)ClickBaseButton:(id)sender {
    [self setimageviewWithImagewithurl:urlstr];
}
- (IBAction)ClickInternetButton:(id)sender {
    UIImagePickerController *imageController = [[UIImagePickerController alloc]init];
    imageController.sourceType = UIImagePickerControllerSourceTypeCamera;
    if (imageController.sourceType == UIImagePickerControllerSourceTypeCamera) {
        imageController.delegate = self;
        imageController.sourceType = UIImagePickerControllerSourceTypeCamera;//sourcetype有三种分别是camera，photoLibrary和photoAlbum
        NSArray *availableMedia = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera];//Camera所支持的Media格式都有哪些,共有两个分别是@"public.image",@"public.movie"
        imageController.mediaTypes = [NSArray arrayWithObject:availableMedia[1]];//设置媒体类型为public.movie
        [self presentViewController:imageController animated:YES completion:nil];
        imageController.videoMaximumDuration = 30.0f;//30秒
    }
    
}
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    carmerurl = [info objectForKey:UIImagePickerControllerMediaURL];
    
    [self Thecompressionvedio];
    [self dismissViewControllerAnimated:YES completion:nil];


}
-(void)Thecompressionvedio
{
    AVURLAsset *avasset = [AVURLAsset URLAssetWithURL:carmerurl options:nil];
    NSArray *compatiblePresets = [AVAssetExportSession exportPresetsCompatibleWithAsset:avasset];
        AVAssetExportSession *exportSession = [[AVAssetExportSession alloc] initWithAsset:avasset presetName:resultPath];
        NSDateFormatter *formater = [[NSDateFormatter alloc] init];//用时间给文件全名，以免重复，在测试的时候其实可以判断文件是否存在若存在，则删除，重新生成文件即可
        [formater setDateFormat:@"yyyy-MM-dd-HH:mm:ss"];
        resultPath = [NSHomeDirectory() stringByAppendingFormat:@"/Documents/output-%@.mp4", [formater stringFromDate:[NSDate date]]] ;
        exportSession.outputURL = [NSURL fileURLWithPath:resultPath];
        exportSession.outputFileType = AVFileTypeMPEG4;
        [exportSession exportAsynchronouslyWithCompletionHandler:^(void)
         {
             switch (exportSession.status) {
                 case AVAssetExportSessionStatusUnknown:
                     NSLog(@"AVAssetExportSessionStatusUnknown");
                     break;
                 case AVAssetExportSessionStatusWaiting:
                     NSLog(@"AVAssetExportSessionStatusWaiting");
                     break;
                 case AVAssetExportSessionStatusExporting:
                     NSLog(@"AVAssetExportSessionStatusExporting");
                     break;
                 case AVAssetExportSessionStatusCompleted:
                     NSLog(@"AVAssetExportSessionStatusCompleted");
                     break;
                 case AVAssetExportSessionStatusFailed:
                     NSLog(@"AVAssetExportSessionStatusFailed");
                     break;
             }
         }];

}
@end
