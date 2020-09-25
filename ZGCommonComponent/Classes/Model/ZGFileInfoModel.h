//
//  ZGFileInfoModel.h
//  ZGStudentServices
//
//  Created by zhouluyao on 9/14/20.
//  Copyright © 2020 offcn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, ZGCacheCourseStatus){
    ZGCacheCourseStatusNormal,
    ZGCacheCourseStatusClose,
    ZGCacheCourseStatusExpired,
};

//0-暂停，1-正在下载，2-将要下载
typedef NS_ENUM(NSUInteger, ZGFileDownloadStatus) {
    ZGFileDownloadStatusSuspend = 0, // 暂停中
    ZGFileDownloadStatusResumed,  // 下载中
    ZGFileDownloadStatusWillResume //即将下载（等待下载）
};



@interface ZGFileInfoModel : NSObject

@property (nonatomic, copy) NSString *fileID;
@property (nonatomic, copy) NSString *fileName;
@property (nonatomic, copy) NSString *fileSize;
@property (nonatomic, copy) NSString *fileType;
// 0:@"Video" ;1:@"Audio";2:@"Image";3:@"File"4:Record

@property (nonatomic) BOOL isFirstReceived;//是否是第一次接受数据，如果是则不累加第一次返回的数据长度，之后变累加
@property (nonatomic, copy) NSString *fileReceivedSize;
@property (nonatomic, copy)NSMutableData *fileReceivedData;//接受的数据
@property (nonatomic, copy) NSString *fileURL;
@property (nonatomic, copy) NSString *time;
@property (nonatomic, copy) NSString *targetPath;
@property (nonatomic, copy) NSString *tempPath;
@property (nonatomic, copy) NSString *fileDownloadStatus; //0-暂停，1-正在下载，2-将要下载
/*下载状态的逻辑是这样的：三种状态，下载中，等待下载，停止下载

当超过最大下载数时，继续添加的下载会进入等待状态，当同时下载数少于最大限制时会自动开始下载等待状态的任务。
可以主动切换下载状态
所有任务以添加时间排序。
*/
@property ZGFileDownloadStatus downloadState;//课件的状态
@property (nonatomic) BOOL error;
@property (nonatomic, copy) NSString *MD5;
@property (nonatomic, copy) UIImage *fileimage;

@property (nonatomic, copy) NSString *fileTitle;//课件的名字
@property (nonatomic, copy) NSString *courseTitle;//课程的名字

@property (nonatomic, copy) NSString *resourceType;//资源类型，视频（1,2），回放(101,102)，资料(9)

@property (nonatomic, copy) NSString *courseImageUrl;//课程图片链接

@property (nonatomic, copy) NSString *classId;//课程ID

@property (nonatomic, copy) NSString *keyS;

@property (nonatomic, assign) BOOL selected;

@property (nonatomic, assign) ZGCacheCourseStatus cacheCStatus;

@property (nonatomic, copy) NSString *grade_name;//班级名字
@property (nonatomic, copy) NSString *gradeId;//班级ID
@property (nonatomic, copy) NSString *download_source;//下载来源

/*-----------------------------视频Model------------------------------*/

@property (nonatomic, copy) NSString *introduction;//视频简介
@property (nonatomic, copy) NSString *videoKey;//视频key
@property (nonatomic, copy) NSString *lastTime;//上次观看的时间
@property (nonatomic, copy) NSString *lengthTime;//视频长度
@property (nonatomic, copy) NSString *lessonTitle;//课件title
@property (nonatomic, copy) NSString *lessonType;//视频类型
@property (nonatomic, copy) NSString *videoName;//视频名字
@property (nonatomic, copy) NSString *videoSize;//视频大小
@property (nonatomic, copy) NSString *videoUrl;//视频URL
@property (nonatomic, copy) NSString *videoImage;//视频图片
@property (nonatomic, copy) NSString *videoType;//视频类型

@property (nonatomic, copy) NSString *courseImageURL;//课程图片的链接

@property (nonatomic, copy) NSString *courseID;//课程ID
@property (nonatomic, copy) NSString *lessonID;//课件ID

@property (nonatomic, copy) NSString *downloadName;//下载文件的名字

@property (nonatomic, copy) NSString *pathUrl;

@property (nonatomic, copy) NSString *gradeName;//班级名字
@property (nonatomic, copy) NSString *downloadSource;//下载来源


/*-----------------------------文件Model------------------------------*/

@end

NS_ASSUME_NONNULL_END
