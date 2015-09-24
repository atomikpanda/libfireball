#import <UIKit/UIKit.h>
#import <substrate.h>
#import <spawn.h>
#import <Social/Social.h>

// Call after [super viewWillAppear:animated]
void FBSetPrefsTint(UIViewController *prefs, UIColor *tintColor);

// Call after [super viewWillDisappear:animated]
void FBResetPrefsTint(UIViewController *prefs);

void FBKillProcess(NSString *signal, NSString *processName);

// Call this in -loadView to add a share button.
void FBAddTwitterShareButton(UIViewController *prefs, UIImage *twitterIcon, NSString *shareText);
