//  Constants.h
// Constants used in 2Swap

#define kPlayerSpriteZValue 100
#define kPlayerSpriteTagValue 0
#define kPlayerIdleTimer 3.0f
#define kPlayerFistDamage 10
#define kPlayerMalletDamage 40
//#define kRadarDishTagValue 10

#define kMainMenuTagValue 10
#define kSceneMenuTagValue 20
#define kGIndexFilterPlayerBlackTagValue 1
#define kGIndexFilterPlayerRedTagValue 2
#define kGIndexFilterStaticPlatformerTagValue 3
#define kGIndexFilterBlackPlatformerTagValue 4
#define kGIndexFilterRedPlatformerTagValue 5
#define kGIndexFilterGoalTagValue 6

typedef enum {
    kNoSceneUninitialized=0,
    kMainMenuScene=1,
    kOptionsScene=2,
    kCreditsScene=3,
    kIntroScene=4,
    kLevelCompleteScene=5,
    kChapterSelectionScene=6,
    kLevelSelectionScene=7,
    kGameLevel1=101,
    kGameLevel2=102,
    kGameLevel3=103,
    kGameLevel4=104,
    kGameLevel5=105,
    kCutSceneForLevel2=201
} SceneTypes;

typedef enum {
    kLinkTypeBookSite,
    kLinkTypeDeveloperSiteRod,
    kLinkTypeDeveloperSiteRay,
    kLinkTypeArtistSite,
    kLinkTypeMusicianSite
} LinkTypes;

// Debug Enemy States with Labels
// 0 for OFF, 1 for ON
#define ENEMY_STATE_DEBUG 0
#define kFontScaleHuge 6;
#define kFontScaleLarge 9;
#define kFontScaleMedium 10;
#define kFontScaleSmall 12;
#define kFontScaleTiny 14;