//
//  PoiCollectionView.m
//  myTaxiTest
//
//  Created by Waqas Sultan on 6/30/19.
//  Copyright © 2019 Waqas Sultan. All rights reserved.
//

#import "PoiCollectionView.h"
#import "PoiCollectionViewCell.h"
#import "myTaxiTest-Swift.h"
@interface PoiCollectionView()<UICollectionViewDelegate,UICollectionViewDataSource>
 


@end

@implementation PoiCollectionView


- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self setShowsHorizontalScrollIndicator:false];
    [self setShowsVerticalScrollIndicator:false];
    [self setDelegate:self];
    [self setDataSource:self];
    
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataItems.count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PoiCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"PoiCollectionViewCell" forIndexPath:indexPath];
    
    PoiListItemViewModel *item = [self.dataItems objectAtIndex:indexPath.row];
    
    [cell.lblTitle setText:item.fleetType];
    [cell.imageView setImage:[UIImage imageNamed:item.imageName]];

    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(200, 200);
}
@end
