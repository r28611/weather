//
//  WeatherCollectionViewController.swift
//  weather
//
//  Created by Margarita Novokhatskaia on 31.12.2020.
//

import UIKit

class WeatherCollectionViewController: UICollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 30
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? WeatherCollectionViewCell {
            cell.dayLabel.text = "\(indexPath.row + 1)"
            cell.temperatureLabel.text = "\(Int.random(in: -5..<10))"
            switch cell.temperatureLabel.text {
            case "-5", "-4", "-3" :
                cell.weatherImage.image = UIImage(systemName: "snow")
            case "0" :
                cell.weatherImage.image = UIImage(systemName: "cloud")
            default:
                cell.weatherImage.image = UIImage(systemName: "sun.min")
            }
            
            return cell
        }
        return UICollectionViewCell()
    }

}

//extension WeatherCollectionViewController: UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: (view.frame.size.width / 3) - 1,
//                      height: (view.frame.size.width / 3) - 1 )
//    }
//    
//}

class WeatherCollectionViewLayout: UICollectionViewLayout {

    var cacheAttributes = [IndexPath: UICollectionViewLayoutAttributes]()
                                          // Хранит атрибуты для заданных индексов

    var columnsCount = 2                  // Количество столбцов
    
    var cellHeight: CGFloat = 128         // Высота ячейки

    private var totalCellsHeight: CGFloat = 0 // Хранит суммарную высоту всех ячеек
    
    override func prepare() {
        self.cacheAttributes = [:] // Инициализируем атрибуты
     
        // Проверяем наличие collectionView
        guard let collectionView = self.collectionView else { return }
        
        let itemsCount = collectionView.numberOfItems(inSection: 0)
        // Проверяем, что в секции есть хотя бы одна ячейка
        guard itemsCount > 0 else { return }
        
        
        let bigCellWidth = collectionView.frame.width
        let smallCellWidth = collectionView.frame.width / CGFloat(self.columnsCount)
        
        var lastY: CGFloat = 0
        var lastX: CGFloat = 0
            
        for index in 0..<itemsCount {
            let indexPath = IndexPath(item: index, section: 0)
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            
            let isBigCell = (index + 1) % (self.columnsCount + 1) == 0
            
            if isBigCell {
                attributes.frame = CGRect(x: 0, y: lastY,
                                          width: bigCellWidth, height: self.cellHeight)
                
                lastY += self.cellHeight
            } else {
                attributes.frame = CGRect(x: lastX, y: lastY,
                                          width: smallCellWidth, height: self.cellHeight)
                
                let isLastColumn = (index + 2) % (self.columnsCount + 1) == 0 || index == itemsCount - 1
                if isLastColumn {
                    lastX = 0
                    lastY += self.cellHeight
                } else {
                    lastX += smallCellWidth
                }
            }
            
            cacheAttributes[indexPath] = attributes
            self.totalCellsHeight = lastY
        }
    }

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return cacheAttributes.values.filter { attributes in
            return rect.intersects(attributes.frame)
        }
    }

    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return cacheAttributes[indexPath]
    }
    
    override var collectionViewContentSize: CGSize {
        return CGSize(width: self.collectionView?.frame.width ?? 0,
                      height: self.totalCellsHeight)
    }
    
}
