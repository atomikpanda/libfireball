#import <UIKit/UIKit.h>
#import <substrate.h>
#import <spawn.h>
#import <Social/Social.h>

void FBSetPrefsTint(UIViewController *prefs, UIColor *tintColor);
void FBResetPrefsTint(UIViewController *prefs);
void FBKillProcess(NSString *signal, NSString *processName);
void FBAddTwitterShareButton(UIViewController *prefs, UIImage *twitterIcon, NSString *shareText);
