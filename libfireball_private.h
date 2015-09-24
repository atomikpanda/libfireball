#import "libfireball.h"

static NSString *FBDynamicYear(NSString *yearMade);

static inline Class FBGetClass(NSString *classname)
{
  return objc_getClass(classname.UTF8String);
}

@interface NSTask : NSObject

- (id)init;
- (void)launch;
- (void)setArguments:(id)arg1;
- (void)setLaunchPath:(id)arg1;
- (void)setStandardOutput:(id)arg1;
- (id)standardOutput;

@end

typedef enum PSCellType {
	PSGroupCell,
	PSLinkCell,
	PSLinkListCell,
	PSListItemCell,
	PSTitleValueCell,
	PSSliderCell,
	PSSwitchCell,
	PSStaticTextCell,
	PSEditTextCell,
	PSSegmentCell,
	PSGiantIconCell,
	PSGiantCell,
	PSSecureEditTextCell,
	PSButtonCell,
	PSEditTextViewCell,
} PSCellType;

@interface PSSpecifier : NSObject

+ (id)preferenceSpecifierNamed:(NSString *)title target:(id)target set:(SEL)set get:(SEL)get detail:(Class)detail cell:(PSCellType)cell edit:(Class)edit;
- (id)propertyForKey:(NSString *)key;
- (void)setProperty:(id)property forKey:(NSString *)key;

@end
