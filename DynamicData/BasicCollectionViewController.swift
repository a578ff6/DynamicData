//
//  BasicCollectionViewController.swift
//  DynamicData
//
//  Created by 曹家瑋 on 2023/11/12.
//

// MARK: - 未實作UICollectionViewDiffableDataSource
/*
import UIKit

private let reuseIdentifier = "itemCell"

private let items = [
    "星巴克拿鐵", "焦糖瑪奇朵", "美式咖啡", "摩卡", "卡布奇諾", "香草拿鐵", "焦糖瑪其朵",
    "濃縮咖啡", "冷萃咖啡", "星冰樂", "抹茶星冰樂", "草莓星冰樂", "芒果星冰樂", "巧克力星冰樂",
    "柚子蜂蜜茶", "茉莉花茶", "英式早餐茶", "伯爵茶拿鐵", "綠茶拿鐵", "蜂蜜柚子茶",
    "檸檬蜜茶", "檸檬綠茶", "蜂蜜薄荷茶", "冰搖桃桃綠茶", "冰搖芒果綠茶", "焦糖咖啡",
    "香草星冰樂", "巧克力可可星冰樂", "冰搖濃郁咖啡", "冰搖檸檬茶", "抹茶拿鐵", "椰奶抹茶拿鐵",
    "香草濃縮咖啡", "冷萃奶蓋咖啡", "櫻花星冰樂", "榛果拿鐵", "南瓜香料拿鐵", "薑餅拿鐵",
    "椰奶咖啡", "杏仁奶咖啡", "豆乳咖啡", "黑糖瑪奇朵", "黑咖啡", "熱巧克力", "焦糖熱可可"
]

class BasicCollectionViewController: UICollectionViewController {
    
    /// 初始化搜尋控制器
    let searchController = UISearchController()
    /// 複製一份原始資料。儲存篩選搜尋的結果。
    var filteredItems: [String] = items
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.searchController = searchController              // 把 searchController 加到 navigationItem 。
        searchController.obscuresBackgroundDuringPresentation = false   // 設定在輸入搜尋內容時不遮蓋其他內容。
        searchController.searchResultsUpdater = self                    // 指定自己為處理搜尋結果的更新者。
        navigationItem.hidesSearchBarWhenScrolling = false              // 確保搜尋欄在滾動時也能看到。

        collectionView.setCollectionViewLayout(generateLayout(), animated: false)
    }

    /// 產生CollectionViewLayout
    private func generateLayout() -> UICollectionViewLayout {
        
        let spacing: CGFloat = 10.0
        
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(1.0))
        )
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .absolute(70)
            ),
            subitem: item,
            count: 1
        )
        
        group.contentInsets = NSDirectionalEdgeInsets(
            top: spacing,
            leading: spacing,
            bottom: 0,
            trailing: spacing
        )
        
        let section = NSCollectionLayoutSection(group: group)
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        return layout
    }
    

    // MARK: - UICollectionViewDataSource
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredItems.count  // 使用篩選後的項目數量
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? BasicCollectionViewCell else {
            fatalError("Unable to dequeue BasicCollectionViewCell")
        }
        
        cell.itemLabel.text = filteredItems[indexPath.item]     // 設定每個單元格的內容為篩選後的項目
        return cell
    }
    
}

// MARK: - 搜尋結果更新的擴展
extension BasicCollectionViewController: UISearchResultsUpdating {
 
    func updateSearchResults(for searchController: UISearchController) {
        
        if let searchString = searchController.searchBar.text, !searchString.isEmpty {
            // 若搜尋欄有內容，則篩選出包含搜尋字串的項目
            filteredItems = items.filter({ (item) -> Bool in
                item.localizedCaseInsensitiveContains(searchString)
            })
        } else {
            // 若搜尋欄無內容，則顯示所有項目
            filteredItems = items
        }
        // 重新載入集合視圖來顯示更新後的數據
        collectionView.reloadData()
    }
    
}
*/




// MARK: - 實作 UICollectionViewDiffableDataSource
 import UIKit

 private let reuseIdentifier = "itemCell"

 private let items = [
     "星巴克拿鐵", "焦糖瑪奇朵", "美式咖啡", "摩卡", "卡布奇諾", "香草拿鐵", "焦糖瑪其朵",
     "濃縮咖啡", "冷萃咖啡", "星冰樂", "抹茶星冰樂", "草莓星冰樂", "芒果星冰樂", "巧克力星冰樂",
     "柚子蜂蜜茶", "茉莉花茶", "英式早餐茶", "伯爵茶拿鐵", "綠茶拿鐵", "蜂蜜柚子茶",
     "檸檬蜜茶", "檸檬綠茶", "蜂蜜薄荷茶", "冰搖桃桃綠茶", "冰搖芒果綠茶", "焦糖咖啡",
     "香草星冰樂", "巧克力可可星冰樂", "冰搖濃郁咖啡", "冰搖檸檬茶", "抹茶拿鐵", "椰奶抹茶拿鐵",
     "香草濃縮咖啡", "冷萃奶蓋咖啡", "櫻花星冰樂", "榛果拿鐵", "南瓜香料拿鐵", "薑餅拿鐵",
     "椰奶咖啡", "杏仁奶咖啡", "豆乳咖啡", "黑糖瑪奇朵", "黑咖啡", "熱巧克力", "焦糖熱可可"
 ]

 class BasicCollectionViewController: UICollectionViewController {
     
     // MARK: - Properties

     /// 定義 CollectionView 中的Section，這裡只有一個Section。
     enum Section: CaseIterable {
         case main
     }

     /// 初始化搜尋控制器
     let searchController = UISearchController()
     /// 複製一份原始資料。儲存篩選搜尋的結果。
     var filteredItems: [String] = items
     
     /// 定義集合視圖的資料來源，使用自訂的 Section 和 String 類型。用於管理 CollectionView 的資料
     var dataSource: UICollectionViewDiffableDataSource<Section, String>!
     
     /// 產生並回傳目前篩選結果的Snapshot
     var filteredItemsSnapshot: NSDiffableDataSourceSnapshot<Section, String> {
         var snapshot = NSDiffableDataSourceSnapshot<Section, String>()
         // 加入Section、篩選後的Item。
         snapshot.appendSections([.main])
         snapshot.appendItems(filteredItems)
         
         return snapshot
     }
     
     // MARK: - View Lifecycle

     override func viewDidLoad() {
         super.viewDidLoad()
         
         navigationItem.searchController = searchController              // 把 searchController 加到 navigationItem 。
         searchController.obscuresBackgroundDuringPresentation = false   // 設定在輸入搜尋內容時不遮蓋其他內容。
         searchController.searchResultsUpdater = self                    // 指定自己為處理搜尋結果的更新者。
         navigationItem.hidesSearchBarWhenScrolling = false              // 確保搜尋欄在滾動時也能看到。

         collectionView.setCollectionViewLayout(generateLayout(), animated: false)  // 設定集合視圖的佈局
         
         // 創建並配置資料來源
         createDataSource()
     }

     // MARK: - DataSource Configuration

     /// 創建並配置 DataSource ，用於管理 CollectionView 的資料
     func createDataSource() {
         // 用於連結 CollectionView 和顯示的資料。
         dataSource = UICollectionViewDiffableDataSource<Section, String>(
             collectionView: collectionView,
             cellProvider: { (collectionView, indexPath, item) -> UICollectionViewCell? in
                 guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? BasicCollectionViewCell else {
                     fatalError("Unable to dequeue BasicCollectionViewCell")
                 }
                 cell.itemLabel.text = item
                 return cell
             })
         
         // 套用資料快照來更新視圖
         dataSource.apply(filteredItemsSnapshot)
     }
     
     // MARK: - Layout Configuration

     /// 產生CollectionViewLayout
     private func generateLayout() -> UICollectionViewLayout {
         
         let spacing: CGFloat = 10.0
         
         let item = NSCollectionLayoutItem(
             layoutSize: NSCollectionLayoutSize(
                 widthDimension: .fractionalWidth(1.0),
                 heightDimension: .fractionalHeight(1.0))
         )
         
         let group = NSCollectionLayoutGroup.horizontal(
             layoutSize: NSCollectionLayoutSize(
                 widthDimension: .fractionalWidth(1.0),
                 heightDimension: .absolute(70)
             ),
             subitem: item,
             count: 1
         )
         
         group.contentInsets = NSDirectionalEdgeInsets(
             top: spacing,
             leading: spacing,
             bottom: 0,
             trailing: spacing
         )
         
         let section = NSCollectionLayoutSection(group: group)
         
         let layout = UICollectionViewCompositionalLayout(section: section)
         
         return layout
     }
     
 }

 // MARK: - 搜尋結果更新的擴展
 extension BasicCollectionViewController: UISearchResultsUpdating {
  
     /// 更新搜尋結果
     func updateSearchResults(for searchController: UISearchController) {
         
         if let searchString = searchController.searchBar.text, !searchString.isEmpty {
             // 若搜尋欄有內容，則篩選出包含搜尋字串的項目
             filteredItems = items.filter({ (item) -> Bool in
                 item.localizedCaseInsensitiveContains(searchString)
             })
         } else {
             // 若搜尋欄無內容，則顯示所有項目
             filteredItems = items
         }
         
         dataSource.apply(filteredItemsSnapshot, animatingDifferences: true)
     }
     
 }
