#import <UIKit/UIKit.h>

@class PSSpecifier;

#ifdef __cplusplus
extern "C" {
#endif
    

// Call after [super viewWillAppear:animated]
void FBSetPrefsTint(UIViewController *prefs, UIColor *tintColor);

// Call after [super viewWillDisappear:animated]
void FBResetPrefsTint(UIViewController *prefs);

PSSpecifier *FBVersionCopyrightSpecifier(NSString *packageIdentifier, NSString *copyrightName, NSString *yearMade);

void FBKillProcess(NSString *signal, NSString *processName);

// Call this in -loadView to add a share button.
void FBAddTwitterShareButton(UIViewController *prefs, UIImage *twitterIcon, NSString *shareText);
    
void FBShowTwitterFollowAlert(NSString *title, NSString *welcomeMessage, NSString *twitterUsername);

void FBOpenTwitterUsername(NSString *username);

void FBOpenMailAddress(NSString *email);

    
#ifdef __cplusplus
}
#endif