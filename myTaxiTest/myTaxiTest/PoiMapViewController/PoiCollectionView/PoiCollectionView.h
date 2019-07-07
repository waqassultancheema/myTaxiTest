//
//  PoiCollectionView.h
//  myTaxiTest
//
//  Created by Waqas Sultan on 6/30/19.
//  Copyright © 2019 Waqas Sultan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class PoiListItemViewModel;
@interface PoiCollectionView : UICollectionView<UICollectionViewDelegate,UICollectionViewDataSource>


@property (nonatomic,strong) NSMutableArray *dataItems;
@end

NS_ASSUME_NONNULL_END
